import 'package:biyi_api_client/biyi_api_client.dart';
import 'package:uni_ocr_client/uni_ocr_client.dart';

class ProOcrEngine extends OcrEngine {
  ProOcrEngine(
    this.config, {
    required this.apiClient,
  }) : super(identifier: config.id, option: config.option);

  final OcrEngineConfig config;
  final ApiClient apiClient;

  @override
  Future<RecognizeTextResponse> recognizeText(RecognizeTextRequest request) {
    return apiClient.ocrEngine(identifier).recognizeText(request);
  }
}
