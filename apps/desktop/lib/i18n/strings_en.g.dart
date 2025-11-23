///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations

	/// en: 'Biyi'
	String get app_name => 'Biyi';

	/// en: 'OK'
	String get ok => 'OK';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Add'
	String get add => 'Add';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Copied'
	String get copied => 'Copied';

	/// en: 'Please Choose'
	String get please_choose => 'Please Choose';

	late final TranslationsLanguageEn language = TranslationsLanguageEn._(_root);
	late final TranslationsEngineEn engine = TranslationsEngineEn._(_root);
	late final TranslationsEngineScopeEn engine_scope = TranslationsEngineScopeEn._(_root);
	late final TranslationsOcrEngineEn ocr_engine = TranslationsOcrEngineEn._(_root);
	late final TranslationsTranslationModeEn translation_mode = TranslationsTranslationModeEn._(_root);
	late final TranslationsThemeModeEn theme_mode = TranslationsThemeModeEn._(_root);
	late final TranslationsWordPronunciationEn word_pronunciation = TranslationsWordPronunciationEn._(_root);
	late final TranslationsTrayContextMenuEn tray_context_menu = TranslationsTrayContextMenuEn._(_root);
	late final TranslationsAppEn app = TranslationsAppEn._(_root);
	late final TranslationsWidgetEn widget = TranslationsWidgetEn._(_root);
}

// Path: language
class TranslationsLanguageEn {
	TranslationsLanguageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Afrikaans'
	String get af => 'Afrikaans';

	/// en: 'Amharic'
	String get am => 'Amharic';

	/// en: 'Arabic'
	String get ar => 'Arabic';

	/// en: 'Azerbaijani'
	String get az => 'Azerbaijani';

	/// en: 'Belarusian'
	String get be => 'Belarusian';

	/// en: 'Bulgarian'
	String get bg => 'Bulgarian';

	/// en: 'Bengali'
	String get bn => 'Bengali';

	/// en: 'Bosnian'
	String get bs => 'Bosnian';

	/// en: 'Catalan'
	String get ca => 'Catalan';

	/// en: 'Cebuano'
	String get ceb => 'Cebuano';

	/// en: 'Corsican'
	String get co => 'Corsican';

	/// en: 'Czech'
	String get cs => 'Czech';

	/// en: 'Welsh'
	String get cy => 'Welsh';

	/// en: 'Danish'
	String get da => 'Danish';

	/// en: 'German'
	String get de => 'German';

	/// en: 'Greek'
	String get el => 'Greek';

	/// en: 'English'
	String get en => 'English';

	/// en: 'Esperanto'
	String get eo => 'Esperanto';

	/// en: 'Spanish'
	String get es => 'Spanish';

	/// en: 'Estonian'
	String get et => 'Estonian';

	/// en: 'Basque'
	String get eu => 'Basque';

	/// en: 'Persian'
	String get fa => 'Persian';

	/// en: 'Finnish'
	String get fi => 'Finnish';

	/// en: 'French'
	String get fr => 'French';

	/// en: 'Frisian'
	String get fy => 'Frisian';

	/// en: 'Irish'
	String get ga => 'Irish';

	/// en: 'Scots Gaelic'
	String get gd => 'Scots Gaelic';

	/// en: 'Galician'
	String get gl => 'Galician';

	/// en: 'Gujarati'
	String get gu => 'Gujarati';

	/// en: 'Hausa'
	String get ha => 'Hausa';

	/// en: 'Hawaiian'
	String get haw => 'Hawaiian';

	/// en: 'Hebrew'
	String get he => 'Hebrew';

	/// en: 'Hindi'
	String get hi => 'Hindi';

	/// en: 'Hmong'
	String get hmn => 'Hmong';

	/// en: 'Croatian'
	String get hr => 'Croatian';

	/// en: 'Haitian Creole'
	String get ht => 'Haitian Creole';

	/// en: 'Hungarian'
	String get hu => 'Hungarian';

	/// en: 'Armenian'
	String get hy => 'Armenian';

	/// en: 'Indonesian'
	String get id => 'Indonesian';

	/// en: 'Igbo'
	String get ig => 'Igbo';

	/// en: 'Icelandic'
	String get kIs => 'Icelandic';

	/// en: 'Italian'
	String get it => 'Italian';

	/// en: 'Hebrew'
	String get iw => 'Hebrew';

	/// en: 'Japanese'
	String get ja => 'Japanese';

	/// en: 'Javanese'
	String get jw => 'Javanese';

	/// en: 'Georgian'
	String get ka => 'Georgian';

	/// en: 'Kazakh'
	String get kk => 'Kazakh';

	/// en: 'Khmer'
	String get km => 'Khmer';

	/// en: 'Kannada'
	String get kn => 'Kannada';

	/// en: 'Korean'
	String get ko => 'Korean';

	/// en: 'Kurdish (Kurmanji)'
	String get ku => 'Kurdish (Kurmanji)';

	/// en: 'Kyrgyz'
	String get ky => 'Kyrgyz';

	/// en: 'Latin'
	String get la => 'Latin';

	/// en: 'Luxembourgish'
	String get lb => 'Luxembourgish';

	/// en: 'Lao'
	String get lo => 'Lao';

	/// en: 'Lithuanian'
	String get lt => 'Lithuanian';

	/// en: 'Latvian'
	String get lv => 'Latvian';

	/// en: 'Malagasy'
	String get mg => 'Malagasy';

	/// en: 'Maori'
	String get mi => 'Maori';

	/// en: 'Macedonian'
	String get mk => 'Macedonian';

	/// en: 'Malayalam'
	String get ml => 'Malayalam';

	/// en: 'Mongolian'
	String get mn => 'Mongolian';

	/// en: 'Marathi'
	String get mr => 'Marathi';

	/// en: 'Malay'
	String get ms => 'Malay';

	/// en: 'Maltese'
	String get mt => 'Maltese';

	/// en: 'Myanmar (Burmese)'
	String get my => 'Myanmar (Burmese)';

	/// en: 'Nepali'
	String get ne => 'Nepali';

	/// en: 'Dutch'
	String get nl => 'Dutch';

	/// en: 'Norwegian'
	String get no => 'Norwegian';

	/// en: 'Chichewa'
	String get ny => 'Chichewa';

	/// en: 'Odia (Oriya)'
	String get or => 'Odia (Oriya)';

	/// en: 'Punjabi'
	String get pa => 'Punjabi';

	/// en: 'Polish'
	String get pl => 'Polish';

