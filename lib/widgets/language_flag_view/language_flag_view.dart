import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../includes.dart';

class LanguageFlagView extends StatelessWidget {
  final String language;
  final double size;
  final Color? borderColor;

  const LanguageFlagView(
    this.language, {
    Key? key,
    this.size = 22,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.size,
      height: this.size,
      decoration: BoxDecoration(
        color: Color(0xffeeeeee),
        borderRadius: BorderRadius.all(
          Radius.circular(this.size / 2),
        ),
        border: Border.all(
          color: this.borderColor ?? Colors.black.withOpacity(0.1),
          width: 0.8,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(this.size / 2),
        ),
        child: SvgPicture.asset(
          getLanguageFlag(language),
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
