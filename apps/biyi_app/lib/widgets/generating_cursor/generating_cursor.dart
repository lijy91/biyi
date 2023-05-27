import 'package:flutter/material.dart';

class GeneratingCursor extends StatefulWidget {
  @override
  State<GeneratingCursor> createState() => _GeneratingCursorState();
}

class _GeneratingCursorState extends State<GeneratingCursor>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2),
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Text(
            '|',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black.withOpacity(_animationController.value),
            ),
          );
        },
      ),
    );
  }
}
