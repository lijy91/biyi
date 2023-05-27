import 'package:biyi_app/models/translation_engine_config.dart';
import 'package:biyi_app/networking/api_client/api_client.dart';
import 'package:uni_translate_client/uni_translate_client.dart';

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
