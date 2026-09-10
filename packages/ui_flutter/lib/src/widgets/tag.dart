import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/widgets.dart';

import '../foundation/widget_size.dart';
import '../foundation/widget_tint.dart';
import '../foundation/widget_variant.dart';
import '../generated/theme_variables.dart';
import '../painting/widget_property.dart';
import '../theme/theme.dart';
import 'pressable.dart';

/// The ramp a [Tag]'s recipe resolves against.
enum TagTint with WidgetTint {
  primary,
  neutral,
  info,
  success,
  warning,
  danger,
}

/// The recipes a tag can wear — the [Badge]'s set, since it is the badge's
/// capsule.
enum TagVariant with WidgetVariant {
  filled,
  tinted,
  outlined,
  plain,

  /// The tag that sits on a grey card: paper fill, quiet ink.
  raised,
}

/// A [Badge] you can act on.
///
/// The two are one drawing and two widgets rather than one widget with an
/// `interactive` flag, because the difference is not cosmetic: a badge reads
/// its recipes at rest and deliberately stays out of the state machine, since
/// a label that moves under the pointer reads as something you can press. A
/// tag *is* something you can press, and taking the machine is the whole
/// reason it exists.
///
/// The dismiss button is its own control rather than a second job for the
/// label: a chip that removes itself when tapped has no way to be selected,
/// and one that does both from the same target removes things by accident.
///
/// The capsule's pads and type mirror `badge.dart` — the same box at the same
/// three densities. React shares them in one stylesheet; here they are written
/// twice, and the parity reference test is what holds the two together.
class Tag extends StatelessWidget {
  const Tag({
    super.key,
    required this.label,
    this.icon,
    this.size = WidgetSize.medium,
    this.variant = TagVariant.tinted,
    this.tint = TagTint.primary,
    this.selected,
    this.onSelectedChanged,
    this.onRemove,
    this.removeSemanticsLabel = 'Remove',
    this.enabled = true,
  });

  final Widget label;

  /// A glyph before the label — a status dot, an author's mark.
  final IconData? icon;

  final WidgetSize size;

  final TagVariant variant;

  final TagTint tint;

  /// Latched. Passing it at all is what makes the label pressable, and a
  /// selected tag is drawn with the `tinted` recipe and the tint's edge
  /// whatever [variant] says — a filter that is on has to read as on from
  /// across the row, not as one grade of the same chip.
  final bool? selected;

  final ValueChanged<bool>? onSelectedChanged;

  /// Draws the dismiss button, and is what it does.
  final VoidCallback? onRemove;

  final String removeSemanticsLabel;

  final bool enabled;

  bool get _pressable => selected != null;

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;
    final BorderRadius radius = BorderRadius.circular(vars.radiusTiny);
    final TagVariant drawn = _pressable && selected!
        ? TagVariant.tinted
        : variant;

    final EdgeInsets pads = switch (size.namedSize) {
      NamedSize.small => EdgeInsets.symmetric(
        horizontal: vars.spacing15,
        vertical: vars.spacing05,
      ),
      NamedSize.large => EdgeInsets.symmetric(
        horizontal: vars.spacing2,
        vertical: vars.spacing1,
      ),
      _ => EdgeInsets.symmetric(
        horizontal: vars.spacing2,
        vertical: vars.spacing05,
      ),
    };

    final TextStyle face = vars.labelStrong.copyWith(
      fontWeight: vars.labelMedium.fontWeight,
      height: 1.4,
      fontSize: size.namedSize == NamedSize.large
          ? vars.labelMedium.fontSize
          : vars.labelSmall.fontSize,
    );

