import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class GappedColumn extends Flex {
  GappedColumn({
    super.key,
    super.mainAxisAlignment,
    super.mainAxisSize,
    super.crossAxisAlignment,
    super.textDirection,
    super.verticalDirection,
    super.textBaseline,
    required double gap,
    List<Widget> children = const <Widget>[],
  }) : super(
         direction: Axis.vertical,
         children: children.expand((widget) => [widget, Gap(gap)]).toList()
           ..removeLast(),
       );
}
