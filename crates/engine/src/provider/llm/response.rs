// ── Response Parsing ─────────────────────────────────────────────────────────
//
// The translation prompts ask the model for
// `{"translations": [{"text": ...}]}`, so a reply is an envelope, not the
// translation. Models also wrap that envelope in a Markdown fence, or ignore
// the instruction and answer in plain prose. Nothing downstream should have to
// know any of that, so every reply — streamed or not — is read back through
// here.

use serde_json::Value;

/// Keys a model may put the translated text under.
const TEXT_KEYS: [&str; 2] = ["text", "translation"];

/// The translations carried by an LLM reply, in the order the model gave them.
///
/// Always returns at least one entry: a reply that cannot be read as the
/// expected envelope is handed back verbatim, because showing the model's own
/// words beats showing nothing.
pub fn translated_texts(content: &str) -> Vec<String> {
    if let Some(texts) = parse_envelope(json_payload(content)) {
        return texts;
    }

    // Truncated or malformed JSON never parses as a whole, but the text inside
    // it is usually still readable; the streaming scanner does that reading.
    let mut stream = TranslationStream::new();
    let mut text = stream.push(content);
    text.push_str(&stream.finish());
    vec![text]
}

/// The JSON inside `content`: the body of a Markdown code fence when there is
/// one, narrowed to the outermost `{...}` so a chatty preamble is dropped.
/// Returns `content` unchanged when it holds nothing that looks like JSON.
pub fn json_payload(content: &str) -> &str {
    let trimmed = strip_code_fence(content.trim());
    match (trimmed.find('{'), trimmed.rfind('}')) {
        (Some(start), Some(end)) if start < end => &trimmed[start..=end],
        _ => trimmed,
    }
}

fn strip_code_fence(content: &str) -> &str {
    let Some(after_ticks) = content.strip_prefix("```") else {
        return content;
    };
    // The opening line may carry an info string (```json).
    let Some(newline) = after_ticks.find('\n') else {
        return content;
    };
    let body = &after_ticks[newline + 1..];
    body.trim_end().strip_suffix("```").unwrap_or(body).trim()
}

fn parse_envelope(payload: &str) -> Option<Vec<String>> {
    let value: Value = serde_json::from_str(payload).ok()?;

    let texts = match value.get("translations") {
        Some(Value::Array(entries)) => entries.iter().filter_map(entry_text).collect(),
        _ => entry_text(&value).into_iter().collect::<Vec<_>>(),
    };

    let texts: Vec<String> = texts
        .into_iter()
        .filter(|text: &String| !text.trim().is_empty())
        .collect();
    (!texts.is_empty()).then_some(texts)
}

/// One translation, whether the model wrote it as `"..."` or as
/// `{"text": "..."}`.
fn entry_text(value: &Value) -> Option<String> {
    match value {
        Value::String(text) => Some(text.clone()),
        Value::Object(_) => TEXT_KEYS
            .iter()
            .find_map(|key| value.get(key)?.as_str())
            .map(str::to_owned),
        _ => None,
    }
}

fn is_text_key(key: &str) -> bool {
    TEXT_KEYS.contains(&key)
}

// ── Streaming ────────────────────────────────────────────────────────────────

/// Pulls the translation out of a reply as it arrives, so the envelope never
/// reaches the screen even one chunk at a time.
///
/// The scanner decides from the first non-blank character whether the model
/// obeyed the JSON instruction. When it did, only the string values of `text`
/// keys are emitted, unescaped as they stream; when it did not, the reply
/// passes straight through. A reply that yields nothing at all is emitted
/// verbatim by [`TranslationStream::finish`].
#[derive(Debug)]
pub struct TranslationStream {
    state: State,
    /// Everything seen so far, held only until the first character of a
    /// translation is emitted, so an unreadable reply can still be shown.
    raw: String,
    emitted: bool,
    /// Whether an opening ``` fence was stripped, in which case a trailing one
    /// has to be held back too.
    fenced: bool,
    hold: String,
    key: String,
    decoder: StringDecoder,
    values: usize,
}

#[derive(Debug, Clone, Copy, PartialEq)]
enum State {
    /// Nothing decisive seen yet.
    Undecided,
    /// Consuming the rest of an opening fence line.
    FenceInfo,
    /// Not JSON: everything passes through.
    Plain,
    /// Inside JSON, between string tokens.
    Scan,
    /// Inside a string token, capturing it in case it is a key.
    Key,
    /// A string token ended; a `:` would make it a key.
    AfterKey,
    /// Saw a text key and its `:`; waiting for the opening quote.
    BeforeValue,
    /// Inside a translation, emitting it.
    Value,
}

impl Default for TranslationStream {
    fn default() -> Self {
        Self::new()
    }
}

impl TranslationStream {
    pub fn new() -> Self {
        Self {
            state: State::Undecided,
            raw: String::new(),
            emitted: false,
            fenced: false,
            hold: String::new(),
            key: String::new(),
            decoder: StringDecoder::default(),
            values: 0,
        }
    }

