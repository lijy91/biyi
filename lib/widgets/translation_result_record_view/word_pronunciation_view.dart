import 'package:flutter/material.dart';

import '../../includes.dart';

class WordPronunciationView extends StatelessWidget {
  final WordPronunciation wordPronunciation;

  const WordPronunciationView(
    this.wordPronunciation, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SelectableText.rich(
            TextSpan(
              text: '',
              children: [
                if ((wordPronunciation.type ?? '').isNotEmpty)
                  TextSpan(
                    text: '${wordPronunciation.localType} ',
                    style: Theme.of(context).textTheme.bodyText2!.copyWith(
                          fontSize: 13,
                        ),
                  ),
                if ((wordPronunciation.phoneticSymbol ?? '').isNotEmpty)
                  TextSpan(
                    text: '[${wordPronunciation.phoneticSymbol}]',
                  )
              ],
            ),
            style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 13,
                ),
          ),
          if ((wordPronunciation.audioUrl ?? '').isNotEmpty)
            Container(
              margin: EdgeInsets.only(left: 10, top: 2),
              child: SoundPlayButton(
                audioUrl: wordPronunciation.audioUrl!,
              ),
            ),
        ],
      ),
    );
  }
}
