import 'dart:io';

import 'package:biyi_app/services/local_db/configuration.dart';
import 'package:biyi_app/services/local_db/init_data_if_need.dart';
import 'package:biyi_app/services/local_db/modifiers/engines_modifier.dart';
import 'package:biyi_app/services/local_db/modifiers/ocr_engines_modifier.dart';
import 'package:biyi_app/services/local_db/modifiers/preferences_modifier.dart';
import 'package:biyi_app/services/local_db/modifiers/translation_targets_modifier.dart';
import 'package:biyi_app/utils/utils.dart';
import 'package:hive/hive.dart';
import 'package:path/path.dart' as path;
import 'package:uni_platform/uni_platform.dart';

export 'configuration.dart';
export 'modifiers/engines_modifier.dart';
export 'modifiers/ocr_engines_modifier.dart';
export 'modifiers/preferences_modifier.dart';
export 'modifiers/translation_targets_modifier.dart';

@Deprecated('Use Settings instead.')
class LocalDb {
  Configuration configuration = Configuration();

  EnginesModifier? _enginesModifier;
  OcrEnginesModifier? _ocrEnginesModifier;
  PreferencesModifier? _preferencesModifier;
  TranslationTargetsModifier? _translationTargetsModifier;

  @Deprecated('No longer used.')
  EnginesModifier get engines {
    return engine(null);
  }

  @Deprecated('No longer used.')
  EnginesModifier engine(String? id) {
    _enginesModifier ??= EnginesModifier();
    _enginesModifier?.setId(id);
    _enginesModifier?.setGroup(null);
    return _enginesModifier!;
  }

  @Deprecated('No longer used.')
  OcrEnginesModifier get ocrEngines {
    return ocrEngine(null);
  }

  @Deprecated('No longer used.')
  OcrEnginesModifier ocrEngine(String? id) {
    _ocrEnginesModifier ??= OcrEnginesModifier();
    _ocrEnginesModifier?.setId(id);
    _ocrEnginesModifier?.setGroup(null);
    return _ocrEnginesModifier!;
  }

  @Deprecated('No longer used.')
  EnginesModifier get proEngines {
    return proEngine(null);
  }

  @Deprecated('No longer used.')
  EnginesModifier proEngine(String? id) {
    _enginesModifier ??= EnginesModifier();
    _enginesModifier?.setId(id);
    _enginesModifier?.setGroup('pro');
    return _enginesModifier!;
  }

  @Deprecated('No longer used.')
  OcrEnginesModifier get proOcrEngines {
    return proOcrEngine(null);
  }

  @Deprecated('No longer used.')
  OcrEnginesModifier proOcrEngine(String? id) {
    _ocrEnginesModifier ??= OcrEnginesModifier();
    _ocrEnginesModifier?.setId(id);
    _ocrEnginesModifier?.setGroup('pro');
    return _ocrEnginesModifier!;
  }

  @Deprecated('No longer used.')
  EnginesModifier get privateEngines {
    return privateEngine(null);
  }

  @Deprecated('No longer used.')
  EnginesModifier privateEngine(String? id) {
    _enginesModifier ??= EnginesModifier();
    _enginesModifier?.setId(id);
    _enginesModifier?.setGroup('private');
    return _enginesModifier!;
  }

  @Deprecated('No longer used.')
  OcrEnginesModifier get privateOcrEngines {
    return privateOcrEngine(null);
  }

  @Deprecated('No longer used.')
  OcrEnginesModifier privateOcrEngine(String? id) {
    _ocrEnginesModifier ??= OcrEnginesModifier();
    _ocrEnginesModifier?.setId(id);
    _ocrEnginesModifier?.setGroup('private');
    return _ocrEnginesModifier!;
  }

  @Deprecated('No longer used.')
  PreferencesModifier get preferences {
    return preference(null);
  }

  @Deprecated('No longer used.')
  PreferencesModifier preference(String? key) {
    _preferencesModifier ??= PreferencesModifier();
    _preferencesModifier?.setKey(key);
    return _preferencesModifier!;
  }

  @Deprecated('No longer used.')
  TranslationTargetsModifier get translationTargets {
    return translationTarget(null);
  }

  @Deprecated('No longer used.')
  TranslationTargetsModifier translationTarget(String? id) {
    _translationTargetsModifier ??= TranslationTargetsModifier();
    _translationTargetsModifier?.setId(id);
    return _translationTargetsModifier!;
  }
}

@Deprecated('No longer used.')
final localDb = LocalDb();

Future<void> _safeOpenBox(Directory userDataDirectory, String name) async {
  bool isOpenFailed = false;

  try {
    await Hive.openBox(name);
  } on FileSystemException {
    isOpenFailed = true;
  }

  if (isOpenFailed) {
    File lockFile = File(path.join(userDataDirectory.path, '$name.lock'));

    if (lockFile.existsSync()) {
      lockFile.deleteSync();
    }
    try {
      await Hive.openBox(name);
    } on FileSystemException {
      // skip
    }
  }
}

@Deprecated('No longer used.')
Future<void> initLocalDb() async {
  Directory userDataDirectory = await getUserDataDirectory();

  await Hive.close();
  Hive.init(userDataDirectory.path);
  await _safeOpenBox(userDataDirectory, 'preferences');
  await _safeOpenBox(userDataDirectory, 'engines');
  await _safeOpenBox(userDataDirectory, 'ocr_engines');
  await _safeOpenBox(userDataDirectory, 'translation_targets');
  // await migrateOldDb();
  if (!UniPlatform.isWeb) {
    await initDataIfNeed();
  }
}
