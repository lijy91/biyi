import 'package:biyi_app/includes.dart';

class ProOcrEngine extends OcrEngine {
  ProOcrEngine(
    this.config,
  ) : super(identifier: config.identifier, option: config.option);

  OcrEngineConfig config;

  @override
  Future<RecognizeTextResponse> recognizeText(RecognizeTextRequest request) {
    return apiClient.ocrEngine(identifier).recognizeText(request);
  }
}
