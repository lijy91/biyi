import 'package:biyi_app/utils/r.dart';
import 'package:flutter/material.dart'
    show Brightness, Colors, Theme, ThemeData;
import 'package:flutter/widgets.dart';

class OcrEngineIcon extends StatelessWidget {
  const OcrEngineIcon(
    this.type, {
    super.key,
    this.size = 22,
  });

  final String type;
  final double size;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    bool invertColors = false;
    if (type == 'built_in' && themeData.brightness == Brightness.dark) {
      invertColors = true;
    }
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(R.image('ocr_engine_icons/$type.png')),
          fit: BoxFit.cover,
          invertColors: invertColors,
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
