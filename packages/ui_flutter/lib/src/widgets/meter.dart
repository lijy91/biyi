import 'package:flutter/widgets.dart';

import '../foundation/font_face.dart';
import '../foundation/widget_size.dart';
import '../foundation/widget_tint.dart';
import '../generated/theme_variables.dart';
import '../theme/theme.dart';

/// The tint a [Meter]'s fill resolves against.
enum MeterTint with WidgetTint {
  primary,
  neutral,
  info,
  success,
  warning,
  danger,
}

/// A reading inside a known range — disk used of disk there, spend against a
/// budget, an API quota.
///
/// It is not a [Progress], and the difference is not how they look. Progress
/// reports on something running: it moves on its own, it can be indeterminate,
/// and it ends. A meter measures something that already has a value, so it
/// never animates and never has none — which is why it prints its number and
/// progress does not.
class Meter extends StatelessWidget {
  const Meter({
    super.key,
    required this.value,
    this.min = 0,
    this.max = 1,
    this.size = WidgetSize.medium,
    this.tint = MeterTint.primary,
    this.label,
    this.valueLabel,
    this.semanticsLabel,
  });

  /// The reading, between [min] and [max].
  final double value;

  final double min;

  final double max;

  final WidgetSize size;

  final MeterTint tint;

  /// Names the reading. It is the meter's accessible label as well.
  final Widget? label;

  /// What is printed beside the label. Omit it for a bare groove; the number
  /// is the meter's whole point, so most readings want one.
  final String? valueLabel;

  final String? semanticsLabel;

  double get _fraction {
    if (max <= min) return 0;
    return ((value - min) / (max - min)).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;

    final double thickness = switch (size.namedSize) {
      NamedSize.large => vars.spacing2,
      NamedSize.medium => vars.spacing15,
      _ => vars.spacing1,
    };
    final ColorSwatch<int> ramp = switch (tint) {
      MeterTint.primary => vars.colorPrimary,
      MeterTint.neutral => vars.colorNeutral,
      MeterTint.info => vars.colorInfo,
      MeterTint.success => vars.colorSuccess,
      MeterTint.warning => vars.colorWarning,
      MeterTint.danger => vars.colorDanger,
    };

    // The same cut a Progress bar is — the sunken groove, the soft square
    // corner, the hard-clipped fill. The fill has no transition on purpose: a
    // progress bar interpolates because the thing behind it is running; a
    // meter that eased into place would be animating a fact.
    final Widget groove = ClipRRect(
      borderRadius: BorderRadius.circular(thickness / 2),
      child: SizedBox(
        height: thickness,
        width: double.infinity,
        child: ColoredBox(
          color: vars.colorSurfaceSunken,
          child: LayoutBuilder(
            builder: (context, constraints) => Align(
              alignment: AlignmentDirectional.centerStart,
              child: SizedBox(
                width: constraints.maxWidth * _fraction,
                child: ColoredBox(color: ramp[600]!),
              ),
            ),
          ),
        ),
      ),
    );

    return Semantics(
      label: semanticsLabel,
      value: valueLabel,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        spacing: vars.spacing2,
        children: [
          if (label != null || valueLabel != null)
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                if (label != null)
                  Expanded(
                    child: DefaultTextStyle.merge(
                      style: vars.labelQuiet.copyWith(
                        fontSize: vars.labelSmall.fontSize,
                        fontWeight: vars.labelMedium.fontWeight,
                        height: 1,
                        color: vars.colorContent,
                      ),
                      child: label!,
                    ),
                  ),
                if (valueLabel != null)
                  Text(
                    valueLabel!,
                    // A reading rather than a label: the mono face, so a
                    // column of meters keeps its numbers on one edge. It is
                    // the one place a widget reaches a `base.*` primitive,
                    // which `meter.css` does too — `base.font.code` has no
                    // semantic token in front of it.
                    style: vars.labelQuiet
                        .copyWith(
                          fontSize: vars.labelSmall.fontSize,
                          height: 1,
                          color: vars.colorContentMuted,
                        )
                        .inFace(vars.fontCode),
                  ),
              ],
            ),
          groove,
        ],
      ),
    );
  }
}
