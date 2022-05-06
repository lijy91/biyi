import 'dart:io';

import 'package:hive/hive.dart';

import '../../includes.dart';

export 'modifiers/engines_modifier.dart';
export 'modifiers/ocr_engines_modifier.dart';
export 'modifiers/engines_modifier.dart';
export 'modifiers/ocr_engines_modifier.dart';
export 'modifiers/preferences_modifier.dart';
export 'modifiers/translation_targets_modifier.dart';
export 'configuration.dart';

class LocalDb {
  User user = User(id: -1);
  Configuration configuration = Configuration();

  EnginesModifier? _enginesModifier;
  OcrEnginesModifier? _ocrEnginesModifier;
  PreferencesModifier? _preferencesModifier;
  TranslationTargetsModifier? _translationTargetsModifier;

  EnginesModifier get engines {
    return engine(null);
  }

  EnginesModifier engine(String? id) {
    _enginesModifier ??= EnginesModifier();
    _enginesModifier?.setId(id);
    _enginesModifier?.setGroup(null);
    return _enginesModifier!;
  }

  OcrEnginesModifier get ocrEngines {
    return ocrEngine(null);
  }

  OcrEnginesModifier ocrEngine(String? id) {
    _ocrEnginesModifier ??= OcrEnginesModifier();
    _ocrEnginesModifier?.setId(id);
    _ocrEnginesModifier?.setGroup(null);
    return _ocrEnginesModifier!;
  }

  EnginesModifier get proEngines {
    return proEngine(null);
  }

  EnginesModifier proEngine(String? id) {
    _enginesModifier ??= EnginesModifier();
    _enginesModifier?.setId(id);
    _enginesModifier?.setGroup('pro');
    return _enginesModifier!;
  }

  OcrEnginesModifier get proOcrEngines {
    return proOcrEngine(null);
  }

  OcrEnginesModifier proOcrEngine(String? id) {
    _ocrEnginesModifier ??= OcrEnginesModifier();
    _ocrEnginesModifier?.setId(id);
    _ocrEnginesModifier?.setGroup('pro');
    return _ocrEnginesModifier!;
  }

  EnginesModifier get privateEngines {
    return privateEngine(null);
  }

  EnginesModifier privateEngine(String? id) {
    _enginesModifier ??= EnginesModifier();
    _enginesModifier?.setId(id);
    _enginesModifier?.setGroup('private');
    return _enginesModifier!;
  }

  OcrEnginesModifier get privateOcrEngines {
    return privateOcrEngine(null);
  }

  OcrEnginesModifier privateOcrEngine(String? id) {
    _ocrEnginesModifier ??= OcrEnginesModifier();
    _ocrEnginesModifier?.setId(id);
    _ocrEnginesModifier?.setGroup('private');
    return _ocrEnginesModifier!;
  }

  PreferencesModifier get preferences {
    return preference(null);
  }

  PreferencesModifier preference(String? key) {
    _preferencesModifier ??= PreferencesModifier();
    _preferencesModifier?.setKey(key);
    return _preferencesModifier!;
  }

  TranslationTargetsModifier get translationTargets {
    return translationTarget(null);
  }

  TranslationTargetsModifier translationTarget(String? id) {
    _translationTargetsModifier ??= TranslationTargetsModifier();
    _translationTargetsModifier?.setId(id);
    return _translationTargetsModifier!;
  }
}

final localDb = LocalDb();

Future<void> initLocalDb() async {
  Directory userDataDirectory = await getUserDataDirectory();

  await Hive.close();
  Hive.init(userDataDirectory.path);
  await Hive.openBox('preferences');
  await Hive.openBox('engines');
  await Hive.openBox('ocr_engines');
  await Hive.openBox('translation_targets');
}
