import 'package:flutter/material.dart';

import '../../includes.dart';

class OcrEngineIcon extends StatelessWidget {
  final String type;
  final double size;

  const OcrEngineIcon(
    this.type, {
    Key? key,
    this.size = 22,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(R.image('ocr_engine_icons/$type.png')),
          fit: BoxFit.cover,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(6)),
        border: Border.all(
          color: Colors.black.withOpacity(0.2),
          width: 0.5,
        ),
      ),
    );
  }
}