	/// en: 'Pashto'
	String get ps => 'Pashto';

	/// en: 'Portuguese'
	String get pt => 'Portuguese';

	/// en: 'Romanian'
	String get ro => 'Romanian';

	/// en: 'Russian'
	String get ru => 'Russian';

	/// en: 'Kinyarwanda'
	String get rw => 'Kinyarwanda';

	/// en: 'Sindhi'
	String get sd => 'Sindhi';

	/// en: 'Sinhala'
	String get si => 'Sinhala';

	/// en: 'Slovak'
	String get sk => 'Slovak';

	/// en: 'Slovenian'
	String get sl => 'Slovenian';

	/// en: 'Samoan'
	String get sm => 'Samoan';

	/// en: 'Shona'
	String get sn => 'Shona';

	/// en: 'Somali'
	String get so => 'Somali';

	/// en: 'Albanian'
	String get sq => 'Albanian';

	/// en: 'Serbian'
	String get sr => 'Serbian';

	/// en: 'Sesotho'
	String get st => 'Sesotho';

	/// en: 'Sundanese'
	String get su => 'Sundanese';

	/// en: 'Swedish'
	String get sv => 'Swedish';

	/// en: 'Swahili'
	String get sw => 'Swahili';

	/// en: 'Tamil'
	String get ta => 'Tamil';

	/// en: 'Telugu'
	String get te => 'Telugu';

	/// en: 'Tajik'
	String get tg => 'Tajik';

	/// en: 'Thai'
	String get th => 'Thai';

	/// en: 'Turkmen'
	String get tk => 'Turkmen';

	/// en: 'Filipino'
	String get tl => 'Filipino';

	/// en: 'Turkish'
	String get tr => 'Turkish';

	/// en: 'Tatar'
	String get tt => 'Tatar';

	/// en: 'Uyghur'
	String get ug => 'Uyghur';

	/// en: 'Ukrainian'
	String get uk => 'Ukrainian';

	/// en: 'Urdu'
	String get ur => 'Urdu';

	/// en: 'Uzbek'
	String get uz => 'Uzbek';

	/// en: 'Vietnamese'
	String get vi => 'Vietnamese';

	/// en: 'Xhosa'
	String get xh => 'Xhosa';

	/// en: 'Yiddish'
	String get yi => 'Yiddish';

	/// en: 'Yoruba'
	String get yo => 'Yoruba';

	/// en: 'Chinese'
	String get zh => 'Chinese';

	/// en: 'Chinese'
	String get zh_CN => 'Chinese';

	/// en: 'Chinese (Traditional)'
	String get zh_TW => 'Chinese (Traditional)';

	/// en: 'Zulu'
	String get zu => 'Zulu';
}

// Path: engine
class TranslationsEngineEn {
	TranslationsEngineEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Baidu'
	String get baidu => 'Baidu';

	/// en: 'Caiyun'
	String get caiyun => 'Caiyun';

	/// en: 'DeepL'
	String get deepl => 'DeepL';

	/// en: 'Google'
	String get google => 'Google';

	/// en: 'IBMWatson'
	String get ibmwatson => 'IBMWatson';

	/// en: 'Iciba'
	String get iciba => 'Iciba';

	/// en: 'OpenAI'
	String get openai => 'OpenAI';

	/// en: 'Sogou'
	String get sogou => 'Sogou';

	/// en: 'Tencent'
	String get tencent => 'Tencent';

	/// en: 'Youda'
	String get youdao => 'Youda';
}

// Path: engine_scope
class TranslationsEngineScopeEn {
	TranslationsEngineScopeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'detectLanguage'
	String get detectlanguage => 'detectLanguage';

	/// en: 'LookUp'
	String get lookup => 'LookUp';

	/// en: 'Translate'
	String get translate => 'Translate';
}

// Path: ocr_engine
class TranslationsOcrEngineEn {
	TranslationsOcrEngineEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Built In'
	String get built_in => 'Built In';

	/// en: 'Tesseract OCR'
	String get tesseract => 'Tesseract OCR';

	/// en: 'Youdao'
	String get youdao => 'Youdao';
}

// Path: translation_mode
class TranslationsTranslationModeEn {
	TranslationsTranslationModeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Auto'
	String get auto => 'Auto';

	/// en: 'Manual'
	String get manual => 'Manual';
}

// Path: theme_mode
class TranslationsThemeModeEn {
	TranslationsThemeModeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Light'
	String get light => 'Light';

	/// en: 'Dark'
	String get dark => 'Dark';

	/// en: 'System'
	String get system => 'System';
}

// Path: word_pronunciation
class TranslationsWordPronunciationEn {
	TranslationsWordPronunciationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'US'
	String get us => 'US';

	/// en: 'UK'
	String get uk => 'UK';
}

// Path: tray_context_menu
class TranslationsTrayContextMenuEn {
	TranslationsTrayContextMenuEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Show'
	String get item_show => 'Show';

	/// en: 'Quick Start'
	String get item_quick_start_guide => 'Quick Start';

	/// en: 'Join Discussion'
	String get item_discussion => 'Join Discussion';

	/// en: 'Quit Biyi'
	String get item_quit_app => 'Quit Biyi';

	/// en: 'Join Discord'
	String get item_discussion_subitem_discord_server => 'Join Discord';

	/// en: 'Join QQ Group'
	String get item_discussion_subitem_qq_group => 'Join QQ Group';
}

// Path: app
class TranslationsAppEn {
	TranslationsAppEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsAppHomeEn home = TranslationsAppHomeEn._(_root);
	late final TranslationsAppRecordShortcutEn record_shortcut = TranslationsAppRecordShortcutEn._(_root);
	late final TranslationsAppOcrEngineTypesEn ocr_engine_types = TranslationsAppOcrEngineTypesEn._(_root);
	late final TranslationsAppOcrEnginesEn ocr_engines = TranslationsAppOcrEnginesEn._(_root);
	late final TranslationsAppOcrEnginesNewEn ocr_engines_new = TranslationsAppOcrEnginesNewEn._(_root);
	late final TranslationsAppSettingsEn settings = TranslationsAppSettingsEn._(_root);
	late final TranslationsAppSupportedLanguagesEn supported_languages = TranslationsAppSupportedLanguagesEn._(_root);
	late final TranslationsAppTranslationEngineTypesEn translation_engine_types = TranslationsAppTranslationEngineTypesEn._(_root);
	late final TranslationsAppTranslationEnginesEn translation_engines = TranslationsAppTranslationEnginesEn._(_root);
	late final TranslationsAppTranslationEnginesNewEn translation_engines_new = TranslationsAppTranslationEnginesNewEn._(_root);
	late final TranslationsAppTranslationTargetsEn translation_targets = TranslationsAppTranslationTargetsEn._(_root);
}

