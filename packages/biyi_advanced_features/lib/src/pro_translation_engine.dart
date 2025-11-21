import 'package:biyi_api_client/biyi_api_client.dart';
import 'package:uni_translate_client/uni_translate_client.dart';

class ProTranslationEngine extends TranslationEngine {
  ProTranslationEngine(
    this.config, {
    required this.apiClient,
  }) : super(identifier: config.id, option: config.option);

  TranslationEngineConfig config;
  final ApiClient apiClient;

  @override
  List<TranslationEngineScope> get supportedScopes => config.supportedScopes;

  @override
  Future<DetectLanguageResponse> detectLanguage(DetectLanguageRequest request) {
    return apiClient.engine(identifier).detectLanguage(request);
  }

  @override
  Future<LookUpResponse> lookUp(LookUpRequest request) {
    return apiClient.engine(identifier).lookUp(request);
  }

  @override
  Future<TranslateResponse> translate(TranslateRequest request) {
    return apiClient.engine(identifier).translate(request);
  }
}
