import 'package:flutter/material.dart';

import '../../includes.dart';

class TranslationEngineIcon extends StatelessWidget {
  final TranslationEngineConfig translationEngineConfig;
  final double size;

  const TranslationEngineIcon(
    this.translationEngineConfig, {
    Key key,
    this.size = 22,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size,
      height: this.size,
      decoration: BoxDecoration(
        image: kIsLinux
            ? null
            : DecorationImage(
                image: AssetImage(translationEngineConfig.icon),
                fit: BoxFit.cover,
              ),
        borderRadius: BorderRadius.all(Radius.circular(6)),
        border: Border.all(
          color: Colors.black.withOpacity(0.2),
          width: 0.5,
        ),
      ),
    );
  }
}
