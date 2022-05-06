import '../../includes.dart';

class ProOcrEngine extends OcrEngine {
  OcrEngineConfig config;

  ProOcrEngine(
    this.config,
  ) : super(identifier: config.identifier, option: config.option);

  @override
  Future<RecognizeTextResponse> recognizeText(RecognizeTextRequest request) {
    throw UnimplementedError();
  }
}
