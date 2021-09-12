import 'package:uni_translate/uni_translate.dart';

import '../includes.dart';

extension ExtTranslationEngineConfig on TranslationEngineConfig {
  String get icon {
    return R.image('translation_engine_icons/${this.type}.png');
  }

  String get typeName {
    String key = 'engine.${this.type}';
    if (key.tr() == key) {
      return this.name;
    }
    return key.tr();
  }
}
