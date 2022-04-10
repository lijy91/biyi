import '../../includes.dart';

class ProOcrEngine extends OcrEngine {
  ProOcrEngine(OcrEngineConfig config) : super(config);

  @override
  Future<RecognizeTextResponse> recognizeText(RecognizeTextRequest request) {
    return proAccount.ocrEngine(identifier).recognizeText(request);
  }
}
