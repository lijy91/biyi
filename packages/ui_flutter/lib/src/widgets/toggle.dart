import 'package:flutter/widgets.dart';

import '../foundation/widget_size.dart';
import '../foundation/widget_tint.dart';
import '../foundation/widget_variant.dart';
import '../generated/theme_variables.dart';
import '../painting/widget_property.dart';
import '../theme/theme.dart';
import 'pressable.dart';

/// The ramp a [Toggle]'s recipe resolves against.
enum ToggleTint with WidgetTint {
  primary,
  neutral,
  info,
  success,
  warning,
  danger,
}

/// The recipes a toggle can wear — the [Button]'s set, since it is a button
/// with one extra state.
enum ToggleVariant with WidgetVariant {
  recessed,
  normal,
  filled,
  tinted,
  outlined,
  plain,
}

/// The size profile a toggle is drawn to.
typedef _Profile = ({
  double size,
  double gap,
  double paddingInline,
  double radius,
  TextStyle face,
});

_Profile _profileOf(ThemeVariables vars, WidgetSize size) {
  return switch (size.namedSize) {
    NamedSize.small => (
      size: vars.controlSmallSize,
      gap: vars.controlSmallGap,
      paddingInline: vars.controlSmallPaddingInline,
      radius: vars.controlSmallRadius,
      face: vars.controlSmallContent,
    ),
    NamedSize.medium => (
      size: vars.controlMediumSize,
      gap: vars.controlMediumGap,
      paddingInline: vars.controlMediumPaddingInline,
      radius: vars.controlMediumRadius,
      face: vars.controlMediumContent,
    ),
    NamedSize.large => (
      size: vars.controlLargeSize,
      gap: vars.controlLargeGap,
      paddingInline: vars.controlLargePaddingInline,
      radius: vars.controlLargeRadius,
      face: vars.controlLargeContent,
    ),
    _ => (
      size: vars.controlTinySize,
      gap: vars.controlTinyGap,
      paddingInline: vars.controlTinyPaddingInline,
      radius: vars.controlTinyRadius,
      face: vars.controlTinyContent,
    ),
  };
}

/// The box a [Toggle] and a [ToggleGroup]'s members are both drawn as.
///
/// One drawing shared rather than two that resemble each other, the way
/// [MenuPanel] is shared by the three menus. The group needs its own corners
/// and its own edges, which is the only thing it passes in.
Widget _toggleBody(
  BuildContext context, {
  required Set<WidgetState> states,
  required ToggleVariant variant,
  required ToggleTint tint,
  required WidgetSize size,
  required bool pressed,
  required BorderRadius radius,

  /// A member of a run draws no edge of its own: the group paints one ring
  /// around the whole thing and one rule between each pair. Flutter cannot
  /// paint a rounded border with a side dropped — `BorderDirectional` asserts
  /// on a radius unless every side matches — so border-collapse has to be done
  /// by the container rather than by the members, which is also what stops two
  /// hairlines from stacking into one two-pixel seam.
  required bool ownEdge,
  required Widget child,
}) {
  final ThemeVariables vars = Theme.of(context).vars;
  final _Profile profile = _profileOf(vars, size);
  final Color seed = vars.controlColor.tinted<ColorSwatch<int>>(tint);
  final bool dead = states.contains(WidgetState.disabled);

  // Down: the system's own selection rule, applied. The tinted wash for the
  // colour, and the label a weight heavier — the weight is the half that
  // survives on a monochrome toolbar and for a reader who cannot tell the two
  // grades apart, which is why it is not decoration.
  //
  // The recipe stays tinted when the toggle is disabled, and only the weight
  // drops. Falling back to the variant would leave a disabled `plain` toggle
  // with no surface at all — `plain` is undrawn at rest — where the whole
  // system flattens a dead control to the groove.
  final ToggleVariant drawn = pressed ? ToggleVariant.tinted : variant;

  final Color surface = vars.controlColorSurface.varianted<Color>(
    drawn,
    states,
    seed,
  );
  final Color content = vars.controlColorContent.varianted<Color>(
    drawn,
    states,
    seed,
  );
  final Color border = vars.controlColorBorder.varianted<Color>(
    drawn,
    states,
    seed,
  );

  // A toggle whose whole label is one glyph is square at the control height,
  // the way an `IconButton` is — the padding goes, because a glyph has no side
  // bearings to pay for. That is what lets a latching glyph sit in a toolbar
  // beside the buttons that do not latch without being the one cell of a
  // different width.
  final bool glyphOnly = child is Icon;

  return AnimatedContainer(
    duration: vars.motionDuration,
    curve: vars.motionEasing,
    height: profile.size,
    width: glyphOnly ? profile.size : null,
    padding: glyphOnly
        ? EdgeInsets.zero
        : EdgeInsets.symmetric(horizontal: profile.paddingInline),
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: surface,
      borderRadius: radius,
      border: ownEdge ? Border.all(color: border, width: vars.spacingPx) : null,
    ),
    child: DefaultTextStyle.merge(
      style: profile.face.copyWith(
        color: content,
        fontWeight: pressed && !dead
            ? vars.labelStrong.fontWeight
            : profile.face.fontWeight,
      ),
      child: IconTheme(
        data: IconTheme.of(context).copyWith(
          color: content,
          // A glyph label takes the type's size, so a toolbar of these lines
          // up with the buttons beside it rather than with whatever the icon
          // set ships at.
          size: profile.face.fontSize,
        ),
        child: child,
      ),
    ),
  );
}

