// ignore_for_file: deprecated_member_use_from_same_package

import 'package:biyi_app/models/settings_base.dart';
import 'package:biyi_app/services/local_db/local_db.dart';

Future<SettingsBase> migrateOldSettings(SettingsBase settings) async {
  final c = localDb.configuration;

  settings.defaultOcrEngineId = c.defaultOcrEngineId;
  settings.autoCopyRecognizedText = c.autoCopyDetectedText;
  settings.defaultTranslationEngineId = c.defaultEngineId;
  settings.translationMode = TranslationMode.fromString(c.translationMode);
  settings.defaultDetectLanguageEngineId = c.defaultEngineId;
  settings.translationTargets = localDb.translationTargets.list();
  settings.doubleClickCopyResult = c.doubleClickCopyResult;
  settings.inputSubmitMode = c.inputSetting == 'submit-with-enter'
      ? InputSubmitMode.enter
      : InputSubmitMode.metaEnter;
  settings.themeMode = c.themeMode;
  settings.trayIconEnabled = c.showTrayIcon;
  settings.maxWindowHeight = c.maxWindowHeight;
  settings.displayLanguage = c.appLanguage;
  settings.ocrEngines = localDb.ocrEngines.list();
  settings.translationEngines = localDb.engines.list();

  return settings;
}
