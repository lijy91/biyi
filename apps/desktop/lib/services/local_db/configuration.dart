import 'dart:convert';

import 'package:biyi_advanced_features/models/user_preference.dart';
import 'package:biyi_app/services/api_client.dart';
import 'package:biyi_app/services/local_db/local_db.dart';
import 'package:biyi_app/utils/language_util.dart';
import 'package:flutter/services.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:uikit/uikit.dart';
import 'package:uni_platform/uni_platform.dart';

const Map<String, ThemeMode> kKnownThemeModes = <String, ThemeMode>{
  'light': ThemeMode.light,
  'dark': ThemeMode.dark,
  'system': ThemeMode.system,
};

@Deprecated('No longer used.')
class Configuration {
  @Deprecated('No longer used.')
  String get translationMode {
    return _getString(kPrefTranslationMode) ?? kTranslationModeManual;
  }

  @Deprecated('No longer used.')
  set translationMode(String value) {
    _setString(kPrefTranslationMode, value);
  }

  @Deprecated('No longer used.')
  String? get defaultEngineId {
    return _getString(kPrefDefaultEngineId);
  }

  @Deprecated('No longer used.')
  set defaultEngineId(String? value) {
    _setString(kPrefDefaultEngineId, value);
  }

  @Deprecated('No longer used.')
  TranslationEngineConfig? get defaultEngineConfig {
    return localDb.proEngine(defaultEngineId).get() ??
        localDb.privateEngine(defaultEngineId).get();
  }

  @Deprecated('No longer used.')
  String? get defaultTranslateEngineId {
    return _getString(kPrefDefaultTranslateEngineId);
  }

  @Deprecated('No longer used.')
  set defaultTranslateEngineId(String? value) {
    _setString(kPrefDefaultTranslateEngineId, value);
  }

  @Deprecated('No longer used.')
  TranslationEngineConfig? get defaultTranslateEngineConfig {
    return localDb.proEngine(defaultTranslateEngineId).get() ??
        localDb.privateEngine(defaultTranslateEngineId).get();
  }

  @Deprecated('No longer used.')
  bool get doubleClickCopyResult {
    return _getBool(kPrefDoubleClickCopyResult) ?? true;
  }

  @Deprecated('No longer used.')
  set doubleClickCopyResult(bool value) {
    _setBool(kPrefDoubleClickCopyResult, value);
  }

  @Deprecated('No longer used.')
  String? get defaultOcrEngineId {
    return _getString(kPrefDefaultOcrEngineId);
  }

  @Deprecated('No longer used.')
  set defaultOcrEngineId(String? value) {
    _setString(kPrefDefaultOcrEngineId, value);
  }

  @Deprecated('No longer used.')
  bool get autoCopyDetectedText {
    return _getBool(kPrefAutoCopyDetectedText) ?? true;
  }

  @Deprecated('No longer used.')
  set autoCopyDetectedText(bool value) {
    _setBool(kPrefAutoCopyDetectedText, value);
  }

  @Deprecated('No longer used.')
  bool get showTrayIcon {
    return _getBool(kPrefShowTrayIcon) ?? true;
  }

  @Deprecated('No longer used.')
  set showTrayIcon(bool value) {
    _setBool(kPrefShowTrayIcon, value);
  }

  @Deprecated('No longer used.')
  double get maxWindowHeight {
    String? stringValue = _getString(kPrefMaxWindowHeight);
    if (stringValue != null) {
      return double.parse(stringValue);
    }
    return 800;
  }

  @Deprecated('No longer used.')
  set maxWindowHeight(value) {
    _setString(kPrefMaxWindowHeight, value.toString());
  }

  @Deprecated('No longer used.')
  String get appLanguage {
    return _getString(kPrefAppLanguage) ?? kLanguageZH;
  }

  @Deprecated('No longer used.')
  set appLanguage(value) {
    _setString(kPrefAppLanguage, value);
  }

  @Deprecated('No longer used.')
  ThemeMode get themeMode {
    String themeModeString = _getString(kPrefThemeMode) ?? ThemeMode.light.name;
    return kKnownThemeModes[themeModeString]!;
  }

  @Deprecated('No longer used.')
  set themeMode(ThemeMode value) {
    _setString(kPrefThemeMode, value.name);
  }

  @Deprecated('No longer used.')
  String get inputSetting {
    return _getString(kPrefInputSetting) ?? kInputSettingSubmitWithEnter;
  }

  @Deprecated('No longer used.')
  set inputSetting(value) {
    _setString(kPrefInputSetting, value);
  }

  @Deprecated('No longer used.')
  HotKey get shortcutShowOrHide {
    return _getShortcut(kShortcutShowOrHide) ??
        HotKey(
          key: PhysicalKeyboardKey.digit1,
          modifiers: [HotKeyModifier.alt],
          identifier: kShortcutShowOrHide,
        );
  }

