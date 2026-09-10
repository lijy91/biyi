/// The mini window's inner card.
///
/// The floating translator is a menu-bar popover: a tray with a card inside
/// it, which is a window shape rather than a control, so the app draws it. The
/// surfaces and the radius are the kit's.
library;

import 'package:flutter/widgets.dart';

import 'ui.dart' show ThemeDataBuildContextProps;

/// The inner card of the mini window (and of the extension popup).
///
/// `colorSurfaceMuted` is the card's own role — "one step off the paper: the
/// card, the panel, the toolbar" — and off is away from the paper in either
/// direction: down to `#f7f7fa` under Studio, up to white under Bright, whose
/// paper is the warm `#fbfaf7`. That is the flip, and taking the role rather
/// than a step spells it without naming a palette. `colorSurfaceRaised` is the
/// brightest rung and is white in five of the six families, which is a card
/// everywhere except the one place it matters.
class PopoverPanel extends StatelessWidget {
  const PopoverPanel({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final vars = context.vars;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: vars.colorSurfaceMuted,
        border: Border.all(
          color: vars.colorBorder,
          width: context.hairlineWidth,
        ),
        borderRadius: BorderRadius.circular(vars.radiusLarge),
      ),
      child: child,
    );
  }
}
