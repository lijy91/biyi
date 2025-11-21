import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:biyi_app/models/settings_base.dart';
import 'package:biyi_app/models/translation_target.dart';
import 'package:biyi_app/services/api_client.dart';
import 'package:biyi_app/services/local_db/migrate_old_settings.dart';
import 'package:biyi_app/services/ocr_client/ocr_client.dart';
import 'package:biyi_app/states/modifiers/ocr_engines_modifier.dart';
import 'package:biyi_app/states/modifiers/translation_engines_modifier.dart';
import 'package:biyi_app/states/modifiers/translation_targets_modifier.dart';
import 'package:biyi_app/utils/utils.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:ocr_engine_builtin/ocr_engine_builtin.dart';
import 'package:uikit/uikit.dart' show ThemeMode;

export 'package:biyi_app/models/settings_base.dart';

Future<File> _getOldSettingsMigratedFile() async {
  final appDir = await getAppDirectory();
  return File('${appDir.path}/old_settings_migrated.json');
}

Future<File> _getSettingsFile() async {
  final appDir = await getAppDirectory();
  return File('${appDir.path}/settings.json');
}

class Settings extends SettingsBase with ChangeNotifier {
  Settings._();

  /// The shared instance of [Settings].
  static final Settings instance = Settings._();

  TranslationTargetsModifier? _translationTargetsModifier;
  OcrEnginesModifier? _proOcrEnginesModifier;
  OcrEnginesModifier? _privateOcrEnginesModifier;
  TranslationEnginesModifier? _proTranslationEnginesModifier;
  TranslationEnginesModifier? _privateTranslationEnginesModifier;

  Future<void> loadFromLocalFile() => _readFromLocalFile();

  /// Sync pro translation engines and ocr engines with cloud server
  Future<void> syncWithCloudServer() async {
    var oldProEngineList = proTranslationEngines.list();
    var oldProOcrEngineList = proOcrEngines.list();

    List<TranslationEngineConfig> newProEngineList = [];
    List<OcrEngineConfig> newProOcrEngineList = [];

    try {
      newProEngineList = await apiClient.engines.list();
      newProEngineList = newProEngineList.map((engine) {
        TranslationEngineConfig? oldEngine = oldProEngineList.firstWhereOrNull(
          (e) => e.id == engine.id,
        );
        if (oldEngine != null) {
          engine.disabled = oldEngine.disabled;
        }
        return engine;
      }).toList();

      proTranslationEngines.deleteAll();
      for (var item in newProEngineList) {
        proTranslationEngine(item.id).updateOrCreate(
          type: item.type,
          option: item.option,
          supportedScopes: item.supportedScopes.map((e) => e.name).toList(),
          disabled: item.disabled,
        );
      }
    } catch (error) {
      // skip error
    }

    try {
      newProOcrEngineList = await apiClient.ocrEngines.list();
      newProOcrEngineList = newProOcrEngineList.map((engine) {
        var oldOrcEngine = oldProOcrEngineList.firstWhereOrNull(
          (e) => e.id == engine.id,
        );
        if (oldOrcEngine != null) {
          engine.disabled = oldOrcEngine.disabled;
        }

        return engine;
      }).toList();

      newProOcrEngineList.removeWhere(
        (e) => e.type == kOcrEngineTypeBuiltIn,
      );

      try {
        if (await kDefaultBuiltInOcrEngine.isSupportedOnCurrentPlatform()) {
          newProOcrEngineList.insert(
            0,
            OcrEngineConfig(
              id: kDefaultBuiltInOcrEngine.identifier,
              type: kDefaultBuiltInOcrEngine.type,
              option: kDefaultBuiltInOcrEngine.option ?? {},
              disabled: true,
            ),
          );
        }
      } catch (error) {
        // skip error
      }

      proOcrEngines.deleteAll();
      for (var item in newProOcrEngineList) {
        proOcrEngine(item.id).updateOrCreate(
          type: item.type,
          option: item.option,
          disabled: item.disabled,
        );
      }
    } catch (error) {
      // skip error
    }

    if (defaultTranslationEngineId == null ||
        defaultTranslationEngineConfig == null) {
      defaultTranslationEngineId =
          newProEngineList.firstWhere((e) => e.type == 'baidu').id;
    }

    if (defaultDetectLanguageEngineId == null ||
        defaultDetectLanguageEngineConfig == null) {
      defaultDetectLanguageEngineId =
          newProEngineList.firstWhere((e) => e.type == 'baidu').id;
    }

    if (defaultOcrEngineId == null || defaultOcrEngineConfig == null) {
      defaultOcrEngineId = newProOcrEngineList
          .firstWhere((e) => e.type == 'built_in' || e.type == 'tesseract')
          .id;
    }
    await _writeToLocalFile();
  }

