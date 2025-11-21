import 'package:flutter/widgets.dart';

extension GlobalKeyEx on GlobalKey {
  Offset get globalPosition {
    final RenderBox box = currentContext?.findRenderObject() as RenderBox;
    return box.localToGlobal(Offset.zero);
  }
}
