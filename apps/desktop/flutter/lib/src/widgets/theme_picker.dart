import 'package:flutter/widgets.dart';

import '../theme/app_theme.dart' show DesignThemeFamily, designThemeFor;
import '../theme/product_tokens.dart' show ProductPalette;
import 'app_tooltip.dart' show AppTooltip;
import 'ui.dart' show Pressable, ThemeDataBuildContextProps, ThemeVariables;

/// The palettes, as the colours they paint with.
///
/// A name does not tell you what Frost or Ember look like and the choice is
/// entirely about the colour, so each family shows two of its own: the ground
/// it lays paper on, and the hue it marks that paper with — Bright by its acid
/// green rather than by the ink it fills buttons with, which is the half of it
/// you actually notice. The swatches preview at the brightness the window is
/// in, and picking one repaints everything at once, so the row is its own
/// preview.
class ThemeFamilyPicker extends StatelessWidget {
  const ThemeFamilyPicker({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final DesignThemeFamily value;
  final ValueChanged<DesignThemeFamily> onChanged;

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = context.vars;
    final Brightness brightness = context.themeData.brightness;

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: vars.spacing15,
      children: [
        for (final family in DesignThemeFamily.values)
          _ThemeFamilySwatch(
            family: family,
            brightness: brightness,
            selected: family == value,
            onPressed: () => onChanged(family),
          ),
      ],
    );
  }
}

/// The swatch, its gap, and the ring around it — 26 across in total, which is
/// the height of the segmented control on the row below.
const double _kSwatchSize = 18;
const double _kRingGap = 2;
const double _kRingWidth = 2;

class _ThemeFamilySwatch extends StatelessWidget {
  const _ThemeFamilySwatch({
    required this.family,
    required this.brightness,
    required this.selected,
    required this.onPressed,
  });

  final DesignThemeFamily family;
  final Brightness brightness;
  final bool selected;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = context.vars;
    // The family's own tokens, not the ones in force — that is the point.
    final ThemeVariables theirs =
        designThemeFor(family.themeFor(brightness)).vars;

    return AppTooltip(
      message: family.label,
      child: Pressable(
        onPressed: onPressed,
        semanticsLabel: family.label,
        checked: selected,
        borderRadius: BorderRadius.circular(vars.radiusFull),
        builder: (context, states) {
          final bool hovered = states.contains(WidgetState.hovered);
          // The ring's room is always reserved, drawn in nothing until there is
          // something to say: a row that resizes as the selection moves along
          // it is a row that never sits still.
          return AnimatedContainer(
            duration: vars.motionDuration,
            curve: vars.motionEasing,
            padding: const EdgeInsets.all(_kRingGap),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: selected
                    ? vars.accent
                    : (hovered ? vars.colorBorderStrong : _kNoRing),
                width: _kRingWidth,
              ),
            ),
            child: SizedBox.square(
              dimension: _kSwatchSize,
              child: Container(
                // The edge goes over the halves rather than around them, so the
                // seam between the two runs to the rim instead of stopping at
                // an inset border's inside.
                foregroundDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theirs.colorBorderStrong,
                    width: context.hairlineWidth,
                  ),
                ),
                child: ClipOval(
                  child: Row(
                    // Stretched, so each half takes the swatch's full height:
                    // `Expanded` only decides the width, and a `ColoredBox`
                    // with nothing in it is nothing tall.
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // The ground, not `colorSurface`: every family in light
                      // lays white or near-white paper, and it is the ground
                      // under it that the family is named for — sage, sand,
                      // ice, lilac. Half and half rather than a dot on a
                      // field, because at 18 across a dot leaves too little of
                      // either colour to read.
                      Expanded(child: ColoredBox(color: theirs.colorCanvas)),
                      Expanded(child: ColoredBox(color: theirs.highlight)),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

/// A ring drawn in nothing, so the selected one can appear without moving its
/// neighbours.
const Color _kNoRing = Color(0x00000000);
