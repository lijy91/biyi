import 'package:flutter/material.dart';

import '../../includes.dart';

class TranslationEngineIcon extends StatelessWidget {
  final TranslationEngineConfig translationEngineConfig;
  final double size;
  final Color color;
  final Border border;

  const TranslationEngineIcon(
    this.translationEngineConfig, {
    Key key,
    this.size = 22,
    this.color,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size,
      height: this.size,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(translationEngineConfig.icon),
          fit: BoxFit.cover,
          colorFilter:
              color != null ? ColorFilter.mode(color, BlendMode.color) : null,
        ),
        borderRadius: BorderRadius.all(Radius.circular(6)),
        border: border != null
            ? border
            : Border.all(
                color: Colors.black.withOpacity(0.2),
                width: 0.5,
              ),
      ),
    );
  }
}
