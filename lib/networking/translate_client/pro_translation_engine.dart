import '../../includes.dart';

class ProTranslationEngine extends TranslationEngine {
  TranslationEngineConfig config;
  ProTranslationEngine(
    this.config,
  ) : super(identifier: config.identifier, option: config.option);

  @override
  List<String> get supportedScopes => config.supportedScopes;

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