    Widget capsule(Set<WidgetState> states) {
      final Color seed = vars.controlColor.tinted<ColorSwatch<int>>(tint);
      Color surface;
      Color content;
      Color border;

      if (drawn == TagVariant.raised) {
        surface = vars.colorSurface;
        content = vars.colorContentMuted;
        border = const Color(0x00000000);
      } else {
        surface = vars.controlColorSurface.varianted<Color>(
          drawn,
          states,
          seed,
        );
        content = vars.controlColorContent.varianted<Color>(
          drawn,
          states,
          seed,
        );
        border = vars.controlColorBorder.varianted<Color>(drawn, states, seed);
      }

      // Selected is drawn twice over: the tinted fill the variant swaps to,
      // and this edge. One alone is not enough — a tinted tag that was already
      // tinted would look untouched, and an edge alone is a pixel to spot in a
      // row of forty.
      if (_pressable && selected!) {
        border = vars.controlColorBorder.varianted<Color>(
          TagVariant.outlined,
          const <WidgetState>{},
          seed,
        );
      }

      return AnimatedContainer(
        duration: vars.motionDuration,
        curve: vars.motionEasing,
        padding: pads + EdgeInsets.all(vars.spacingPx),
        decoration: BoxDecoration(color: surface, borderRadius: radius),
        // The edge rides in the foreground so it paints over the fill rather
        // than insetting the content box, and the padding carries its width —
        // exactly what `badge.dart` does, and for the same reason: every
        // variant has an edge, transparent or not, so `outlined` does not gain
        // a pixel per side.
        foregroundDecoration: BoxDecoration(
          border: Border.all(color: border, width: vars.spacingPx),
          borderRadius: radius,
        ),
        child: DefaultTextStyle.merge(
          style: face.copyWith(color: content),
          child: IconTheme(
            data: IconTheme.of(context).copyWith(color: content),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                if (icon != null) ...<Widget>[
                  Icon(icon, size: vars.spacing3),
                  SizedBox(width: vars.spacing1),
                ],
                label,
                if (onRemove != null) ...<Widget>[
                  SizedBox(width: vars.spacing1),
                  _Dismiss(
                    semanticsLabel: removeSemanticsLabel,
                    onPressed: enabled ? onRemove : null,
                  ),
                ],
              ],
            ),
          ),
        ),
      );
    }

    // Only a pressable tag opts into the state machine. One that merely
    // carries a dismiss button is still a label, and a wash that answered the
    // pointer anywhere on the capsule would promise a target that is not
    // there.
    if (!_pressable) {
      // At rest, whatever `enabled` says. A tag that cannot be pressed is a
      // label, and a label has no disabled state — only the dismiss button
      // inside it does, and it flattens itself. React draws it the same way,
      // because a static tag never joins the state machine at all.
      return capsule(const <WidgetState>{});
    }

    return Pressable(
      enabled: enabled,
      selected: selected,
      borderRadius: radius,
      onPressed: onSelectedChanged == null
          ? null
          : () => onSelectedChanged!(!selected!),
      builder: (context, states) => capsule(states),
    );
  }
}

/// The ✕ inside a tag.
///
/// Faint at rest and only resolved under the pointer: an ✕ at full strength on
/// every chip turns a list of tags into a list of buttons. Its wash is an alpha
/// of the capsule's own ink rather than a recipe, because it sits on five
/// different variants across twelve themes and the only colour guaranteed to
/// read on all of them is the one the label is already set in.
class _Dismiss extends StatelessWidget {
  const _Dismiss({required this.semanticsLabel, required this.onPressed});

  final String semanticsLabel;
  final VoidCallback? onPressed;

  /// The pointer wash on the dismiss target, over whatever the capsule is.
  static const double _hoverAlpha = 0.16;
  static const double _restOpacity = 0.6;
  static const double _deadOpacity = 0.4;

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;
    final Color ink = IconTheme.of(context).color ?? vars.colorContent;

    return Pressable(
      onPressed: onPressed,
      enabled: onPressed != null,
      semanticsLabel: semanticsLabel,
      borderRadius: BorderRadius.circular(vars.radiusFull),
      builder: (context, states) {
        final bool hovered = states.contains(WidgetState.hovered);
        final bool dead = states.contains(WidgetState.disabled);

        return AnimatedContainer(
          duration: vars.motionDuration,
          curve: vars.motionEasing,
          decoration: BoxDecoration(
            color: hovered
                ? ink.withValues(alpha: _hoverAlpha)
                : const Color(0x00000000),
            borderRadius: BorderRadius.circular(vars.radiusFull),
          ),
          child: Opacity(
            opacity: dead ? _deadOpacity : (hovered ? 1 : _restOpacity),
            child: Icon(
              FluentIcons.dismiss_12_regular,
              size: vars.spacing3,
              color: ink,
            ),
          ),
        );
      },
    );
  }
}
