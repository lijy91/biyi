// ignore_for_file: deprecated_member_use

import 'package:biyi_app/services/translate_client/translate_client.dart';
import 'package:biyi_app/states/settings.dart';
import 'package:biyi_app/utils/language_util.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:keypress_simulator/keypress_simulator.dart';
import 'package:screen_text_extractor/screen_text_extractor.dart';
import 'package:uni_platform/uni_platform.dart';
import 'package:uni_translate_client/uni_translate_client.dart';

class TranslateInputContentIntent extends Intent {}

class TranslateInputContentAction extends Action<TranslateInputContentIntent> {
  Future<void> _simulateEditingShortcutKeyPress(PhysicalKeyboardKey key) async {
    List<ModifierKey> modifiers = UniPlatform.select<List<ModifierKey>>(
      macos: [ModifierKey.metaModifier],
      otherwise: [ModifierKey.controlModifier],
    );
    await keyPressSimulator.simulateKeyDown(key, modifiers);
    await keyPressSimulator.simulateKeyUp(key, modifiers);
  }

  @override
  Future<void> invoke(covariant TranslateInputContentIntent intent) async {
    await _simulateEditingShortcutKeyPress(PhysicalKeyboardKey.keyA);
    await _simulateEditingShortcutKeyPress(PhysicalKeyboardKey.keyC);

    try {
      ExtractedData? extractedData = await screenTextExtractor.extract(
        mode: ExtractMode.screenSelection,
      );

      if ((extractedData?.text ?? '').isEmpty) {
        throw Exception('Extracted text is empty');
      }

      TranslateResponse translateResponse = await translateClient
          .use(Settings.instance.defaultTranslationEngineId!)
          .translate(
            TranslateRequest(
              text: extractedData?.text ?? '',
              sourceLanguage: kLanguageZH,
              targetLanguage: kLanguageEN,
            ),
          );

      TextTranslation? textTranslation =
          (translateResponse.translations).firstOrNull;

      if (textTranslation != null) {
        Clipboard.setData(ClipboardData(text: textTranslation.text));
      }
    } catch (error) {
      return;
    }

    await _simulateEditingShortcutKeyPress(PhysicalKeyboardKey.keyA);
    await _simulateEditingShortcutKeyPress(PhysicalKeyboardKey.keyV);
  }
}
