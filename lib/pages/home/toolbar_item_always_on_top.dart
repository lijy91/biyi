import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import '../../includes.dart';

class ToolbarItemAlwaysOnTop extends StatefulWidget {
  @override
  _ToolbarItemAlwaysOnTopState createState() => _ToolbarItemAlwaysOnTopState();
}

class _ToolbarItemAlwaysOnTopState extends State<ToolbarItemAlwaysOnTop> {
  bool _isAlwaysOnTop = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    _isAlwaysOnTop = await windowManager.isAlwaysOnTop();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomButton(
        padding: EdgeInsets.zero,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
          transformAlignment: Alignment.center,
          transform: Matrix4.rotationZ(
            _isAlwaysOnTop ? math.pi / 6 : 0,
          ),
          child: Icon(
            _isAlwaysOnTop ? IcoMoonIcons.pin_fill : IcoMoonIcons.pin,
            size: 17,
            color: _isAlwaysOnTop
                ? Theme.of(context).primaryColor
                : Theme.of(context).iconTheme.color,
          ),
        ),
        onPressed: () {
          setState(() {
            _isAlwaysOnTop = !_isAlwaysOnTop;
          });
          windowManager.setAlwaysOnTop(_isAlwaysOnTop);
        },
      ),
    );
  }
}
