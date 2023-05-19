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
    TextTheme textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        LanguageFlagView(
          language,
          size: flagSize,
          borderColor: flagBorderColor,
        ),
        const SizedBox(width: 5),
        DefaultTextStyle(
          style: textTheme.bodyMedium!,
          child: Text(
            getLanguageName(language),
            style: style,
          ),
        ),
      ],
    );
  }
}
