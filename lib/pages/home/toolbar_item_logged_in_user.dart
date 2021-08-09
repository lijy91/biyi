import 'package:flutter/material.dart';

import '../../includes.dart';

class ToolbarItemLoggedInUser extends StatefulWidget {
  @override
  _ToolbarItemLoggedInUserState createState() =>
      _ToolbarItemLoggedInUserState();
}

class _ToolbarItemLoggedInUserState extends State<ToolbarItemLoggedInUser> {
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      padding: EdgeInsets.only(left: 6, right: 6),
      borderRadius: BorderRadius.zero,
      child: Row(
        children: [
          SizedBox(
            width: 18,
            height: 18,
            child: CircleAvatar(),
          ),
          SizedBox(width: 4),
          Text(
            '匿名用户',
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => SettingsPage(),
            fullscreenDialog: true,
          ),
        );
      },
    );
  }
}
