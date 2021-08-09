import 'package:flutter/material.dart';

class FadeInPageRoute<T> extends PageRouteBuilder<T> {
  FadeInPageRoute({
    @required WidgetBuilder builder,
    RouteSettings settings,
    bool opaque = false,
  }) : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return builder(context);
          },
          settings: settings,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          opaque: opaque,
        );
}
