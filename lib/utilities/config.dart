import 'dart:collection';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:path_provider/path_provider.dart';

import '../includes.dart';

Future<void> initConfig() async {
  await ConfigManager.instance.reload();
}

class _ListenerEntry extends LinkedListEntry<_ListenerEntry> {
  _ListenerEntry(this.listener);
  final VoidCallback listener;
}

class _ConfigChangeNotifier implements Listenable {
  LinkedList<_ListenerEntry> _listeners = LinkedList<_ListenerEntry>();

  bool _debugAssertNotDisposed() {
    assert(() {
      if (_listeners == null) {
        throw FlutterError('A $runtimeType was used after being disposed.\n'
            'Once you have called dispose() on a $runtimeType, it can no longer be used.');
      }
      return true;
    }());
    return true;
  }

  @protected
  bool get hasListeners {
    assert(_debugAssertNotDisposed());
    return _listeners.isNotEmpty;
  }

  @override
  void addListener(VoidCallback listener) {
    assert(_debugAssertNotDisposed());
    _listeners.add(_ListenerEntry(listener));
  }

  @override
  void removeListener(VoidCallback listener) {
    assert(_debugAssertNotDisposed());
    for (final _ListenerEntry entry in _listeners) {
      if (entry.listener == listener) {
        entry.unlink();
        return;
      }
    }
  }

  @mustCallSuper
  void dispose() {
    assert(_debugAssertNotDisposed());
    _listeners = null;
  }

  @protected
  @visibleForTesting
  void notifyListeners() {
    assert(_debugAssertNotDisposed());
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

  Future<Directory> getAppDirectory() async {
    final docDir = await getApplicationDocumentsDirectory();
    final appDir = Directory('${docDir.parent.path}/biyiapp');
    if (!appDir.existsSync()) {
      appDir.createSync(recursive: true);
    }
    return appDir;
  }

  String translationMode;
  String defaultEngineId;
  String defaultOcrEngineId;
  String appLanguage;
  ThemeMode themeMode;
  String inputSetting;
  HotKey shortcutShowOrHide = HotKey(
    KeyCode.tab,
    modifiers: [KeyModifier.alt],
  );
  HotKey shortcutExtractFromScreenSelection = HotKey(
    KeyCode.keyQ,
    modifiers: [KeyModifier.alt],
  );
  HotKey shortcutExtractFromScreenCapture = HotKey(
    KeyCode.keyW,
    modifiers: [KeyModifier.alt],
  );
  HotKey get shortcutInputSettingSubmitWithMetaEnter {
    return HotKey(
      KeyCode.enter,
      modifiers: [KeyModifier.meta],
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
    Config.instance.translationMode = await _getString(
      kPrefTranslationMode,
      defaultValue: kTranslationModeManual,
    );
    Config.instance.defaultEngineId = await _getString(
      kPrefDefaultEngineId,
    );
    Config.instance.defaultOcrEngineId = await _getString(
      kPrefDefaultOcrEngineId,
    );
    Config.instance.appLanguage = await _getString(
      kPrefAppLanguage,
      defaultValue: kLanguageZH,
    );
    String _themeModeString = await _getString(
      kPrefThemeMode,
      defaultValue: describeEnum(ThemeMode.light),
    );
    Config.instance.themeMode = kKnownThemeModes[_themeModeString];
    Config.instance.inputSetting = await _getString(
      kPrefInputSetting,
      defaultValue: kInputSettingSubmitWithEnter,
    );
  }

  Future<void> setTranslationMode(String value) {
    return _setString(kPrefTranslationMode, value);
  }

  Future<void> setDefaultEngineId(String value) {
    return _setString(kPrefDefaultEngineId, value);
  }

  Future<void> setDefaultOcrEngineId(String value) {
    return _setString(kPrefDefaultOcrEngineId, value);
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

  Future<void> _setString(String key, String value) async {
    UserPreference pref = sharedLocalDb.preference(key).get();
    if (pref == null) {
      sharedLocalDb.preferences.create(key: key, value: value);
    } else {
      sharedLocalDb.preference(key).update(value: value);
    }

    sharedLocalDb.write();

    await reload();
    notifyListeners();
  }

  Future<String> _getString(String key, {String defaultValue}) async {
    UserPreference pref = sharedLocalDb.preference(key).get();
    return pref?.value ?? defaultValue;
  }

  Future<void> _setBool(String key, bool value) async {
    UserPreference pref = sharedLocalDb.preference(key).get();
    if (pref == null) {
      sharedLocalDb.preferences.create(key: key, value: '$value');
    } else {
      sharedLocalDb.preference(key).update(value: '$value');
    }

    sharedLocalDb.write();

    await reload();
    notifyListeners();
  }

  Future<bool> _getBool(String key, {bool defaultValue}) async {
    UserPreference pref = sharedLocalDb.preference(key).get();
    return pref?.boolValue ?? defaultValue;
  }
}
