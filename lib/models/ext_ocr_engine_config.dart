import '../includes.dart';

extension ExtOcrEngineConfig on OcrEngineConfig {
  String get icon {
    return R.image('ocr_engine_icons/${this.type}.png');
  }

  String get typeName {
    String key = 'ocr_engine.${this.type}';
    if (key.tr() == key) {
      return this.name;
    }
    return key.tr();
  }
}
