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
    throw UnimplementedError();
  }

  @override
  Future<LookUpResponse> lookUp(LookUpRequest request) {
    throw UnimplementedError();
  }

  @override
  Future<TranslateResponse> translate(TranslateRequest request) {
    throw UnimplementedError();
  }
}
