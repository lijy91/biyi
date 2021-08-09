import 'package:uni_translate_client/uni_translate_client.dart';

import '../../includes.dart';

class ProTranslationEngine extends TranslationEngine {
  ProTranslationEngine(TranslationEngineConfig config) : super(config);

  @override
  Future<DetectLanguageResponse> detectLanguage(DetectLanguageRequest request) {
    return sharedApiClient.engine(identifier).detectLanguage(request);
  }

  @override
  Future<LookUpResponse> lookUp(LookUpRequest request) {
    return sharedApiClient.engine(identifier).lookUp(request);
  }

  @override
  Future<TranslateResponse> translate(TranslateRequest request) {
    return sharedApiClient.engine(identifier).translate(request);
  }
}