    /// Feeds one chunk in, returning the translated text it revealed — often
    /// empty while the scanner is still inside the envelope.
    pub fn push(&mut self, chunk: &str) -> String {
        let mut out = String::new();
        for ch in chunk.chars() {
            if !self.emitted {
                self.raw.push(ch);
            }
            self.step(ch, &mut out);
        }
        if !out.is_empty() {
            self.emitted = true;
            self.raw.clear();
        }
        out
    }

    /// Closes the stream, returning whatever is still owed: nothing in the
    /// normal case, or the whole reply when none of it could be read.
    pub fn finish(&mut self) -> String {
        self.hold.clear();
        if self.emitted {
            return String::new();
        }
        self.emitted = true;
        std::mem::take(&mut self.raw).trim().to_string()
    }

    fn step(&mut self, ch: char, out: &mut String) {
        match self.state {
            State::Undecided => {
                if ch.is_whitespace() {
                    return;
                }
                match ch {
                    '{' | '[' => self.state = State::Scan,
                    '`' => {
                        self.fenced = true;
                        self.state = State::FenceInfo;
                    }
                    _ => {
                        self.state = State::Plain;
                        self.emit_plain(ch, out);
                    }
                }
            }
            State::FenceInfo => {
                if ch == '\n' {
                    self.state = State::Undecided;
                }
            }
            State::Plain => self.emit_plain(ch, out),
            State::Scan => {
                if ch == '"' {
                    self.key.clear();
                    self.decoder = StringDecoder::default();
                    self.state = State::Key;
                }
            }
            State::Key => match self.decoder.push(ch) {
                Step::Emit(ch) => {
                    // A key is short; capturing a whole translation here would
                    // be pointless work.
                    if self.key.len() < 32 {
                        self.key.push(ch);
                    }
                }
                Step::Skip => {}
                Step::End => self.state = State::AfterKey,
            },
            State::AfterKey => {
                if ch.is_whitespace() {
                    return;
                }
                if ch == ':' && is_text_key(&self.key) {
                    self.state = State::BeforeValue;
                } else {
                    self.redispatch(ch, out);
                }
            }
            State::BeforeValue => {
                if ch.is_whitespace() {
                    return;
                }
                if ch == '"' {
                    // More than one translation reads as separate lines.
                    if self.values > 0 {
                        out.push('\n');
                    }
                    self.decoder = StringDecoder::default();
                    self.state = State::Value;
                } else {
                    self.redispatch(ch, out);
                }
            }
            State::Value => match self.decoder.push(ch) {
                Step::Emit(ch) => out.push(ch),
                Step::Skip => {}
                Step::End => {
                    self.values += 1;
                    self.state = State::Scan;
                }
            },
        }
    }

    /// Hands a character that ended a lookahead back to the plain scanner, so
    /// a quote opening the next string is not swallowed.
    fn redispatch(&mut self, ch: char, out: &mut String) {
        self.state = State::Scan;
        self.step(ch, out);
    }

    fn emit_plain(&mut self, ch: char, out: &mut String) {
        // Inside a fence, a run of backticks may be the closing one; hold it
        // (and the blank space leading up to it) until a real character proves
        // otherwise.
        if self.fenced && (ch == '`' || ch.is_whitespace()) {
            self.hold.push(ch);
            return;
        }
        out.push_str(&self.hold);
        self.hold.clear();
        out.push(ch);
    }
}

// ── JSON string decoding ─────────────────────────────────────────────────────

/// Unescapes one JSON string a character at a time, so escapes split across
/// chunk boundaries still decode.
#[derive(Debug, Default)]
struct StringDecoder {
    escape: bool,
    unicode: Option<String>,
    high_surrogate: Option<u16>,
}

enum Step {
    Emit(char),
    Skip,
    End,
}

impl StringDecoder {
    fn push(&mut self, ch: char) -> Step {
        if let Some(hex) = self.unicode.as_mut() {
            hex.push(ch);
            if hex.len() < 4 {
                return Step::Skip;
            }
            let code = u16::from_str_radix(hex, 16).unwrap_or(0xFFFD);
            self.unicode = None;
            return self.decode_unit(code);
        }

        if self.escape {
            self.escape = false;
            return match ch {
                'n' => Step::Emit('\n'),
                't' => Step::Emit('\t'),
                'r' => Step::Emit('\r'),
                'b' => Step::Emit('\u{8}'),
                'f' => Step::Emit('\u{c}'),
                'u' => {
                    self.unicode = Some(String::new());
                    Step::Skip
                }
                // `"`, `\`, `/`, and anything a model invents.
                other => Step::Emit(other),
            };
        }

        match ch {
            '\\' => {
                self.escape = true;
                Step::Skip
            }
            '"' => Step::End,
            other => Step::Emit(other),
        }
    }

