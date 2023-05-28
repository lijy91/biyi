import 'package:biyi_advanced_features/models/models.dart';
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
    throw UnsupportedError('detectLanguage');
  }

  @override
  Future<LookUpResponse> lookUp(LookUpRequest request) {
    throw UnsupportedError('lookUp');
  }

  @override
  Future<TranslateResponse> translate(TranslateRequest request) {
    throw UnsupportedError('translate');
  }
}
