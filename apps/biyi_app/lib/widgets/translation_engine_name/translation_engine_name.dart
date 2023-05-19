import 'package:flutter/material.dart';

import '../../includes.dart';

class TranslationEngineName extends StatelessWidget {
  final TranslationEngineConfig translationEngineConfig;

  const TranslationEngineName(
    this.translationEngineConfig, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: translationEngineConfig.typeName,
        children: [
          TextSpan(
            text: ' (${translationEngineConfig.identifier})',
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
