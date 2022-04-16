import 'package:uni_translate/uni_translate.dart';

import '../includes.dart';

extension ExtTranslationEngineConfig on TranslationEngineConfig {
  String get icon {
    return R.image('translation_engine_icons/$type.png');
  }

  String get typeName {
    String key = 'engine.$type';
    if (key.tr() == key) {
      return name ?? type;
    }
    return key.tr();
  }
}