  Locale get locale => languageToLocale(displayLanguage ?? 'en');

  set locale(Locale locale) {
    update(displayLanguage: locale.toLanguageTag());
  }

  TranslationTargetsModifier get transTargets {
    _translationTargetsModifier ??= TranslationTargetsModifier(this);
    return _translationTargetsModifier!;
  }

  TranslationTargetsModifier transTarget(String? id) {
    return TranslationTargetsModifier(this, id: id);
  }

  OcrEnginesModifier get proOcrEngines {
    _proOcrEnginesModifier ??= OcrEnginesModifier(this, group: 'pro');
    return _proOcrEnginesModifier!;
  }

  OcrEnginesModifier proOcrEngine(String? id) {
    return OcrEnginesModifier(this, group: 'pro', id: id);
  }

  OcrEnginesModifier get privateOcrEngines {
    _privateOcrEnginesModifier ??= OcrEnginesModifier(this, group: 'private');
    return _privateOcrEnginesModifier!;
  }

  OcrEnginesModifier privateOcrEngine(String? id) {
    return OcrEnginesModifier(this, group: 'private', id: id);
  }

  TranslationEnginesModifier get proTranslationEngines {
    _proTranslationEnginesModifier ??=
        TranslationEnginesModifier(this, group: 'pro');
    return _proTranslationEnginesModifier!;
  }

  TranslationEnginesModifier proTranslationEngine(String? id) {
    return TranslationEnginesModifier(this, group: 'pro', id: id);
  }

  TranslationEnginesModifier get privateTranslationEngines {
    _privateTranslationEnginesModifier ??=
        TranslationEnginesModifier(this, group: 'private');
    return _privateTranslationEnginesModifier!;
  }

  TranslationEnginesModifier privateTranslationEngine(String? id) {
    return TranslationEnginesModifier(this, group: 'private', id: id);
  }

  /// Update settings
  void update({
    String? defaultOcrEngineId,
    bool? autoCopyRecognizedText,
    String? defaultTranslationEngineId,
    TranslationMode? translationMode,
    String? defaultDetectLanguageEngineId,
    List<TranslationTarget>? translationTargets,
    bool? doubleClickCopyResult,
    InputSubmitMode? inputSubmitMode,
    ThemeMode? themeMode,
    bool? trayIconEnabled,
    double? maxWindowHeight,
    BoundShortcuts? boundShortcuts,
    String? displayLanguage,
    bool? autoStartEnabled,
    List<OcrEngineConfig>? ocrEngines,
    List<TranslationEngineConfig>? translationEngines,
    // Merge other settings
    Settings? settings,
  }) {
    this.defaultOcrEngineId = defaultOcrEngineId ??
        settings?.defaultOcrEngineId ??
        this.defaultOcrEngineId;
    this.autoCopyRecognizedText = autoCopyRecognizedText ??
        settings?.autoCopyRecognizedText ??
        this.autoCopyRecognizedText;
    this.defaultTranslationEngineId = defaultTranslationEngineId ??
        settings?.defaultTranslationEngineId ??
        this.defaultTranslationEngineId;
    this.translationMode =
        translationMode ?? settings?.translationMode ?? this.translationMode;
    this.defaultDetectLanguageEngineId = defaultDetectLanguageEngineId ??
        settings?.defaultDetectLanguageEngineId ??
        this.defaultDetectLanguageEngineId;
    this.translationTargets = translationTargets ??
        settings?.translationTargets ??
        this.translationTargets;
    this.doubleClickCopyResult = doubleClickCopyResult ??
        settings?.doubleClickCopyResult ??
        this.doubleClickCopyResult;
    this.inputSubmitMode =
        inputSubmitMode ?? settings?.inputSubmitMode ?? this.inputSubmitMode;
    this.themeMode = themeMode ?? settings?.themeMode ?? this.themeMode;
    this.trayIconEnabled =
        trayIconEnabled ?? settings?.trayIconEnabled ?? this.trayIconEnabled;
    this.maxWindowHeight =
        maxWindowHeight ?? settings?.maxWindowHeight ?? this.maxWindowHeight;
    this.boundShortcuts =
        boundShortcuts ?? settings?.boundShortcuts ?? this.boundShortcuts;
    this.displayLanguage =
        displayLanguage ?? settings?.displayLanguage ?? this.displayLanguage;
    this.autoStartEnabled =
        autoStartEnabled ?? settings?.autoStartEnabled ?? this.autoStartEnabled;
    this.ocrEngines = ocrEngines ?? settings?.ocrEngines ?? this.ocrEngines;
    this.translationEngines = translationEngines ??
        settings?.translationEngines ??
        this.translationEngines;

    notifyListeners();
  }

