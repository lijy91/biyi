import 'package:flutter/material.dart';

import '../../includes.dart';

class WordTranslationView extends StatefulWidget {
  final TextTranslation wordTranslation;

  const WordTranslationView(
    this.wordTranslation, {
    Key? key,
  }) : super(key: key);

  @override
  _WordTranslationViewState createState() => _WordTranslationViewState();
}

class _WordTranslationViewState extends State<WordTranslationView> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        _isHovered = true;
        setState(() {});
      },
      onExit: (event) {
        _isHovered = false;
        setState(() {});
      },
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: 40,
        ),
        padding: EdgeInsets.only(
          top: 7,
          bottom: 7,
        ),
        alignment: Alignment.centerLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SelectableText.rich(
              TextSpan(
                children: [
                  TextSpan(text: widget.wordTranslation.text),
                ],
              ),
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                    height: 1.4,
                  ),
            ),
            Container(
              margin: EdgeInsets.only(top: 2, left: 4),
              padding: EdgeInsets.only(left: 2, right: 2),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xff80838a).withOpacity(0.6),
                ),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text(
                '常见释义',
                style: TextStyle(
                  color: Color(0xff80838a),
                  fontSize: 10,
                ),
              ),
            ),
            if ((widget.wordTranslation.audioUrl ?? '').isNotEmpty &&
                _isHovered)
              Container(
                margin: EdgeInsets.only(left: 10),
                child: SoundPlayButton(
                  audioUrl: widget.wordTranslation.audioUrl!,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
