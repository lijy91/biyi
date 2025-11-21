import 'package:biyi_app/services/api_client.dart' show OcrEngineConfig;

export 'package:biyi_app/services/api_client.dart' show OcrEngineConfig;

extension ExtOcrEngineConfig on OcrEngineConfig {
  String get typeName {
    String key = 'ocr_engine.$type';
    if (key == key) {
      return type;
    }
    return key;
  }
}
