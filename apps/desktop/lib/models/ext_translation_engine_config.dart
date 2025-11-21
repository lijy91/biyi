import 'package:biyi_app/services/api_client.dart' show TranslationEngineConfig;

export 'package:biyi_app/services/api_client.dart' show TranslationEngineConfig;

extension ExtTranslationEngineConfig on TranslationEngineConfig {
  String get typeName {
    String key = 'engine.$type';
    if (key == key) {
      return type;
    }
    return key;
  }
}
