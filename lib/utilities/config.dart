import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

import '../includes.dart';

const kShortcutShowOrHide = 'shortcut_show_or_hide';
const kShortcutHide = 'shortcut_hide';
const kShortcutExtractFromScreenSelection =
    'shortcut_extract_from_screen_selection';
const kShortcutExtractFromScreenCapture =
    'shortcut_extract_from_screen_capture';
const kShortcutExtractFromClipboard = 'shortcut_extract_from_clipboard';

Future<void> initConfig() async {
  await ConfigManager.instance.reload();
}

class _ListenerEntry extends LinkedListEntry<_ListenerEntry> {
  _ListenerEntry(this.listener);
  final VoidCallback listener;
}

class _ConfigChangeNotifier implements Listenable {
  final LinkedList<_ListenerEntry> _listeners = LinkedList<_ListenerEntry>();

  @protected
  bool get hasListeners {
    return _listeners.isNotEmpty;
  }

  @override
  void addListener(VoidCallback listener) {
    _listeners.add(_ListenerEntry(listener));
  }

  @override
  void removeListener(VoidCallback listener) {
    for (final _ListenerEntry entry in _listeners) {
      if (entry.listener == listener) {
        entry.unlink();
        return;
      }
    }
  }

  @mustCallSuper
  void dispose() {
    _listeners.clear();
  }

  @protected
  @visibleForTesting
  void notifyListeners() {
    if (_listeners.isEmpty) return;

    final List<_ListenerEntry> localListeners =
        List<_ListenerEntry>.from(_listeners);

    for (final _ListenerEntry entry in localListeners) {
      try {
        if (entry.list != null) entry.listener();
      } catch (exception, stack) {
        FlutterError.reportError(FlutterErrorDetails(
          exception: exception,
          stack: stack,
        ));
      }
    }
  }
}

class Config {
  Config._();

  /// The shared instance of [Config].
  static final Config instance = Config._();

  Directory? dataDirectory;

  Future<Directory> getAppDirectory() async {
    if (!kIsWeb && dataDirectory == null) {
      final docDir = await getApplicationDocumentsDirectory();
      final homeDir = docDir.parent;

      var oldDataDirectory = Directory(path.join(homeDir.path, 'biyiapp-dev'));
      dataDirectory = Directory(path.join(homeDir.path, '.biyi-dev'));
      if (oldDataDirectory.existsSync()) {
        await oldDataDirectory.rename(dataDirectory!.path);
      }
      if (!dataDirectory!.existsSync()) {
        dataDirectory!.createSync(recursive: true);
      }
    }
    return dataDirectory!;
  }

  late String translationMode;
  late String defaultEngineId;
  late bool doubleClickCopyResult;
  late String defaultOcrEngineId;
  late bool autoCopyDetectedText;
  late bool showTrayIcon;
  late double maxWindowHeight;
  late String appLanguage;
  late ThemeMode themeMode;
  late String inputSetting;
  late HotKey shortcutShowOrHide;
  late HotKey shortcutHide;
  late HotKey shortcutExtractFromScreenSelection;
  late HotKey shortcutExtractFromScreenCapture;
  late HotKey shortcutExtractFromClipboard;
  HotKey get shortcutInputSettingSubmitWithMetaEnter {
    if (kIsMacOS) {
      return HotKey(
        KeyCode.enter,
        modifiers: [KeyModifier.meta],
        scope: HotKeyScope.inapp,
      );
    }
    return HotKey(
      KeyCode.enter,
      modifiers: [KeyModifier.control],
      scope: HotKeyScope.inapp,
    );
  }
}

class ConfigManager extends _ConfigChangeNotifier {
  ConfigManager._();

  /// The shared instance of [ConfigManager].
  static final ConfigManager instance = ConfigManager._();

  Config getConfig() => Config.instance;