// Path: widget
class TranslationsWidgetEn {
	TranslationsWidgetEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsWidgetRecordShortcutDialogEn record_shortcut_dialog = TranslationsWidgetRecordShortcutDialogEn._(_root);
}

// Path: app.home
class TranslationsAppHomeEn {
	TranslationsAppHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'New version found: $version'
	String newversion_banner_text_found_new_version({required Object version}) => 'New version found: ${version}';

	/// en: 'Update'
	String get newversion_banner_btn_update => 'Update';

	/// en: 'Functionality is limited, please perform a check according to the prompts.'
	String get limited_banner_title => 'Functionality is limited, please perform a check according to the prompts.';

	/// en: 'Grant screen recording access'
	String get limited_banner_text_screen_capture => 'Grant screen recording access';

	/// en: 'Grant accessibility access'
	String get limited_banner_text_screen_selection => 'Grant accessibility access';

	/// en: 'Allow'
	String get limited_banner_btn_allow => 'Allow';

	/// en: 'Go Settings'
	String get limited_banner_btn_go_settings => 'Go Settings';

	/// en: 'Check Again'
	String get limited_banner_btn_check_again => 'Check Again';

	/// en: 'View the help document'
	String get limited_banner_tip_help => 'View the help document';

	/// en: 'If there is no response after clicking "Allow", please click "Go Settings" to set it manually.'
	String get limited_banner_msg_allow_access_tip => 'If there is no response after clicking "Allow", please click "Go Settings" to set it manually.';

	/// en: 'The Screen extract text is enabled'
	String get limited_banner_msg_all_access_allowed => 'The Screen extract text is enabled';

	/// en: 'The required access are not allowed. Please check and set again.'
	String get limited_banner_msg_all_access_not_allowed => 'The required access are not allowed.\nPlease check and set again.';

	/// en: 'Enter the word or text here'
	String get input_hint => 'Enter the word or text here';

	/// en: 'Extracting text...'
	String get text_extracting_text => 'Extracting text...';

	/// en: 'Current translation mode: $mode'
	String tip_translation_mode({required Object mode}) => 'Current translation mode: ${mode}';

	/// en: 'Capture screen area and recognize text'
	String get tip_extract_text_from_screen_capture => 'Capture screen area and recognize text';

	/// en: 'Read clipboard content'
	String get tip_extract_text_from_clipboard => 'Read clipboard content';

	/// en: 'Clear'
	String get btn_clear => 'Clear';

	/// en: 'Translate'
	String get btn_trans => 'Translate';

	/// en: 'No text entered or text not extracted'
	String get msg_please_enter_word_or_text => 'No text entered or text not extracted';

	/// en: 'Capture screen area has been canceled'
	String get msg_capture_screen_area_canceled => 'Capture screen area has been canceled';
}

// Path: app.record_shortcut
class TranslationsAppRecordShortcutEn {
	TranslationsAppRecordShortcutEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Record your shortcut'
	String get title => 'Record your shortcut';
}

// Path: app.ocr_engine_types
class TranslationsAppOcrEngineTypesEn {
	TranslationsAppOcrEngineTypesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Engine Type'
	String get title => 'Engine Type';
}

// Path: app.ocr_engines
class TranslationsAppOcrEnginesEn {
	TranslationsAppOcrEnginesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Text Detections Engines'
	String get title => 'Text Detections Engines';

	late final TranslationsAppOcrEnginesMsgEn msg = TranslationsAppOcrEnginesMsgEn._(_root);
	late final TranslationsAppOcrEnginesPrivateEn private = TranslationsAppOcrEnginesPrivateEn._(_root);
}

// Path: app.ocr_engines_new
class TranslationsAppOcrEnginesNewEn {
	TranslationsAppOcrEnginesNewEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Add Text Detection Engine'
	String get title => 'Add Text Detection Engine';

	late final TranslationsAppOcrEnginesNewEngineTypeEn engine_type = TranslationsAppOcrEnginesNewEngineTypeEn._(_root);
	late final TranslationsAppOcrEnginesNewOptionEn option = TranslationsAppOcrEnginesNewOptionEn._(_root);
}

// Path: app.settings
class TranslationsAppSettingsEn {
	TranslationsAppSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get title => 'Settings';

	/// en: 'Version $version BUILD $buildNumber'
	String text_version({required Object version, required Object buildNumber}) => 'Version ${version} BUILD ${buildNumber}';

	late final TranslationsAppSettingsKLayoutEn kLayout = TranslationsAppSettingsKLayoutEn._(_root);
	late final TranslationsAppSettingsAboutEn about = TranslationsAppSettingsAboutEn._(_root);
	late final TranslationsAppSettingsAdvancedEn advanced = TranslationsAppSettingsAdvancedEn._(_root);
	late final TranslationsAppSettingsAppearanceEn appearance = TranslationsAppSettingsAppearanceEn._(_root);
	late final TranslationsAppSettingsChangelogEn changelog = TranslationsAppSettingsChangelogEn._(_root);
	late final TranslationsAppSettingsGeneralEn general = TranslationsAppSettingsGeneralEn._(_root);
	late final TranslationsAppSettingsKeybindsEn keybinds = TranslationsAppSettingsKeybindsEn._(_root);
	late final TranslationsAppSettingsLanguageEn language = TranslationsAppSettingsLanguageEn._(_root);
	late final TranslationsAppSettingsOcrEnginesEn ocr_engines = TranslationsAppSettingsOcrEnginesEn._(_root);
	late final TranslationsAppSettingsTranslationEnginesEn translation_engines = TranslationsAppSettingsTranslationEnginesEn._(_root);
}

// Path: app.supported_languages
class TranslationsAppSupportedLanguagesEn {
	TranslationsAppSupportedLanguagesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Supported Languages'
	String get title => 'Supported Languages';

	late final TranslationsAppSupportedLanguagesAllEn all = TranslationsAppSupportedLanguagesAllEn._(_root);
}

// Path: app.translation_engine_types
class TranslationsAppTranslationEngineTypesEn {
	TranslationsAppTranslationEngineTypesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Engine Type'
	String get title => 'Engine Type';
}

// Path: app.translation_engines
class TranslationsAppTranslationEnginesEn {
	TranslationsAppTranslationEnginesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Text Translation Engines'
	String get title => 'Text Translation Engines';

