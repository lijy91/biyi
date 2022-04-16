import 'package:flutter/material.dart';

import '../../includes.dart';

class WordSentenceView extends StatelessWidget {
  final WordSentence wordSentence;

  const WordSentenceView(
    this.wordSentence, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 6),
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
                TextSpan(text: '\n'),
                TextSpan(
                  text: wordSentence.translations.first,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        fontSize: 13,
                      ),
                ),
              ],
            ),
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  height: 1.4,
                ),
          ),
        ],
      ),
    );
  }
}
