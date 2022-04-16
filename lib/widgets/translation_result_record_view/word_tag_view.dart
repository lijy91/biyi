import 'package:flutter/material.dart';

import '../../includes.dart';

class WordTagView extends StatelessWidget {
  final WordTag wordTag;

  const WordTagView(
    this.wordTag, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 4, right: 4, top: 2, bottom: 2),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).dividerColor),
        borderRadius: BorderRadius.circular(2),
      ),
      constraints: BoxConstraints(minHeight: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            wordTag.name,
            style: Theme.of(context).textTheme.caption!.copyWith(
                  fontSize: 13,
                ),
          ),
        ],
      ),
    );
  }
}