	late final TranslationsAppTranslationEnginesMsgEn msg = TranslationsAppTranslationEnginesMsgEn._(_root);
	late final TranslationsAppTranslationEnginesPrivateEn private = TranslationsAppTranslationEnginesPrivateEn._(_root);
}

// Path: app.translation_engines_new
class TranslationsAppTranslationEnginesNewEn {
	TranslationsAppTranslationEnginesNewEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Add Text Translation Engine'
	String get title => 'Add Text Translation Engine';

	late final TranslationsAppTranslationEnginesNewEngineTypeEn engine_type = TranslationsAppTranslationEnginesNewEngineTypeEn._(_root);
	late final TranslationsAppTranslationEnginesNewSupportInterfaceEn support_interface = TranslationsAppTranslationEnginesNewSupportInterfaceEn._(_root);
	late final TranslationsAppTranslationEnginesNewOptionEn option = TranslationsAppTranslationEnginesNewOptionEn._(_root);
}

// Path: app.translation_targets
class TranslationsAppTranslationTargetsEn {
	TranslationsAppTranslationTargetsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsAppTranslationTargetsKNewEn kNew = TranslationsAppTranslationTargetsKNewEn._(_root);
}

// Path: widget.record_shortcut_dialog
class TranslationsWidgetRecordShortcutDialogEn {
	TranslationsWidgetRecordShortcutDialogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Customize your shortcut'
	String get title => 'Customize your shortcut';
}

// Path: app.ocr_engines.msg
class TranslationsAppOcrEnginesMsgEn {
	TranslationsAppOcrEnginesMsgEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No available engines'
	String get no_available_engines => 'No available engines';
}

// Path: app.ocr_engines.private
class TranslationsAppOcrEnginesPrivateEn {
	TranslationsAppOcrEnginesPrivateEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Private'
	String get title => 'Private';
}

// Path: app.ocr_engines_new.engine_type
class TranslationsAppOcrEnginesNewEngineTypeEn {
	TranslationsAppOcrEnginesNewEngineTypeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Engine type'
	String get title => 'Engine type';
}

// Path: app.ocr_engines_new.option
class TranslationsAppOcrEnginesNewOptionEn {
	TranslationsAppOcrEnginesNewOptionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Option'
	String get title => 'Option';
}

// Path: app.settings.kLayout
class TranslationsAppSettingsKLayoutEn {
	TranslationsAppSettingsKLayoutEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsAppSettingsKLayoutNavgroupEn navgroup = TranslationsAppSettingsKLayoutNavgroupEn._(_root);
}

// Path: app.settings.about
class TranslationsAppSettingsAboutEn {
	TranslationsAppSettingsAboutEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'About'
	String get title => 'About';

	late final TranslationsAppSettingsAboutPackageInfoEn package_info = TranslationsAppSettingsAboutPackageInfoEn._(_root);
}

// Path: app.settings.advanced
class TranslationsAppSettingsAdvancedEn {
	TranslationsAppSettingsAdvancedEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Advanced'
	String get title => 'Advanced';

	late final TranslationsAppSettingsAdvancedLaunchAtLoginEn launch_at_login = TranslationsAppSettingsAdvancedLaunchAtLoginEn._(_root);
}

// Path: app.settings.appearance
class TranslationsAppSettingsAppearanceEn {
	TranslationsAppSettingsAppearanceEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Appearance'
	String get title => 'Appearance';

	/// en: 'Change the look of your client.'
	String get subtitle => 'Change the look of your client.';

	late final TranslationsAppSettingsAppearanceTrayIconEn tray_icon = TranslationsAppSettingsAppearanceTrayIconEn._(_root);
	late final TranslationsAppSettingsAppearanceMaxWindowHeightEn max_window_height = TranslationsAppSettingsAppearanceMaxWindowHeightEn._(_root);
}

// Path: app.settings.changelog
class TranslationsAppSettingsChangelogEn {
	TranslationsAppSettingsChangelogEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Changelog'
	String get title => 'Changelog';

	/// en: 'See what cool new features we're making.'
	String get subtitle => 'See what cool new features we\'re making.';
}

// Path: app.settings.general
class TranslationsAppSettingsGeneralEn {
	TranslationsAppSettingsGeneralEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'General'
	String get title => 'General';

	/// en: 'General settings related to the client.'
	String get subtitle => 'General settings related to the client.';

	late final TranslationsAppSettingsGeneralDefaultDetectTextEngineEn default_detect_text_engine = TranslationsAppSettingsGeneralDefaultDetectTextEngineEn._(_root);
	late final TranslationsAppSettingsGeneralExtractTextEn extract_text = TranslationsAppSettingsGeneralExtractTextEn._(_root);
	late final TranslationsAppSettingsGeneralDefaultTranslateEngineEn default_translate_engine = TranslationsAppSettingsGeneralDefaultTranslateEngineEn._(_root);
	late final TranslationsAppSettingsGeneralTranslationModeEn translation_mode = TranslationsAppSettingsGeneralTranslationModeEn._(_root);
	late final TranslationsAppSettingsGeneralDefaultDetectLanguageEngineEn default_detect_language_engine = TranslationsAppSettingsGeneralDefaultDetectLanguageEngineEn._(_root);
	late final TranslationsAppSettingsGeneralTranslationTargetEn translation_target = TranslationsAppSettingsGeneralTranslationTargetEn._(_root);
	late final TranslationsAppSettingsGeneralTranslateEn translate = TranslationsAppSettingsGeneralTranslateEn._(_root);
	late final TranslationsAppSettingsGeneralInputSettingsEn input_settings = TranslationsAppSettingsGeneralInputSettingsEn._(_root);
}

// Path: app.settings.keybinds
class TranslationsAppSettingsKeybindsEn {
	TranslationsAppSettingsKeybindsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Keybinds'
	String get title => 'Keybinds';

	/// en: 'View and manage client keybinds'
	String get subtitle => 'View and manage client keybinds';

	late final TranslationsAppSettingsKeybindsWindowEn window = TranslationsAppSettingsKeybindsWindowEn._(_root);
	late final TranslationsAppSettingsKeybindsExtractTextEn extract_text = TranslationsAppSettingsKeybindsExtractTextEn._(_root);
	late final TranslationsAppSettingsKeybindsInputAssistFunctionEn input_assist_function = TranslationsAppSettingsKeybindsInputAssistFunctionEn._(_root);
}