  @Deprecated('No longer used.')
  set shortcutShowOrHide(value) {
    _setShortcut(kShortcutShowOrHide, value);
  }

  @Deprecated('No longer used.')
  HotKey get shortcutHide {
    return _getShortcut(kShortcutHide) ??
        HotKey(
          key: PhysicalKeyboardKey.escape,
          modifiers: [],
          identifier: kShortcutHide,
          scope: HotKeyScope.inapp,
        );
  }

  @Deprecated('No longer used.')
  set shortcutHide(value) {
    _setShortcut(kShortcutHide, value);
  }

  @Deprecated('No longer used.')
  HotKey get shortcutExtractFromScreenSelection {
    return _getShortcut(kShortcutExtractFromScreenSelection) ??
        HotKey(
          key: PhysicalKeyboardKey.keyQ,
          modifiers: [HotKeyModifier.alt],
          identifier: kShortcutExtractFromScreenSelection,
        );
  }

  @Deprecated('No longer used.')
  set shortcutExtractFromScreenSelection(value) {
    _setShortcut(kShortcutExtractFromScreenSelection, value);
  }

  @Deprecated('No longer used.')
  HotKey get shortcutExtractFromScreenCapture {
    return _getShortcut(kShortcutExtractFromScreenCapture) ??
        HotKey(
          key: PhysicalKeyboardKey.keyW,
          modifiers: [HotKeyModifier.alt],
          identifier: kShortcutExtractFromScreenCapture,
        );
  }

  @Deprecated('No longer used.')
  set shortcutExtractFromScreenCapture(value) {
    _setShortcut(kShortcutExtractFromScreenCapture, value);
  }

  @Deprecated('No longer used.')
  HotKey get shortcutExtractFromClipboard {
    return _getShortcut(kShortcutExtractFromClipboard) ??
        HotKey(
          key: PhysicalKeyboardKey.keyE,
          modifiers: [HotKeyModifier.alt],
          identifier: kShortcutExtractFromClipboard,
        );
  }

  @Deprecated('No longer used.')
  set shortcutExtractFromClipboard(value) {
    _setShortcut(kShortcutExtractFromClipboard, value);
  }

  @Deprecated('No longer used.')
  HotKey get shortcutTranslateInputContent {
    return _getShortcut(kPrefShortcutTranslateInputContent) ??
        HotKey(
          key: PhysicalKeyboardKey.keyZ,
          modifiers: [HotKeyModifier.alt],
          identifier: kPrefShortcutTranslateInputContent,
        );
  }

  @Deprecated('No longer used.')
  set shortcutTranslateInputContent(value) {
    _setShortcut(kPrefShortcutTranslateInputContent, value);
  }

  @Deprecated('No longer used.')
  HotKey get shortcutInputSettingSubmitWithMetaEnter {
    if (UniPlatform.isMacOS) {
      return HotKey(
        key: PhysicalKeyboardKey.enter,
        modifiers: [HotKeyModifier.meta],
        scope: HotKeyScope.inapp,
      );
    }
    return HotKey(
      key: PhysicalKeyboardKey.enter,
      modifiers: [HotKeyModifier.control],
      scope: HotKeyScope.inapp,
    );
  }

  @Deprecated('No longer used.')
  void setShortcut(String key, HotKey hotKey) {
    _setShortcut(key, hotKey);
  }

  @Deprecated('No longer used.')
  String? _getString(String key) {
    UserPreference? pref = localDb.preference(key).get();
    return pref?.value;
  }

  @Deprecated('No longer used.')
  void _setString(String key, String? value) {
    if (value == null) {
      localDb.preference(key).delete();
    } else {
      localDb.preference(key).updateOrCreate(value: value);
    }
  }

  @Deprecated('No longer used.')
  bool? _getBool(String key) {
    UserPreference? pref = localDb.preference(key).get();
    return pref?.boolValue;
  }

  @Deprecated('No longer used.')
  Future<void> _setBool(String key, bool value) async {
    localDb //
        .preference(key)
        .updateOrCreate(
          type: kPreferenceTypeBool,
          value: '$value',
        );
  }

  @Deprecated('No longer used.')
  void _setShortcut(String key, HotKey hotKey) {
    _setString(
      key,
      json.encode(hotKey.toJson()),
    );
  }

  @Deprecated('No longer used.')
  HotKey? _getShortcut(String key) {
    HotKey? hotKey;
    String? jsonString = _getString(key);
    if (jsonString != null && jsonString.isNotEmpty) {
      hotKey = HotKey.fromJson(json.decode(jsonString));
    }
    return hotKey;
  }
}
