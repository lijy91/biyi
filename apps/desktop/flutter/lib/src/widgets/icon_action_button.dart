import 'package:flutter/widgets.dart';

import 'app_tooltip.dart' show AppTooltip;
import 'ui.dart' show IconButton, ThemeDataBuildContextProps, Toggle;

/// The design system's 24pt flat toolbar affordance, taking an [IconData]
/// instead of a widget, wearing a hover label, and adding the optional
/// rotation the mini translator's pin needs.
///
/// Everything visual — geometry, hover wash, held read, disabled dimming —
/// comes from the package, so this stays a convenience adapter rather than a
/// second implementation. Which of the package's two it adapts is [selected]'s
/// doing, and it is settled when the button is built rather than as it is
/// used: a glyph that never latches is an [IconButton], whose quiet chrome is
/// what a toolbar row reads as, and one that does is a [Toggle], which is
/// where the kit keeps the held state that `IconButton.active` used to carry.
class IconActionButton extends StatelessWidget {
  const IconActionButton({
    super.key,
    required this.icon,
    this.tooltip,
    required this.onPressed,
    this.selected,
    this.iconTurns = 0,
    this.iconSize = 14,
  });

  final IconData icon;
  final String? tooltip;
  final VoidCallback? onPressed;

  /// Null for a button with no held state at all — not `false`, which would
  /// say it has one and is currently off, and would draw a toggle's resting
  /// face instead of a toolbar glyph's.
  final bool? selected;

  /// The deck sizes the glyph per call site: 18 in the mini-window toolbar,
  /// 16 in the sidebar header.
  final double iconSize;

  /// Animated rotation of the glyph, in turns — the pin lies at -45° until
  /// pinned, matching the deck.
  final double iconTurns;

  @override
  Widget build(BuildContext context) {
    // The kit's icon slot is the glyph itself, so the turn is applied to the
    // button rather than to a widget handed in as its icon.
    final Widget glyph = Icon(icon, size: iconSize);
    final Widget button = AnimatedRotation(
      turns: iconTurns,
      duration: context.vars.motionDuration,
      child: selected == null
          ? IconButton(
              semanticsLabel: tooltip ?? '',
              iconSize: iconSize,
              onPressed: onPressed,
              icon: glyph,
            )
          : Toggle(
              semanticsLabel: tooltip ?? '',
              // Driven from outside: what the pin is pressed against is the
              // window's own always-on-top, not a bit the button keeps.
              pressed: selected,
              enabled: onPressed != null,
              onPressedChanged: onPressed == null ? null : (_) => onPressed!(),
              child: glyph,
            ),
    );

    if (tooltip == null) return button;
    return AppTooltip(message: tooltip!, child: button);
  }
}