/// A button that stays down.
///
/// The distinction it draws against its neighbours is worth stating, because
/// three widgets here are one press away from each other. A [Switch] commits
/// immediately and reads as a setting. A [SegmentedControl] is a choice
/// *between* its segments and always has one. This is neither: a single
/// property that is on or off — bold, wrap, show whitespace — in a row where
/// none of them may be on.
class Toggle extends StatefulWidget {
  const Toggle({
    super.key,
    required this.child,
    this.pressed,
    this.initiallyPressed = false,
    this.onPressedChanged,
    this.size = WidgetSize.tiny,
    this.variant = ToggleVariant.plain,
    // Neutral for the reason `IconButton` is: a toolbar of these is chrome,
    // and a row of accented glyphs reads as a row of actions.
    this.tint = ToggleTint.neutral,
    this.semanticsLabel,
    this.enabled = true,
  });

  final Widget child;

  /// Drive it from outside. Left null the widget holds its own state.
  final bool? pressed;

  final bool initiallyPressed;

  final ValueChanged<bool>? onPressedChanged;

  final WidgetSize size;

  final ToggleVariant variant;

  final ToggleTint tint;

  /// The accessible name, for a toggle whose label is a glyph — which is most
  /// of them, since these live in toolbars.
  final String? semanticsLabel;

  final bool enabled;

  @override
  State<Toggle> createState() => _ToggleState();
}

class _ToggleState extends State<Toggle> {
  late bool _pressed = widget.initiallyPressed;

  bool get _isPressed => widget.pressed ?? _pressed;

  void _toggle() {
    final bool next = !_isPressed;
    if (widget.pressed == null) setState(() => _pressed = next);
    widget.onPressedChanged?.call(next);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;
    final BorderRadius radius = BorderRadius.circular(
      _profileOf(vars, widget.size).radius,
    );

    return Pressable(
      onPressed: widget.enabled ? _toggle : null,
      enabled: widget.enabled,
      selected: _isPressed,
      semanticsLabel: widget.semanticsLabel,
      borderRadius: radius,
      builder: (context, states) => _toggleBody(
        context,
        states: states,
        variant: widget.variant,
        tint: widget.tint,
        size: widget.size,
        pressed: _isPressed,
        radius: radius,
        ownEdge: true,
        child: widget.child,
      ),
    );
  }
}