  Future<void> reload() async {
    Config.instance.translationMode = (await _getString(
      kPrefTranslationMode,
      defaultValue: kTranslationModeManual,
    ))!;
    Config.instance.defaultEngineId = (await _getString(
      kPrefDefaultEngineId,
    ))!;
    Config.instance.doubleClickCopyResult = (await _getBool(
      kPrefDoubleClickCopyResult,
      defaultValue: true,
    ))!;
    Config.instance.defaultOcrEngineId = (await _getString(
      kPrefDefaultOcrEngineId,
    ))!;
    Config.instance.autoCopyDetectedText = (await _getBool(
      kPrefAutoCopyDetectedText,
      defaultValue: true,
    ))!;
    Config.instance.showTrayIcon = (await _getBool(
      kPrefShowTrayIcon,
      defaultValue: true,
    ))!;
    Config.instance.maxWindowHeight = double.parse((await _getString(
      kPrefMaxWindowHeight,
      defaultValue: '800',
    ))!);
    Config.instance.appLanguage = (await _getString(
      kPrefAppLanguage,
      defaultValue: kLanguageZH,
    ))!;
    String _themeModeString = (await _getString(
      kPrefThemeMode,
      defaultValue: describeEnum(ThemeMode.light),
    ))!;
    Config.instance.themeMode = kKnownThemeModes[_themeModeString]!;
    Config.instance.inputSetting = (await _getString(
      kPrefInputSetting,
      defaultValue: kInputSettingSubmitWithEnter,
    ))!;
    Config.instance.shortcutHide = (await getShortcut(
      kShortcutHide,
      defaultValue: HotKey(
        KeyCode.escape,
        modifiers: [],
        identifier: kShortcutHide,
        scope: HotKeyScope.inapp,
      ),
    ))!;
    Config.instance.shortcutShowOrHide = (await getShortcut(
      kShortcutShowOrHide,
      defaultValue: HotKey(
        KeyCode.digit1,
        modifiers: [KeyModifier.alt],
        identifier: kShortcutShowOrHide,
      ),
    ))!;
    Config.instance.shortcutExtractFromScreenSelection = (await getShortcut(
      kShortcutExtractFromScreenSelection,
      defaultValue: HotKey(
        KeyCode.keyQ,
        modifiers: [KeyModifier.alt],
        identifier: kShortcutExtractFromScreenSelection,
      ),
    ))!;
    Config.instance.shortcutExtractFromScreenCapture = (await getShortcut(
      kShortcutExtractFromScreenCapture,
      defaultValue: HotKey(
        KeyCode.keyW,
        modifiers: [KeyModifier.alt],
        identifier: kShortcutExtractFromScreenCapture,
      ),
    ))!;
    Config.instance.shortcutExtractFromClipboard = (await getShortcut(
      kShortcutExtractFromClipboard,
      defaultValue: HotKey(
        KeyCode.keyE,
        modifiers: [KeyModifier.alt],
        identifier: kShortcutExtractFromClipboard,
      ),
    ))!;
  }

  Future<void> setTranslationMode(String value) {
    return _setString(kPrefTranslationMode, value);
  }

  Future<void> setDefaultEngineId(String value) {
    return _setString(kPrefDefaultEngineId, value);
  }

  Future<void> setDoubleClickCopyResult(bool value) {
    return _setBool(kPrefDoubleClickCopyResult, value);
  }

  Future<void> setDefaultOcrEngineId(String value) {
    return _setString(kPrefDefaultOcrEngineId, value);
  }

  Future<void> setAutoCopyDetectedText(bool value) {
    return _setBool(kPrefAutoCopyDetectedText, value);
  }

  Future<void> setShowTrayIcon(bool value) {
    return _setBool(kPrefShowTrayIcon, value);
  }

  Future<void> setMaxWindowHeight(double value) {
    return _setString(kPrefMaxWindowHeight, value.toString());
  }

  Future<void> setAppLanguage(String value) {
    return _setString(kPrefAppLanguage, value);
  }

  Future<void> setThemeMode(ThemeMode value) {
    return _setString(kPrefThemeMode, describeEnum(value));
  }

  Future<void> setInputSetting(String value) {
    return _setString(kPrefInputSetting, value);
  }

  Future<void> setShortcut(String key, HotKey hotKey) async {
    return _setString(
      key,
      json.encode(hotKey.toJson()),
    );
  }

  Future<HotKey?> getShortcut(String key, {HotKey? defaultValue}) async {
    HotKey? hotKey;
    String? jsonString = await _getString(key);
    if (jsonString != null && jsonString.isNotEmpty) {
      hotKey = HotKey.fromJson(json.decode(jsonString));
    }
    return hotKey ?? defaultValue;
  }

  Future<void> _setString(String key, String value) async {
    UserPreference? pref = sharedLocalDb.preference(key).get();
    if (pref == null) {
      sharedLocalDb.preferences.create(key: key, value: value);
    } else {
      sharedLocalDb.preference(key).update(value: value);
    }

    sharedLocalDb.write();

    await reload();
    notifyListeners();
  }

  Future<String?> _getString(String key, {String? defaultValue}) async {
    UserPreference? pref = sharedLocalDb.preference(key).get();
    return pref?.value ?? defaultValue;
  }

  Future<void> _setBool(String key, bool value) async {
    UserPreference? pref = sharedLocalDb.preference(key).get();
    if (pref == null) {
      sharedLocalDb.preferences.create(
        key: key,
        type: kPreferenceTypeBool,
        value: '$value',
      );
    } else {
      sharedLocalDb.preference(key).update(
            type: kPreferenceTypeBool,
            value: '$value',
          );
    }

    sharedLocalDb.write();

    await reload();
    notifyListeners();
  }

  Future<bool?> _getBool(String key, {bool? defaultValue}) async {
    UserPreference? pref = sharedLocalDb.preference(key).get();
    return pref?.boolValue ?? defaultValue;
  }
}
