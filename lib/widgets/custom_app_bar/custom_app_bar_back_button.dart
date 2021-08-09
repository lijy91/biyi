import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../includes.dart';

class CustomAppBarBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CustomAppBarBackButton({
    Key key,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.only(right: 12),
      child: Icon(
        IcoMoonIcons.chevron_left,
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
