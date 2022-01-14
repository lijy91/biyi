import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        FluentIcons.chevron_left_20_regular,
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
