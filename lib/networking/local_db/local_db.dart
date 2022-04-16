import 'dart:convert';
import 'dart:io';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../includes.dart';

export 'modifiers/private_engines_modifier.dart';
export 'modifiers/private_ocr_engines_modifier.dart';
export 'modifiers/engines_modifier.dart';
export 'modifiers/ocr_engines_modifier.dart';
export 'modifiers/preferences_modifier.dart';
export 'modifiers/translation_targets_modifier.dart';

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

class LocalDb extends _ConfigChangeNotifier {
  final DbData defaultDbData;

  LocalDb({
    required this.defaultDbData,
  });

  late DbData dbData;

  PrivateEnginesModifier? _privateEnginesModifier;
  PrivateOcrEnginesModifier? _privateOcrEnginesModifier;

  EnginesModifier? _enginesModifier;
  OcrEnginesModifier? _ocrEnginesModifier;
  PreferencesModifier? _preferencesModifier;
  TranslationTargetsModifier? _translationTargetsModifier;

  Future<File> get _localFile async {
    final appDir = await Config.instance.getAppDirectory();
    if (!appDir.existsSync()) {
      appDir.createSync(recursive: true);
    }
    return File('${appDir.path}/db.json');
  }

  Future<DbData> read() async {
    dbData = defaultDbData;
    if (kIsWeb) {
      // TODO: Save to localStorage.
    } else {
      final file = await _localFile;
      if (file.existsSync()) {
        String jsonString = await file.readAsString();
        dbData = DbData.fromJson(json.decode(jsonString));
      }
    }

    notifyListeners();
    return dbData;
  }

  Future<void> write() async {
    notifyListeners();

    if (kIsWeb) return;

    final file = await _localFile;
    final String jsonString = prettyJsonString(
      dbData.toJson().removeNulls(),
    );
    await file.writeAsString(jsonString);
  }

  PrivateEnginesModifier get privateEngines {
    return privateEngine(null);
  }

  PrivateEnginesModifier privateEngine(String? id) {
    _privateEnginesModifier ??= PrivateEnginesModifier(dbData);
    _privateEnginesModifier?.setId(id);
    return _privateEnginesModifier!;
  }

  PrivateOcrEnginesModifier get privateOcrEngines {
    return privateOcrEngine(null);
  }

  PrivateOcrEnginesModifier privateOcrEngine(String? id) {
    _privateOcrEnginesModifier ??= PrivateOcrEnginesModifier(dbData);
    _privateOcrEnginesModifier?.setId(id);
    return _privateOcrEnginesModifier!;
  }

  EnginesModifier get engines {
    return engine(null);
  }

  EnginesModifier engine(String? id) {
    _enginesModifier ??= EnginesModifier(dbData);
    _enginesModifier?.setId(id);
    return _enginesModifier!;
  }

  OcrEnginesModifier get ocrEngines {
    return ocrEngine(null);
  }

  OcrEnginesModifier ocrEngine(String? id) {
    _ocrEnginesModifier ??= OcrEnginesModifier(dbData);
    _ocrEnginesModifier?.setId(id);
    return _ocrEnginesModifier!;
  }

  PreferencesModifier get preferences {
    return preference(null);
  }

  PreferencesModifier preference(String? key) {
    _preferencesModifier ??= PreferencesModifier(dbData);
    _preferencesModifier?.setKey(key);
    return _preferencesModifier!;
  }

  TranslationTargetsModifier get translationTargets {
    return translationTarget(null);
  }

  TranslationTargetsModifier translationTarget(String? id) {
    _translationTargetsModifier ??= TranslationTargetsModifier(dbData);
    _translationTargetsModifier?.setId(id);
    return _translationTargetsModifier!;
  }
}

class DbData {
  List<TranslationEngineConfig>? privateEngineList;
  List<OcrEngineConfig>? privateOcrEngineList;
  List<UserPreference>? preferenceList;
  List<TranslationTarget>? translationTargetList;

  List<TranslationEngineConfig> get engineList => [...?privateEngineList];
  List<OcrEngineConfig> get ocrEngineList => [...?privateOcrEngineList];

  DbData({
    this.privateEngineList,
    this.privateOcrEngineList,
    this.preferenceList,
    this.translationTargetList,
  });

  factory DbData.fromJson(Map<String, dynamic> json) {
    List<TranslationEngineConfig> privateEngineList = [];
    List<OcrEngineConfig> privateOcrEngineList = [];
    List<UserPreference> preferenceList = [];
    List<TranslationTarget> translationTargetList = [];

    if (json['privateEngineList'] != null) {
      Iterable l = json['privateEngineList'] as List;
      privateEngineList =
          l.map((item) => TranslationEngineConfig.fromJson(item)).toList();
    }
    if (json['privateOcrEngineList'] != null) {
      Iterable l = json['privateOcrEngineList'] as List;
      privateOcrEngineList =
          l.map((item) => OcrEngineConfig.fromJson(item)).toList();
    }
    if (json['preferenceList'] != null) {
      Iterable l = json['preferenceList'] as List;
      preferenceList = l.map((item) => UserPreference.fromJson(item)).toList();
    }
    if (json['translationTargetList'] != null) {
      Iterable l = json['translationTargetList'] as List;
      translationTargetList =
          l.map((item) => TranslationTarget.fromJson(item)).toList();
    }

    return DbData(
      privateEngineList: privateEngineList,
      privateOcrEngineList: privateOcrEngineList,
      preferenceList: preferenceList,
      translationTargetList: translationTargetList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'privateEngineList':
          (privateEngineList ?? []).map((e) => e.toJson()).toList(),
      'privateOcrEngineList':
          (privateOcrEngineList ?? []).map((e) => e.toJson()).toList(),
      'preferenceList': (preferenceList ?? []).map((e) => e.toJson()).toList(),
      'translationTargetList':
          (translationTargetList ?? []).map((e) => e.toJson()).toList(),
    };
  }
}

LocalDb sharedLocalDb = LocalDb(
  defaultDbData: DbData(
    privateEngineList: [],
    privateOcrEngineList: [],
    translationTargetList: [
      TranslationTarget(
        sourceLanguage: kLanguageEN,
        targetLanguage: kLanguageZH,
      ),
      TranslationTarget(
        sourceLanguage: kLanguageZH,
        targetLanguage: kLanguageEN,
      ),
    ],
  ),
);

Future<void> initLocalDb() async {
  await sharedLocalDb.read();
}
