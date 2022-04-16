import '../includes.dart';

extension ExtOcrEngineConfig on OcrEngineConfig {
  String get icon {
    return R.image('ocr_engine_icons/$type.png');
  }

  String get typeName {
    String key = 'ocr_engine.$type';
    if (key.tr() == key) {
      return name ?? type;
    }
    return key.tr();
  }
}
