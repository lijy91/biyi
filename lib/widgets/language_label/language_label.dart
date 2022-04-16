import 'package:flutter/material.dart';

import '../../includes.dart';

class LanguageLabel extends StatelessWidget {
  final String language;
  final double flagSize;
  final Color? flagBorderColor;
  final TextStyle? style;

  const LanguageLabel(
    this.language, {
    Key? key,
    this.flagSize = 22,
    this.flagBorderColor,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        LanguageFlagView(
          language,
          size: this.flagSize,
          borderColor: this.flagBorderColor,
        ),
        SizedBox(width: 5),
        DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyText2!,
          child: Text(
            getLanguageName(language),
            style: style,
          ),
        ),
      ],
    );
  }
}
