import 'package:flutter/material.dart';

import '../../includes.dart';

class OcrEngineName extends StatelessWidget {
  final OcrEngineConfig ocrEngineConfig;

  const OcrEngineName(
    this.ocrEngineConfig, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: ocrEngineConfig.typeName,
        children: [
          TextSpan(
            text: ' (${ocrEngineConfig.identifier})',
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
