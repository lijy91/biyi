import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../includes.dart';

const kWordImageSize = 74.0;

class WordImageView extends StatelessWidget {
  final WordImage wordImage;
  final VoidCallback? onPressed;

  const WordImageView(
    this.wordImage, {
    Key? key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 6),
      width: kWordImageSize,
      height: kWordImageSize,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(2),
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Hero(
          tag: wordImage.url,
          child: CustomImage(
            wordImage.url,
            width: kWordImageSize,
            height: kWordImageSize,
            fit: BoxFit.cover,
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
