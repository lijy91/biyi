import 'package:flutter/widgets.dart';

typedef HoverableWidgetBuilder =
    Widget Function(
      BuildContext context,
      bool hovered,
    );

/// A widget that changes its appearance when hovered.
class HoverableArea extends StatefulWidget {
  const HoverableArea({
    super.key,
    required this.builder,
  });

  final HoverableWidgetBuilder builder;

  @override
  State<HoverableArea> createState() => _HoverableAreaState();
}

class _HoverableAreaState extends State<HoverableArea> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        _isHovered = true;
        setState(() {});
      },
      onExit: (event) {
        _isHovered = false;
        setState(() {});
      },
      onHover: (event) {
        if (!_isHovered) {
          _isHovered = true;
          setState(() {});
        }
      },
      child: widget.builder(context, _isHovered),
    );
  }
}