// Path: app.settings.language
class TranslationsAppSettingsLanguageEn {
	TranslationsAppSettingsLanguageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Language'
	String get title => 'Language';
}

// Path: app.settings.ocr_engines
class TranslationsAppSettingsOcrEnginesEn {
	TranslationsAppSettingsOcrEnginesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Text Detections'
	String get title => 'Text Detections';

	late final TranslationsAppSettingsOcrEnginesPrivateEn private = TranslationsAppSettingsOcrEnginesPrivateEn._(_root);
}

// Path: app.settings.translation_engines
class TranslationsAppSettingsTranslationEnginesEn {
	TranslationsAppSettingsTranslationEnginesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Text Translations'
	String get title => 'Text Translations';

	late final TranslationsAppSettingsTranslationEnginesPrivateEn private = TranslationsAppSettingsTranslationEnginesPrivateEn._(_root);
}

// Path: app.supported_languages.all
class TranslationsAppSupportedLanguagesAllEn {
	TranslationsAppSupportedLanguagesAllEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'All'
	String get title => 'All';
}

// Path: app.translation_engines.msg
class TranslationsAppTranslationEnginesMsgEn {
	TranslationsAppTranslationEnginesMsgEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'No available engines'
	String get no_available_engines => 'No available engines';
}

// Path: app.translation_engines.private
class TranslationsAppTranslationEnginesPrivateEn {
	TranslationsAppTranslationEnginesPrivateEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Private'
	String get title => 'Private';
}

// Path: app.translation_engines_new.engine_type
class TranslationsAppTranslationEnginesNewEngineTypeEn {
	TranslationsAppTranslationEnginesNewEngineTypeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Engine type'
	String get title => 'Engine type';
}

// Path: app.translation_engines_new.support_interface
class TranslationsAppTranslationEnginesNewSupportInterfaceEn {
	TranslationsAppTranslationEnginesNewSupportInterfaceEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Support interface'
	String get title => 'Support interface';
}

// Path: app.translation_engines_new.option
class TranslationsAppTranslationEnginesNewOptionEn {
	TranslationsAppTranslationEnginesNewOptionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Option'
	String get title => 'Option';
}

// Path: app.translation_targets.kNew
class TranslationsAppTranslationTargetsKNewEn {
	TranslationsAppTranslationTargetsKNewEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Add Translation Target'
	String get title => 'Add Translation Target';

	/// en: 'Edit Translation Target'
	String get title_with_edit => 'Edit Translation Target';

	/// en: 'Source language'
	String get source_language => 'Source language';

	/// en: 'Target language'
	String get target_language => 'Target language';
}

// Path: app.settings.kLayout.navgroup
class TranslationsAppSettingsKLayoutNavgroupEn {
	TranslationsAppSettingsKLayoutNavgroupEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Client'
	String get client => 'Client';

	/// en: 'Integrations'
	String get integrations => 'Integrations';

	/// en: 'Resources'
	String get resources => 'Resources';
}

// Path: app.settings.about.package_info
class TranslationsAppSettingsAboutPackageInfoEn {
	TranslationsAppSettingsAboutPackageInfoEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Version'
	String get version => 'Version';

	/// en: 'Build Number'
	String get build_number => 'Build Number';
}

// Path: app.settings.advanced.launch_at_login
class TranslationsAppSettingsAdvancedLaunchAtLoginEn {
	TranslationsAppSettingsAdvancedLaunchAtLoginEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Launch at login'
	String get title => 'Launch at login';
}

// Path: app.settings.appearance.tray_icon
class TranslationsAppSettingsAppearanceTrayIconEn {
	TranslationsAppSettingsAppearanceTrayIconEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Tray Icon'
	String get title => 'Tray Icon';

	late final TranslationsAppSettingsAppearanceTrayIconStyleEn style = TranslationsAppSettingsAppearanceTrayIconStyleEn._(_root);
	late final TranslationsAppSettingsAppearanceTrayIconShowEn show = TranslationsAppSettingsAppearanceTrayIconShowEn._(_root);
}

// Path: app.settings.appearance.max_window_height
class TranslationsAppSettingsAppearanceMaxWindowHeightEn {
	TranslationsAppSettingsAppearanceMaxWindowHeightEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Maximum window height (logical pixels)'
	String get title => 'Maximum window height (logical pixels)';
}

// Path: app.settings.general.default_detect_text_engine
class TranslationsAppSettingsGeneralDefaultDetectTextEngineEn {
	TranslationsAppSettingsGeneralDefaultDetectTextEngineEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Default detect text engine'
	String get title => 'Default detect text engine';
}

// Path: app.settings.general.extract_text
class TranslationsAppSettingsGeneralExtractTextEn {
	TranslationsAppSettingsGeneralExtractTextEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsAppSettingsGeneralExtractTextAutoCopyDetectedTextEn auto_copy_detected_text = TranslationsAppSettingsGeneralExtractTextAutoCopyDetectedTextEn._(_root);
}

// Path: app.settings.general.default_translate_engine
class TranslationsAppSettingsGeneralDefaultTranslateEngineEn {
	TranslationsAppSettingsGeneralDefaultTranslateEngineEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Default translate engine'
	String get title => 'Default translate engine';
}

// Path: app.settings.general.translation_mode
class TranslationsAppSettingsGeneralTranslationModeEn {
	TranslationsAppSettingsGeneralTranslationModeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Translation Mode'
	String get title => 'Translation Mode';
}

// Path: app.settings.general.default_detect_language_engine
class TranslationsAppSettingsGeneralDefaultDetectLanguageEngineEn {
	TranslationsAppSettingsGeneralDefaultDetectLanguageEngineEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Default detect language engine'
	String get title => 'Default detect language engine';
}

// Path: app.settings.general.translation_target
class TranslationsAppSettingsGeneralTranslationTargetEn {
	TranslationsAppSettingsGeneralTranslationTargetEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Translation target'
	String get title => 'Translation target';
}

// Path: app.settings.general.translate
class TranslationsAppSettingsGeneralTranslateEn {
	TranslationsAppSettingsGeneralTranslateEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsAppSettingsGeneralTranslateDoubleClickCopyResultEn double_click_copy_result = TranslationsAppSettingsGeneralTranslateDoubleClickCopyResultEn._(_root);
}

// Path: app.settings.general.input_settings
class TranslationsAppSettingsGeneralInputSettingsEn {
	TranslationsAppSettingsGeneralInputSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Input Settings'
	String get title => 'Input Settings';

