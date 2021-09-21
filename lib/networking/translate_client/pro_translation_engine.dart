import 'package:uni_translate_client/uni_translate_client.dart';

import '../../includes.dart';

class ProTranslationEngine extends TranslationEngine {
  ProTranslationEngine(TranslationEngineConfig config) : super(config);

  @override
  Future<DetectLanguageResponse> detectLanguage(DetectLanguageRequest request) {
    return proAccount.engine(identifier).detectLanguage(request);
  }

  @override
  Future<LookUpResponse> lookUp(LookUpRequest request) {
    return proAccount.engine(identifier).lookUp(request);
  }

  @override
  Future<TranslateResponse> translate(TranslateRequest request) {
    return proAccount.engine(identifier).translate(request);
  }
}
