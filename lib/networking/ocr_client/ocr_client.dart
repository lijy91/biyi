export 'package:uni_ocr/uni_ocr.dart';

import '../../includes.dart';

final kDefaultBuiltInOcrEngine = BuiltInOcrEngine(
  OcrEngineConfig(
    identifier: 'cb838bdd-5dbd-4939-b7cb-a054b1ee1769',
    type: kOcrEngineTypeBuiltIn,
    name: kOcrEngineTypeBuiltIn,
    option: {},
  ),
);

bool kDefaultBuiltInOcrEngineIsSupportedOnCurrentPlatform = false;

const kSupportedOcrEngineTypes = [
  kOcrEngineTypeYoudao,
];

OcrEngine? createOcrEngine(
  OcrEngineConfig ocrEngineConfig,
) {
  OcrEngine? ocrEngine;

  switch (ocrEngineConfig.type) {
    case kOcrEngineTypeYoudao:
      ocrEngine = YoudaoOcrEngine(ocrEngineConfig);
      break;
  }

  return ocrEngine;
}

class AutoloadOcrClientAdapter extends UniOcrClientAdapter {
  final Map<String, OcrEngine> _ocrEngineMap = {};

  @override
  OcrEngine get first {
    OcrEngineConfig engineConfig = sharedLocalDb.ocrEngines.list().first;
    return use(engineConfig.identifier);
  }

  @override
  OcrEngine use(String identifier) {
    OcrEngineConfig? engineConfig = sharedLocalDb.ocrEngine(identifier).get();

    OcrEngine? ocrEngine;
    if (_ocrEngineMap.containsKey(engineConfig?.identifier)) {
      ocrEngine = _ocrEngineMap[engineConfig?.identifier];
    }

    if (ocrEngine == null) {
      ocrEngine = createOcrEngine(engineConfig!);
      if (ocrEngine != null) {
        _ocrEngineMap.update(
          engineConfig.identifier,
          (_) => ocrEngine!,
          ifAbsent: () => ocrEngine!,
        );
      }
    }

    return ocrEngine!;
  }

  void renew(String identifier) {
    _ocrEngineMap.remove(identifier);
  }
}

UniOcrClient sharedOcrClient = UniOcrClient(AutoloadOcrClientAdapter());
