import 'package:biyi_advanced_features/biyi_advanced_features.dart';
import 'package:biyi_app/services/api_client.dart';
import 'package:biyi_app/states/settings.dart';
import 'package:translation_engine_baidu/translation_engine_baidu.dart';
import 'package:translation_engine_caiyun/translation_engine_caiyun.dart';
import 'package:translation_engine_deepl/translation_engine_deepl.dart';
import 'package:translation_engine_google/translation_engine_google.dart';
import 'package:translation_engine_iciba/translation_engine_iciba.dart';
import 'package:translation_engine_openai/translation_engine_openai.dart';
import 'package:translation_engine_tencent/translation_engine_tencent.dart';
import 'package:translation_engine_youdao/translation_engine_youdao.dart';
import 'package:uni_translate_client/uni_translate_client.dart';

const kSupportedEngineTypes = [
  kEngineTypeBaidu,
  kEngineTypeCaiyun,
  kEngineTypeDeepL,
  kEngineTypeGoogle,
  kEngineTypeIciba,
  kEngineTypeOpenAI,
  kEngineTypeTencent,
  kEngineTypeYoudao,
];

final Map<String, List<String>> kKnownSupportedEngineOptionKeys = {
  kEngineTypeBaidu: BaiduTranslationEngine.optionKeys,
  kEngineTypeCaiyun: CaiyunTranslationEngine.optionKeys,
  kEngineTypeDeepL: DeepLTranslationEngine.optionKeys,
  kEngineTypeGoogle: GoogleTranslationEngine.optionKeys,
  kEngineTypeIciba: IcibaTranslationEngine.optionKeys,
  kEngineTypeOpenAI: OpenAITranslationEngine.optionKeys,
  kEngineTypeTencent: TencentTranslationEngine.optionKeys,
  kEngineTypeYoudao: YoudaoTranslationEngine.optionKeys,
};

TranslationEngine? createTranslationEngine(
  TranslationEngineConfig engineConfig,
) {
  if (Settings.instance.proTranslationEngine(engineConfig.id).exists()) {
    return ProTranslationEngine(engineConfig, apiClient: apiClient);
  } else {
    switch (engineConfig.type) {
      case kEngineTypeBaidu:
        return BaiduTranslationEngine(
          identifier: engineConfig.id,
          option: engineConfig.option,
        );
      case kEngineTypeCaiyun:
        return CaiyunTranslationEngine(
          identifier: engineConfig.id,
          option: engineConfig.option,
        );
      case kEngineTypeDeepL:
        return DeepLTranslationEngine(
          identifier: engineConfig.id,
          option: engineConfig.option,
        );
      case kEngineTypeGoogle:
        return GoogleTranslationEngine(
          identifier: engineConfig.id,
          option: engineConfig.option,
        );
      case kEngineTypeIciba:
        return IcibaTranslationEngine(
          identifier: engineConfig.id,
          option: engineConfig.option,
        );
      case kEngineTypeOpenAI:
        return OpenAITranslationEngine(
          identifier: engineConfig.id,
          option: engineConfig.option,
        );
      case kEngineTypeTencent:
        return TencentTranslationEngine(
          identifier: engineConfig.id,
          option: engineConfig.option,
        );
      case kEngineTypeYoudao:
        return YoudaoTranslationEngine(
          identifier: engineConfig.id,
          option: engineConfig.option,
        );
      default:
        break;
    }
  }
  return null;
}

class AutoloadTranslateClientAdapter extends UniTranslateClientAdapter {
  final Map<String, TranslationEngine> _translationEngineMap = {};

  @override
  TranslationEngine get first {
    throw UnimplementedError();
  }

  @override
  TranslationEngine use(String identifier) {
    String id = identifier;
    TranslationEngineConfig? engineConfig =
        Settings.instance.privateTranslationEngine(id).get() ??
            Settings.instance.proTranslationEngine(id).get();

    TranslationEngine? translationEngine;
    if (_translationEngineMap.containsKey(engineConfig?.id)) {
      translationEngine = _translationEngineMap[engineConfig?.id];
    }

    if (translationEngine == null) {
      translationEngine = createTranslationEngine(engineConfig!);

      if (translationEngine != null) {
        _translationEngineMap.update(
          engineConfig.id,
          (_) => translationEngine!,
          ifAbsent: () => translationEngine!,
        );
      }
    }

    return translationEngine!;
  }

  void renew(String identifier) {
    _translationEngineMap.remove(identifier);
  }
}

UniTranslateClient translateClient = UniTranslateClient(
  AutoloadTranslateClientAdapter(),
);
