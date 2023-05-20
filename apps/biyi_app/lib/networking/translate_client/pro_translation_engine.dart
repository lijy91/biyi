import 'package:biyi_app/includes.dart';

class ProTranslationEngine extends TranslationEngine {
  ProTranslationEngine(
    this.config,
  ) : super(identifier: config.identifier, option: config.option);

  TranslationEngineConfig config;

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
