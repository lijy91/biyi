export 'package:uni_ocr/uni_ocr.dart';

import 'package:uni_ocr/uni_ocr.dart';

import '../../includes.dart';
import 'pro_ocr_engine.dart';

const kSupportedOcrEngineTypes = [
  kOcrEngineTypeYoudao,
];

OcrEngine createOcrEngine(
  OcrEngineConfig ocrEngineConfig,
) {
  OcrEngine ocrEngine;
  if (sharedLocalDb.proOcrEngine(ocrEngineConfig.identifier).exists()) {
    ocrEngine = ProOcrEngine(ocrEngineConfig);
  } else {
    switch (ocrEngineConfig.type) {
      case kOcrEngineTypeYoudao:
        ocrEngine = YoudaoOcrEngine(ocrEngineConfig);
        break;
    }
  }
  return ocrEngine;
}

class AutoloadOcrClientAdapter extends UniOcrClientAdapter {
  Map<String, OcrEngine> _ocrEngineMap = {};

  @override
  OcrEngine get first {
    OcrEngineConfig engineConfig = sharedLocalDb.ocrEngines.list().first;
    return use(engineConfig.identifier);
  }

  @override
  OcrEngine use(String identifier) {
    OcrEngineConfig engineConfig = sharedLocalDb.ocrEngine(identifier).get();

    OcrEngine ocrEngine;
    if (_ocrEngineMap.containsKey(engineConfig.identifier)) {
      ocrEngine = _ocrEngineMap[engineConfig.identifier];
    }

    if (ocrEngine == null) {
      ocrEngine = createOcrEngine(engineConfig);
      if (ocrEngine != null) {
        _ocrEngineMap.update(
          engineConfig.identifier,
          (_) => ocrEngine,
          ifAbsent: () => ocrEngine,
        );
      }
    }

    return ocrEngine;
  }
}

UniOcrClient sharedOcrClient = UniOcrClient(AutoloadOcrClientAdapter());