	late final TranslationsAppSettingsGeneralInputSettingsSubmitWithEnterEn submit_with_enter = TranslationsAppSettingsGeneralInputSettingsSubmitWithEnterEn._(_root);
	late final TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterEn submit_with_meta_enter = TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterEn._(_root);
	late final TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterMacEn submit_with_meta_enter_mac = TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterMacEn._(_root);
}

// Path: app.settings.keybinds.window
class TranslationsAppSettingsKeybindsWindowEn {
	TranslationsAppSettingsKeybindsWindowEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsAppSettingsKeybindsWindowShowOrHideEn show_or_hide = TranslationsAppSettingsKeybindsWindowShowOrHideEn._(_root);
	late final TranslationsAppSettingsKeybindsWindowHideEn hide = TranslationsAppSettingsKeybindsWindowHideEn._(_root);
}

// Path: app.settings.keybinds.extract_text
class TranslationsAppSettingsKeybindsExtractTextEn {
	TranslationsAppSettingsKeybindsExtractTextEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Screen / Clipboard extract text'
	String get title => 'Screen / Clipboard extract text';

	late final TranslationsAppSettingsKeybindsExtractTextFromSelectionEn from_selection = TranslationsAppSettingsKeybindsExtractTextFromSelectionEn._(_root);
	late final TranslationsAppSettingsKeybindsExtractTextFromCaptureEn from_capture = TranslationsAppSettingsKeybindsExtractTextFromCaptureEn._(_root);
	late final TranslationsAppSettingsKeybindsExtractTextFromClipboardEn from_clipboard = TranslationsAppSettingsKeybindsExtractTextFromClipboardEn._(_root);
}

// Path: app.settings.keybinds.input_assist_function
class TranslationsAppSettingsKeybindsInputAssistFunctionEn {
	TranslationsAppSettingsKeybindsInputAssistFunctionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Input assist function'
	String get title => 'Input assist function';

	late final TranslationsAppSettingsKeybindsInputAssistFunctionTranslateInputContentEn translate_input_content = TranslationsAppSettingsKeybindsInputAssistFunctionTranslateInputContentEn._(_root);
}

// Path: app.settings.ocr_engines.private
class TranslationsAppSettingsOcrEnginesPrivateEn {
	TranslationsAppSettingsOcrEnginesPrivateEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Private'
	String get title => 'Private';

	/// en: 'Long press an item to reorder it'
	String get description => 'Long press an item to reorder it';
}

// Path: app.settings.translation_engines.private
class TranslationsAppSettingsTranslationEnginesPrivateEn {
	TranslationsAppSettingsTranslationEnginesPrivateEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Private'
	String get title => 'Private';

	/// en: 'Long press an item to reorder it'
	String get description => 'Long press an item to reorder it';
}

// Path: app.settings.appearance.tray_icon.style
class TranslationsAppSettingsAppearanceTrayIconStyleEn {
	TranslationsAppSettingsAppearanceTrayIconStyleEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Tray Icon Style'
	String get title => 'Tray Icon Style';
}

// Path: app.settings.appearance.tray_icon.show
class TranslationsAppSettingsAppearanceTrayIconShowEn {
	TranslationsAppSettingsAppearanceTrayIconShowEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Show Tray Icon'
	String get title => 'Show Tray Icon';
}

// Path: app.settings.general.extract_text.auto_copy_detected_text
class TranslationsAppSettingsGeneralExtractTextAutoCopyDetectedTextEn {
	TranslationsAppSettingsGeneralExtractTextAutoCopyDetectedTextEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Auto copy the detected text'
	String get title => 'Auto copy the detected text';
}

// Path: app.settings.general.translate.double_click_copy_result
class TranslationsAppSettingsGeneralTranslateDoubleClickCopyResultEn {
	TranslationsAppSettingsGeneralTranslateDoubleClickCopyResultEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Double-click to copy translation result'
	String get title => 'Double-click to copy translation result';
}

// Path: app.settings.general.input_settings.submit_with_enter
class TranslationsAppSettingsGeneralInputSettingsSubmitWithEnterEn {
	TranslationsAppSettingsGeneralInputSettingsSubmitWithEnterEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Submit with Enter'
	String get title => 'Submit with Enter';
}

// Path: app.settings.general.input_settings.submit_with_meta_enter
class TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterEn {
	TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Submit with Ctrl + Enter'
	String get title => 'Submit with Ctrl + Enter';
}

// Path: app.settings.general.input_settings.submit_with_meta_enter_mac
class TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterMacEn {
	TranslationsAppSettingsGeneralInputSettingsSubmitWithMetaEnterMacEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Submit with ⌘ + Enter'
	String get title => 'Submit with ⌘ + Enter';
}

// Path: app.settings.keybinds.window.show_or_hide
class TranslationsAppSettingsKeybindsWindowShowOrHideEn {
	TranslationsAppSettingsKeybindsWindowShowOrHideEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Show/Hide'
	String get title => 'Show/Hide';
}

// Path: app.settings.keybinds.window.hide
class TranslationsAppSettingsKeybindsWindowHideEn {
	TranslationsAppSettingsKeybindsWindowHideEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Hide'
	String get title => 'Hide';
}

// Path: app.settings.keybinds.extract_text.from_selection
class TranslationsAppSettingsKeybindsExtractTextFromSelectionEn {
	TranslationsAppSettingsKeybindsExtractTextFromSelectionEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Selection'
	String get title => 'Selection';
}

// Path: app.settings.keybinds.extract_text.from_capture
class TranslationsAppSettingsKeybindsExtractTextFromCaptureEn {
	TranslationsAppSettingsKeybindsExtractTextFromCaptureEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Capture Area'
	String get title => 'Capture Area';
}

// Path: app.settings.keybinds.extract_text.from_clipboard
class TranslationsAppSettingsKeybindsExtractTextFromClipboardEn {
	TranslationsAppSettingsKeybindsExtractTextFromClipboardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Clipboard'
	String get title => 'Clipboard';
}

