import 'package:flutter/material.dart';

import '../../includes.dart';

class OcrEngineIcon extends StatelessWidget {
  final OcrEngineConfig ocrEngineConfig;
  final double size;

  const OcrEngineIcon(
    this.ocrEngineConfig, {
    Key? key,
    this.size = 22,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size,
      height: this.size,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(ocrEngineConfig.icon),
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
