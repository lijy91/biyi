import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:window_manager/window_manager.dart';

import '../../../includes.dart';

double get kVirtualWindowFrameMargin => (kIsLinux || kIsWindows) ? 20.0 : 0;

class VirtualWindowFrame extends StatefulWidget {
  final Widget child;

  const VirtualWindowFrame({Key key, this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _VirtualWindowFrameState();
}

class _VirtualWindowFrameState extends State<VirtualWindowFrame>
    with WindowListener {
  bool _focused = true;

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(kVirtualWindowFrameMargin),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Theme.of(context).dividerColor, width: 1),
            borderRadius: BorderRadius.circular(2),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: Offset(0.0, _focused ? 6.0 : 4),
                blurRadius: _focused ? 6 : 4,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: widget.child,
          ),
        ),
        Positioned(
          top: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
              left: kVirtualWindowFrameMargin,
              right: kVirtualWindowFrameMargin,
              top: kVirtualWindowFrameMargin,
            ),
            child: DragToMoveArea(
              child: Container(
                height: 34,
                // color: Colors.red.withOpacity(0.1),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void onWindowFocus() {
    setState(() {
      _focused = true;
    });
  }

  @override
  void onWindowBlur() {
    setState(() {
      _focused = false;
    });
  }
}