// Path: app.settings.keybinds.input_assist_function.translate_input_content
class TranslationsAppSettingsKeybindsInputAssistFunctionTranslateInputContentEn {
	TranslationsAppSettingsKeybindsInputAssistFunctionTranslateInputContentEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Translate input content'
	String get title => 'Translate input content';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app_name' => 'Biyi',
			'ok' => 'OK',
			'cancel' => 'Cancel',
			'add' => 'Add',
			'delete' => 'Delete',
			'copied' => 'Copied',
			'please_choose' => 'Please Choose',
			'language.af' => 'Afrikaans',
			'language.am' => 'Amharic',
			'language.ar' => 'Arabic',
			'language.az' => 'Azerbaijani',
			'language.be' => 'Belarusian',
			'language.bg' => 'Bulgarian',
			'language.bn' => 'Bengali',
			'language.bs' => 'Bosnian',
			'language.ca' => 'Catalan',
			'language.ceb' => 'Cebuano',
			'language.co' => 'Corsican',
			'language.cs' => 'Czech',
			'language.cy' => 'Welsh',
			'language.da' => 'Danish',
			'language.de' => 'German',
			'language.el' => 'Greek',
			'language.en' => 'English',
			'language.eo' => 'Esperanto',
			'language.es' => 'Spanish',
			'language.et' => 'Estonian',
			'language.eu' => 'Basque',
			'language.fa' => 'Persian',
			'language.fi' => 'Finnish',
			'language.fr' => 'French',
			'language.fy' => 'Frisian',
			'language.ga' => 'Irish',
			'language.gd' => 'Scots Gaelic',
			'language.gl' => 'Galician',
			'language.gu' => 'Gujarati',
			'language.ha' => 'Hausa',
			'language.haw' => 'Hawaiian',
			'language.he' => 'Hebrew',
			'language.hi' => 'Hindi',
			'language.hmn' => 'Hmong',
			'language.hr' => 'Croatian',
			'language.ht' => 'Haitian Creole',
			'language.hu' => 'Hungarian',
			'language.hy' => 'Armenian',
			'language.id' => 'Indonesian',
			'language.ig' => 'Igbo',
			'language.kIs' => 'Icelandic',
			'language.it' => 'Italian',
			'language.iw' => 'Hebrew',
			'language.ja' => 'Japanese',
			'language.jw' => 'Javanese',
			'language.ka' => 'Georgian',
			'language.kk' => 'Kazakh',
			'language.km' => 'Khmer',
			'language.kn' => 'Kannada',
			'language.ko' => 'Korean',
			'language.ku' => 'Kurdish (Kurmanji)',
			'language.ky' => 'Kyrgyz',
			'language.la' => 'Latin',
			'language.lb' => 'Luxembourgish',
			'language.lo' => 'Lao',
			'language.lt' => 'Lithuanian',
			'language.lv' => 'Latvian',
			'language.mg' => 'Malagasy',
			'language.mi' => 'Maori',
			'language.mk' => 'Macedonian',
			'language.ml' => 'Malayalam',
			'language.mn' => 'Mongolian',
			'language.mr' => 'Marathi',
			'language.ms' => 'Malay',
			'language.mt' => 'Maltese',
			'language.my' => 'Myanmar (Burmese)',
			'language.ne' => 'Nepali',
			'language.nl' => 'Dutch',
			'language.no' => 'Norwegian',
			'language.ny' => 'Chichewa',
			'language.or' => 'Odia (Oriya)',
			'language.pa' => 'Punjabi',
			'language.pl' => 'Polish',
			'language.ps' => 'Pashto',
			'language.pt' => 'Portuguese',
			'language.ro' => 'Romanian',
			'language.ru' => 'Russian',
			'language.rw' => 'Kinyarwanda',
			'language.sd' => 'Sindhi',
			'language.si' => 'Sinhala',
			'language.sk' => 'Slovak',
			'language.sl' => 'Slovenian',
			'language.sm' => 'Samoan',
			'language.sn' => 'Shona',
			'language.so' => 'Somali',
			'language.sq' => 'Albanian',
			'language.sr' => 'Serbian',
			'language.st' => 'Sesotho',
			'language.su' => 'Sundanese',
			'language.sv' => 'Swedish',
			'language.sw' => 'Swahili',
			'language.ta' => 'Tamil',
			'language.te' => 'Telugu',
			'language.tg' => 'Tajik',
			'language.th' => 'Thai',
			'language.tk' => 'Turkmen',
			'language.tl' => 'Filipino',
			'language.tr' => 'Turkish',
			'language.tt' => 'Tatar',
			'language.ug' => 'Uyghur',
			'language.uk' => 'Ukrainian',
			'language.ur' => 'Urdu',
			'language.uz' => 'Uzbek',
			'language.vi' => 'Vietnamese',
			'language.xh' => 'Xhosa',
			'language.yi' => 'Yiddish',
			'language.yo' => 'Yoruba',
			'language.zh' => 'Chinese',
			'language.zh_CN' => 'Chinese',
			'language.zh_TW' => 'Chinese (Traditional)',
			'language.zu' => 'Zulu',
			'engine.baidu' => 'Baidu',
			'engine.caiyun' => 'Caiyun',
			'engine.deepl' => 'DeepL',
			'engine.google' => 'Google',
			'engine.ibmwatson' => 'IBMWatson',
			'engine.iciba' => 'Iciba',
			'engine.openai' => 'OpenAI',
			'engine.sogou' => 'Sogou',
			'engine.tencent' => 'Tencent',
			'engine.youdao' => 'Youda',
			'engine_scope.detectlanguage' => 'detectLanguage',
			'engine_scope.lookup' => 'LookUp',
			'engine_scope.translate' => 'Translate',
			'ocr_engine.built_in' => 'Built In',
			'ocr_engine.tesseract' => 'Tesseract OCR',
			'ocr_engine.youdao' => 'Youdao',
			'translation_mode.auto' => 'Auto',
			'translation_mode.manual' => 'Manual',
			'theme_mode.light' => 'Light',
			'theme_mode.dark' => 'Dark',
			'theme_mode.system' => 'System',
			'word_pronunciation.us' => 'US',
			'word_pronunciation.uk' => 'UK',
			'tray_context_menu.item_show' => 'Show',
			'tray_context_menu.item_quick_start_guide' => 'Quick Start',
			'tray_context_menu.item_discussion' => 'Join Discussion',
			'tray_context_menu.item_quit_app' => 'Quit Biyi',
			'tray_context_menu.item_discussion_subitem_discord_server' => 'Join Discord',
			'tray_context_menu.item_discussion_subitem_qq_group' => 'Join QQ Group',
			'app.home.newversion_banner_text_found_new_version' => ({required Object version}) => 'New version found: ${version}',
			'app.home.newversion_banner_btn_update' => 'Update',
			'app.home.limited_banner_title' => 'Functionality is limited, please perform a check according to the prompts.',
			'app.home.limited_banner_text_screen_capture' => 'Grant screen recording access',
			'app.home.limited_banner_text_screen_selection' => 'Grant accessibility access',
			'app.home.limited_banner_btn_allow' => 'Allow',
			'app.home.limited_banner_btn_go_settings' => 'Go Settings',
			'app.home.limited_banner_btn_check_again' => 'Check Again',
			'app.home.limited_banner_tip_help' => 'View the help document',
			'app.home.limited_banner_msg_allow_access_tip' => 'If there is no response after clicking "Allow", please click "Go Settings" to set it manually.',
			'app.home.limited_banner_msg_all_access_allowed' => 'The Screen extract text is enabled',
			'app.home.limited_banner_msg_all_access_not_allowed' => 'The required access are not allowed.\nPlease check and set again.',
			'app.home.input_hint' => 'Enter the word or text here',
			'app.home.text_extracting_text' => 'Extracting text...',
			'app.home.tip_translation_mode' => ({required Object mode}) => 'Current translation mode: ${mode}',
			'app.home.tip_extract_text_from_screen_capture' => 'Capture screen area and recognize text',
			'app.home.tip_extract_text_from_clipboard' => 'Read clipboard content',
			'app.home.btn_clear' => 'Clear',
			'app.home.btn_trans' => 'Translate',
			'app.home.msg_please_enter_word_or_text' => 'No text entered or text not extracted',
			'app.home.msg_capture_screen_area_canceled' => 'Capture screen area has been canceled',
			'app.record_shortcut.title' => 'Record your shortcut',
			'app.ocr_engine_types.title' => 'Engine Type',
			'app.ocr_engines.title' => 'Text Detections Engines',
			'app.ocr_engines.msg.no_available_engines' => 'No available engines',
			'app.ocr_engines.private.title' => 'Private',
			'app.ocr_engines_new.title' => 'Add Text Detection Engine',
			'app.ocr_engines_new.engine_type.title' => 'Engine type',
			'app.ocr_engines_new.option.title' => 'Option',
			'app.settings.title' => 'Settings',
			'app.settings.text_version' => ({required Object version, required Object buildNumber}) => 'Version ${version} BUILD ${buildNumber}',
			'app.settings.kLayout.navgroup.client' => 'Client',
			'app.settings.kLayout.navgroup.integrations' => 'Integrations',
			'app.settings.kLayout.navgroup.resources' => 'Resources',
			'app.settings.about.title' => 'About',
			'app.settings.about.package_info.version' => 'Version',
			'app.settings.about.package_info.build_number' => 'Build Number',
			'app.settings.advanced.title' => 'Advanced',
			'app.settings.advanced.launch_at_login.title' => 'Launch at login',
			'app.settings.appearance.title' => 'Appearance',
			'app.settings.appearance.subtitle' => 'Change the look of your client.',
			'app.settings.appearance.tray_icon.title' => 'Tray Icon',
			'app.settings.appearance.tray_icon.style.title' => 'Tray Icon Style',
			'app.settings.appearance.tray_icon.show.title' => 'Show Tray Icon',
			'app.settings.appearance.max_window_height.title' => 'Maximum window height (logical pixels)',
			'app.settings.changelog.title' => 'Changelog',
			'app.settings.changelog.subtitle' => 'See what cool new features we\'re making.',
			'app.settings.general.title' => 'General',
			'app.settings.general.subtitle' => 'General settings related to the client.',
			'app.settings.general.default_detect_text_engine.title' => 'Default detect text engine',
			'app.settings.general.extract_text.auto_copy_detected_text.title' => 'Auto copy the detected text',
			'app.settings.general.default_translate_engine.title' => 'Default translate engine',
			'app.settings.general.translation_mode.title' => 'Translation Mode',
			'app.settings.general.default_detect_language_engine.title' => 'Default detect language engine',
			'app.settings.general.translation_target.title' => 'Translation target',
			'app.settings.general.translate.double_click_copy_result.title' => 'Double-click to copy translation result',
			'app.settings.general.input_settings.title' => 'Input Settings',
			'app.settings.general.input_settings.submit_with_enter.title' => 'Submit with Enter',
			'app.settings.general.input_settings.submit_with_meta_enter.title' => 'Submit with Ctrl + Enter',
			'app.settings.general.input_settings.submit_with_meta_enter_mac.title' => 'Submit with ⌘ + Enter',
			'app.settings.keybinds.title' => 'Keybinds',
			'app.settings.keybinds.subtitle' => 'View and manage client keybinds',
			'app.settings.keybinds.window.show_or_hide.title' => 'Show/Hide',
			'app.settings.keybinds.window.hide.title' => 'Hide',
			'app.settings.keybinds.extract_text.title' => 'Screen / Clipboard extract text',
			'app.settings.keybinds.extract_text.from_selection.title' => 'Selection',
			'app.settings.keybinds.extract_text.from_capture.title' => 'Capture Area',
			'app.settings.keybinds.extract_text.from_clipboard.title' => 'Clipboard',
			'app.settings.keybinds.input_assist_function.title' => 'Input assist function',
			'app.settings.keybinds.input_assist_function.translate_input_content.title' => 'Translate input content',
			'app.settings.language.title' => 'Language',
			'app.settings.ocr_engines.title' => 'Text Detections',
			'app.settings.ocr_engines.private.title' => 'Private',
			'app.settings.ocr_engines.private.description' => 'Long press an item to reorder it',
			'app.settings.translation_engines.title' => 'Text Translations',
			'app.settings.translation_engines.private.title' => 'Private',
			'app.settings.translation_engines.private.description' => 'Long press an item to reorder it',
			'app.supported_languages.title' => 'Supported Languages',
			'app.supported_languages.all.title' => 'All',
			'app.translation_engine_types.title' => 'Engine Type',
			'app.translation_engines.title' => 'Text Translation Engines',
			'app.translation_engines.msg.no_available_engines' => 'No available engines',
			'app.translation_engines.private.title' => 'Private',
			'app.translation_engines_new.title' => 'Add Text Translation Engine',
			'app.translation_engines_new.engine_type.title' => 'Engine type',
			'app.translation_engines_new.support_interface.title' => 'Support interface',
			'app.translation_engines_new.option.title' => 'Option',
			'app.translation_targets.kNew.title' => 'Add Translation Target',
			'app.translation_targets.kNew.title_with_edit' => 'Edit Translation Target',
			'app.translation_targets.kNew.source_language' => 'Source language',
			'app.translation_targets.kNew.target_language' => 'Target language',
			'widget.record_shortcut_dialog.title' => 'Customize your shortcut',
			_ => null,
		};
	}
}
