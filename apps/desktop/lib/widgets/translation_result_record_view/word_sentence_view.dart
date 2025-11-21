import 'dart:ui' as ui;

import 'package:flutter/material.dart' show SelectableText, TextTheme, Theme;
import 'package:flutter/widgets.dart';
import 'package:uni_translate_client/uni_translate_client.dart';

class WordSentenceView extends StatelessWidget {
  const WordSentenceView(
    this.wordSentence, {
    super.key,
  });

  final WordSentence wordSentence;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 6),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SelectableText.rich(
            TextSpan(
              children: [
                TextSpan(text: wordSentence.text),
                const TextSpan(text: '\n'),
                TextSpan(
                  text: wordSentence.translations.first,
                  style: textTheme.bodySmall!.copyWith(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            style: textTheme.bodyMedium!.copyWith(
              height: 1.4,
            ),
            selectionHeightStyle: ui.BoxHeightStyle.max,
          ),
        ],
      ),
    );
  }
}
