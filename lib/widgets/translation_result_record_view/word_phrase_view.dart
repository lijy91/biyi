import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../includes.dart';

class WordPhraseView extends StatelessWidget {
  final WordPhrase wordPhrase;
  final ValueChanged<String> onTextTapped;

  const WordPhraseView(
    this.wordPhrase, {
    Key? key,
    required this.onTextTapped,
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
                TextSpan(
                  text: wordPhrase.text,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => this.onTextTapped(wordPhrase.text),
                ),
                TextSpan(text: ' '),
                TextSpan(
                  text: wordPhrase.translations.first,
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