    /// Turns one `\uXXXX` unit into a character, pairing surrogates so escaped
    /// astral characters survive.
    fn decode_unit(&mut self, code: u16) -> Step {
        if let Some(high) = self.high_surrogate.take() {
            if (0xDC00..0xE000).contains(&code) {
                let value =
                    0x1_0000 + ((u32::from(high) - 0xD800) << 10) + (u32::from(code) - 0xDC00);
                return char::from_u32(value).map_or(Step::Skip, Step::Emit);
            }
        }
        if (0xD800..0xDC00).contains(&code) {
            self.high_surrogate = Some(code);
            return Step::Skip;
        }
        char::from_u32(u32::from(code)).map_or(Step::Skip, Step::Emit)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn streamed(chunks: &[&str]) -> String {
        let mut stream = TranslationStream::new();
        let mut out = String::new();
        for chunk in chunks {
            out.push_str(&stream.push(chunk));
        }
        out.push_str(&stream.finish());
        out
    }

    #[test]
    fn envelope_yields_only_the_translation() {
        assert_eq!(
            translated_texts(r#"{"translations": [{"text": "你好，世界"}]}"#),
            vec!["你好，世界"]
        );
    }

    #[test]
    fn fenced_envelope_is_unwrapped() {
        let content = "```json\n{\"translations\": [{\"text\": \"你好\"}]}\n```";
        assert_eq!(translated_texts(content), vec!["你好"]);
    }

    #[test]
    fn a_preamble_around_the_envelope_is_dropped() {
        let content =
            "Sure! Here you go:\n{\"translations\": [{\"text\": \"你好\"}]}\nHope that helps.";
        assert_eq!(translated_texts(content), vec!["你好"]);
    }

    #[test]
    fn several_translations_are_all_kept() {
        assert_eq!(
            translated_texts(r#"{"translations": [{"text": "一"}, {"text": "二"}]}"#),
            vec!["一", "二"]
        );
    }

    #[test]
    fn shorthand_envelopes_are_understood() {
        assert_eq!(translated_texts(r#"{"text": "你好"}"#), vec!["你好"]);
        assert_eq!(translated_texts(r#"{"translation": "你好"}"#), vec!["你好"]);
        assert_eq!(
            translated_texts(r#"{"translations": ["你好"]}"#),
            vec!["你好"]
        );
    }

    #[test]
    fn a_plain_reply_is_left_alone() {
        assert_eq!(translated_texts("你好，世界"), vec!["你好，世界"]);
    }

    #[test]
    fn a_reply_that_is_not_the_envelope_is_shown_as_it_came() {
        // Better the model's own words than an empty panel.
        let content = "{\"error\": \"quota exceeded\"}";
        assert_eq!(translated_texts(content), vec![content]);
    }

    #[test]
    fn truncated_json_still_gives_up_its_text() {
        assert_eq!(
            translated_texts(r#"{"translations": [{"text": "你好，世"#),
            vec!["你好，世"]
        );
    }

    #[test]
    fn braces_inside_the_translation_do_not_confuse_the_parser() {
        assert_eq!(
            translated_texts(r#"{"translations": [{"text": "用 {name} 占位"}]}"#),
            vec!["用 {name} 占位"]
        );
    }

    #[test]
    fn streaming_emits_the_translation_as_it_arrives() {
        assert_eq!(
            streamed(&[
                "{\"transl",
                "ations\": [{\"te",
                "xt\": \"你好",
                "，世界\"}]}",
            ]),
            "你好，世界"
        );
    }

    #[test]
    fn streaming_passes_a_plain_reply_straight_through() {
        assert_eq!(streamed(&["你好，", "世界"]), "你好，世界");
    }

    #[test]
    fn streaming_unwraps_a_fence_at_both_ends() {
        assert_eq!(
            streamed(&["```json\n{\"text\": \"你好\"}\n", "```"]),
            "你好"
        );
        // A fence around plain prose loses the fence, not the prose.
        assert_eq!(streamed(&["```\n你好，世界\n", "```"]), "你好，世界");
    }

    #[test]
    fn streaming_decodes_escapes_split_across_chunks() {
        assert_eq!(
            streamed(&["{\"text\": \"line\\", "n\\u4f6", "0\\\"quoted\\\"\"}"]),
            "line\n你\"quoted\""
        );
    }

    #[test]
    fn streaming_decodes_a_surrogate_pair() {
        assert_eq!(streamed(&[r#"{"text": "😀"}"#]), "😀");
    }

    #[test]
    fn streaming_ignores_keys_that_are_not_the_translation() {
        assert_eq!(
            streamed(&[r#"{"detected": "en", "translations": [{"text": "你好", "note": "n/a"}]}"#]),
            "你好"
        );
    }

    #[test]
    fn a_quoted_text_key_inside_a_translation_is_not_mistaken_for_a_key() {
        assert_eq!(
            streamed(&[r#"{"translations": [{"text": "the \"text\": field"}]}"#]),
            "the \"text\": field"
        );
    }

    #[test]
    fn streaming_falls_back_to_the_raw_reply_when_nothing_is_readable() {
        assert_eq!(
            streamed(&["{\"error\": ", "\"nope\"}"]),
            r#"{"error": "nope"}"#
        );
    }

    #[test]
    fn several_streamed_translations_land_on_their_own_lines() {
        assert_eq!(
            streamed(&[r#"{"translations": [{"text": "一"}, {"text": "二"}]}"#]),
            "一\n二"
        );
    }
}
