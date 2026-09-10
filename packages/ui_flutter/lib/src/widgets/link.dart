import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/widgets.dart';

import '../foundation/widget_tint.dart';
import '../foundation/widget_variant.dart';
import '../generated/theme_variables.dart';
import '../painting/widget_property.dart';
import '../theme/theme.dart';
import 'pressable.dart';

/// The ramp a [Link]'s accent grade resolves against.
enum LinkTint with WidgetTint {
  primary,
  neutral,
  info,
  success,
  warning,
  danger,
}

/// The one recipe a link wears.
///
/// `varianted` is keyed by an enum that mixes in [WidgetVariant], and a link
/// has no variant axis to expose — so this exists to name the cell rather than
/// to offer a choice.
enum _LinkVariant with WidgetVariant { plain }

/// When the rule under the label is drawn.
///
/// [hover] is the default, because a page of prose with a rule under every
/// link reads as struck through. [always] is for a link that has to be
/// findable without a pointer — a list of references, a footer. [none] is for
/// one whose surroundings already say it is a link: a breadcrumb, a row that
/// is entirely a target.
enum LinkUnderline { hover, always, none }

/// Text that goes somewhere.
///
/// It is the one interactive thing in this package that is genuinely inline,
/// which is why it exists beside `Button(variant: plain)` rather than inside
/// it: a button keeps its box at every variant, and a box is exactly what a
/// link in a sentence must not have. So this takes the shared state machine
/// for its colour — `plain`'s content grade, a step darker on hover — and none
/// of its geometry.
///
/// Inside a paragraph it goes in a [WidgetSpan]; on its own it is a widget
/// like any other.
class Link extends StatelessWidget {
  const Link({
    super.key,
    required this.label,
    this.onPressed,
    this.tint = LinkTint.primary,
    this.underline = LinkUnderline.hover,
    this.external = false,
    this.enabled = true,
    this.style,
  });

  /// The run of text. It is a string rather than a widget because a link's
  /// whole job is to set one run in the accent grade, and a subtree would have
  /// its own colours.
  final String label;

  final VoidCallback? onPressed;

  final LinkTint tint;

  final LinkUnderline underline;

  /// Goes somewhere outside this window, and draws the arrow that says so
  /// before the reader commits.
  final bool external;

  final bool enabled;

  /// The face to set the run in. Left null it inherits, which is what a link
  /// in a paragraph wants: it should be the paragraph's type in a different
  /// colour, not a second face.
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;
    final Color seed = vars.controlColor.tinted<ColorSwatch<int>>(tint);

    return Pressable(
      onPressed: onPressed,
      enabled: enabled,
      // The ring hugs the text run, so it takes the tiny corner: a link inside
      // a paragraph has no padding to offset into.
      borderRadius: BorderRadius.circular(vars.radiusTiny),
      // A link is not a button, and an assistive technology that announced it
      // as one would promise something that happens here rather than
      // somewhere else.
      isButton: false,
      builder: (context, states) {
        final bool hovered = states.contains(WidgetState.hovered);
        // The `plain` recipe's content grade, and only its content: the wash
        // that recipe also carries would ragged the line it sits on, and the
        // grade change is what a link has always used to answer the pointer.
        final Color content = vars.controlColorContent.varianted<Color>(
          _LinkVariant.plain,
          states,
          seed,
        );

        final bool ruled = switch (underline) {
          LinkUnderline.always => true,
          LinkUnderline.hover => hovered,
          LinkUnderline.none => false,
        };

        final TextStyle run = (style ?? DefaultTextStyle.of(context).style)
            .copyWith(
              color: content,
              decoration: ruled
                  ? TextDecoration.underline
                  : TextDecoration.none,
              decorationColor: content,
              // One pixel at every size, clear of the descenders rather than
              // struck through them.
              decorationThickness: vars.spacingPx,
            );

        return Semantics(
          link: true,
          child: Text.rich(
            TextSpan(
              text: label,
              children: <InlineSpan>[
                if (external)
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: vars.spacing05,
                      ),
                      child: Icon(
                        FluentIcons.arrow_up_right_12_regular,
                        size: vars.spacing3,
                        color: content,
                      ),
                    ),
                  ),
              ],
            ),
            style: run,
          ),
        );
      },
    );
  }
}
