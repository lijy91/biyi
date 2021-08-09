import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../includes.dart';

class CustomAppBarCloseButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomAppBarCloseButton({
    Key key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.only(right: 12),
      child: Icon(
        IcoMoonIcons.x,
        color: Theme.of(context).appBarTheme.iconTheme.color,
        size: 26,
      ),
      onPressed: () {
        if (onPressed != null) {
          onPressed();
          return;
        }
        Navigator.maybePop(context);
      },
    );
  }
}
