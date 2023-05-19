import 'package:flutter/material.dart';

import '../../includes.dart';

class TranslationEngineIcon extends StatelessWidget {
  final String type;
  final double size;
  final Color? color;
  final Border? border;

  const TranslationEngineIcon(
    this.type, {
    Key? key,
    this.size = 22,
    this.color,
    this.border,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(R.image('translation_engine_icons/$type.png')),
          fit: BoxFit.cover,
          colorFilter: color != null
              ? ColorFilter.mode(
                  color!,
                  BlendMode.color,
                )
              : null,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        border: border ??
            Border.all(
              color: Colors.black.withOpacity(0.2),
              width: 0.5,
            ),
      ),
    );
  }
}
