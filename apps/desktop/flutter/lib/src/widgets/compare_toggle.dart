import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/widgets.dart';

import '../theme/product_tokens.dart' show ProductPalette, ProductTypography;
import 'ui.dart'
    show
        IconButton,
        IconButtonTint,
        IconButtonVariant,
        ThemeDataBuildContextProps;

/// 对比 — the switch that opens a result block's compare list, in both windows.
///
/// A glyph with a count on its corner rather than 对比 N 个服务 spelled out:
/// the row it sits on is a line of chrome under the translation, and a pill of
/// words there competes with the text it belongs to. The number is the part
/// worth a glance — how many other services there are to read — so it is what
/// the badge carries, and the sentence stays as the button's accessible name.
class CompareToggle extends StatelessWidget {
  const CompareToggle({
    super.key,
    required this.expanded,
    required this.count,
    required this.label,
    required this.onPressed,
  });

  /// Whether the list is open — the button holds the accent wash while it is.
  final bool expanded;

  /// What the badge prints: the rows the list would open.
  final int count;

  /// 对比 N 个服务 / 收起对比 — the name the button no longer prints, kept as
  /// what a screen reader announces.
  final String label;

  final VoidCallback onPressed;

  /// A chip small enough to sit on a 24px button without burying its glyph.
  static const double _kBadgeSize = 14;

  @override
  Widget build(BuildContext context) {
    final vars = context.vars;

    return Stack(
      // The badge hangs off the button's corner; nothing around it clips.
      clipBehavior: Clip.none,
      children: [
        IconButton(
          semanticsLabel: label,
          tint: IconButtonTint.primary,
          variant:
              expanded ? IconButtonVariant.tinted : IconButtonVariant.plain,
          icon: const Icon(FluentIcons.column_double_compare_20_regular),
          onPressed: onPressed,
        ),
        if (count > 0)
          PositionedDirectional(
            top: -3,
            end: -3,
            // The count annotates the button; the button is what you press.
            child: IgnorePointer(
              child: Container(
                height: _kBadgeSize,
                constraints: const BoxConstraints(minWidth: _kBadgeSize),
                padding: const EdgeInsets.symmetric(horizontal: 3),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: vars.accent,
                  borderRadius: BorderRadius.circular(vars.radiusFull),
                ),
                child: Text(
                  '$count',
                  style: vars.sansStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    height: 1,
                    color: vars.colorOnAccent,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