  void updateShortcuts({
    HotKey? showOrHide,
    HotKey? hide,
    HotKey? extractFromScreenSelection,
    HotKey? extractFromScreenCapture,
    HotKey? extractFromClipboard,
    HotKey? translateInputContent,
  }) {
    boundShortcuts.showOrHide = showOrHide ?? boundShortcuts.showOrHide;
    boundShortcuts.hide = hide ?? boundShortcuts.hide;
    boundShortcuts.extractFromScreenSelection =
        extractFromScreenSelection ?? boundShortcuts.extractFromScreenSelection;
    boundShortcuts.extractFromScreenCapture =
        extractFromScreenCapture ?? boundShortcuts.extractFromScreenCapture;
    boundShortcuts.extractFromClipboard =
        extractFromClipboard ?? boundShortcuts.extractFromClipboard;
    boundShortcuts.translateInputContent =
        translateInputContent ?? boundShortcuts.translateInputContent;
    notifyListeners();
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
    unawaited(_writeToLocalFile());
  }

  /// Load settings from local file
  Future<void> _readFromLocalFile() async {
    // Migrate old settings
    final oldSettingsMigratedFile = await _getOldSettingsMigratedFile();
    if (!oldSettingsMigratedFile.existsSync()) {
      await migrateOldSettings(this);
      await _writeToLocalFile();
      oldSettingsMigratedFile.writeAsStringSync(
        jsonEncode({'timestamp': DateTime.now().millisecondsSinceEpoch}),
      );
    }

    final settingsFile = await _getSettingsFile();
    if (settingsFile.existsSync()) {
      final json = jsonDecode(settingsFile.readAsStringSync());
      SettingsBase settings = SettingsBase.fromJson(json);
      defaultOcrEngineId = settings.defaultOcrEngineId;
      autoCopyRecognizedText = settings.autoCopyRecognizedText;
      defaultTranslationEngineId = settings.defaultTranslationEngineId;
      translationMode = settings.translationMode;
      defaultDetectLanguageEngineId = settings.defaultDetectLanguageEngineId;
      translationTargets = settings.translationTargets;
      doubleClickCopyResult = settings.doubleClickCopyResult;
      inputSubmitMode = settings.inputSubmitMode;
      themeMode = settings.themeMode;
      trayIconEnabled = settings.trayIconEnabled;
      maxWindowHeight = settings.maxWindowHeight;
      boundShortcuts = settings.boundShortcuts;
      displayLanguage = settings.displayLanguage;
      autoStartEnabled = settings.autoStartEnabled;
      ocrEngines = settings.ocrEngines;
      translationEngines = settings.translationEngines;
    }
  }

  /// Write to local file
  Future<void> _writeToLocalFile() async {
    const encoder = JsonEncoder.withIndent('  ');
    final settingsFile = await _getSettingsFile();
    settingsFile.writeAsStringSync(encoder.convert(toJson()));
  }
}