/// One member of a [ToggleGroup].
@immutable
class ToggleItem<T> {
  const ToggleItem({
    required this.value,
    required this.label,
    this.semanticsLabel,
    this.enabled = true,
  });

  final T value;

  final Widget label;

  /// The accessible name, where the label is a glyph.
  final String? semanticsLabel;

  final bool enabled;
}

/// Several toggles that belong together, joined into one control.
///
/// Joined rather than merely adjacent: the corners are rounded at the ends of
/// the run only and the shared edges collapse to one, which is what says the
/// group is one thing with several states rather than three buttons that
/// happen to touch.
///
/// [multiple] is where it parts from [SegmentedControl]: several on at once,
/// or none. A group that must always have exactly one is that widget, and
/// drawing it with this one would let the reader clear a choice that cannot be
/// cleared.
class ToggleGroup<T> extends StatelessWidget {
  const ToggleGroup({
    super.key,
    required this.items,
    required this.value,
    this.onChanged,
    this.multiple = true,
    this.size = WidgetSize.small,
    this.variant = ToggleVariant.recessed,
    this.tint = ToggleTint.primary,
    this.enabled = true,
  });

  final List<ToggleItem<T>> items;

  final List<T> value;

  final ValueChanged<List<T>>? onChanged;

  /// When false only one member can be down, and pressing another moves the
  /// selection rather than adding to it.
  final bool multiple;

  final WidgetSize size;

  final ToggleVariant variant;

  final ToggleTint tint;

  final bool enabled;

  void _press(T pressed) {
    if (onChanged == null) return;
    final bool on = value.contains(pressed);
    if (!multiple) {
      onChanged!(on ? <T>[] : <T>[pressed]);
      return;
    }
    onChanged!(
      on
          ? (value.where((T one) => one != pressed).toList())
          : (<T>[...value, pressed]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;
    final BorderRadius radius = BorderRadius.circular(
      _profileOf(vars, size).radius,
    );
    final Color seed = vars.controlColor.tinted<ColorSwatch<int>>(tint);
    // The run's own edge, read at rest: one ring for the whole group rather
    // than one per member, so the corners land only at the two ends and the
    // rule between a pair is a single hairline.
    final Color edge = vars.controlColorBorder.varianted<Color>(
      variant,
      enabled
          ? const <WidgetState>{}
          : const <WidgetState>{
              WidgetState.disabled,
            },
      seed,
    );

    final List<Widget> members = <Widget>[];
    for (int index = 0; index < items.length; index++) {
      if (index > 0) {
        members.add(
          SizedBox(
            width: vars.spacingPx,
            child: ColoredBox(color: edge),
          ),
        );
      }
      members.add(_member(context, index, radius));
    }

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: radius),
      // The ring rides in the foreground so the members' fills cannot paint
      // over it, exactly as a `Badge`'s edge does.
      foregroundDecoration: BoxDecoration(
        border: Border.all(color: edge, width: vars.spacingPx),
        borderRadius: radius,
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: members),
    );
  }

  Widget _member(BuildContext context, int index, BorderRadius radius) {
    final ToggleItem<T> item = items[index];
    final bool down = value.contains(item.value);
    final bool live = enabled && item.enabled;

    return Pressable(
      onPressed: live && onChanged != null ? () => _press(item.value) : null,
      enabled: live,
      selected: down,
      semanticsLabel: item.semanticsLabel,
      // The ring is the group's, so a member's focus follows the run's corner
      // and the clip trims it back to a square in the middle of the row.
      borderRadius: radius,
      builder: (context, states) => _toggleBody(
        context,
        states: states,
        variant: variant,
        tint: tint,
        size: size,
        pressed: down,
        radius: BorderRadius.zero,
        ownEdge: false,
        child: item.label,
      ),
    );
  }
}
