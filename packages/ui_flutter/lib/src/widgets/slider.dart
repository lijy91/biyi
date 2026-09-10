import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../foundation/font_face.dart';
import '../foundation/widget_size.dart';
import '../foundation/widget_tint.dart';
import '../generated/theme_variables.dart';
import '../theme/theme.dart';
import 'focus_ring.dart';

/// The tint a [Slider]'s filled run resolves against.
enum SliderTint with WidgetTint {
  primary,
  neutral,
  info,
  success,
  warning,
  danger,
}

/// A value picked along a range.
///
/// A range is the same widget: pass more than one value and it draws a thumb
/// per value. There is no second widget, because everything but the number of
/// thumbs is identical.
///
/// It owns the parts that make one usable rather than merely draggable: the
/// arrow keys and their large step, Home and End, the press on the track that
/// jumps the nearest thumb, and — for a range — which thumb the pointer
/// actually grabbed when the two are on top of each other.
class Slider extends StatefulWidget {
  const Slider({
    super.key,
    required this.values,
    this.onChanged,
    this.onChangeEnd,
    this.min = 0,
    this.max = 100,
    this.step = 1,
    this.largeStep = 10,
    this.size = WidgetSize.medium,
    this.tint = SliderTint.primary,
    this.valueLabel,
    this.semanticsLabel,
  });

  /// One entry per thumb, in order, and never empty — a slider with no value
  /// is a groove. It is not asserted in the constructor: `length` is not
  /// something a `const` assert may read, and every story here is const.
  final List<double> values;

  final ValueChanged<List<double>>? onChanged;

  /// Fired once the drag or the key press settles — what a caller commits on.
  final ValueChanged<List<double>>? onChangeEnd;

  final double min;

  final double max;

  /// What one arrow key, and one notch of the pointer, moves.
  final double step;

  /// What Page Up and Page Down move.
  final double largeStep;

  final WidgetSize size;

  final SliderTint tint;

  /// Printed at the trailing edge. A slider whose value the reader has to be
  /// able to say — a font size, a threshold — needs it; one they only have to
  /// feel — a volume — does not.
  final String? valueLabel;

  final String? semanticsLabel;

  @override
  State<Slider> createState() => _SliderState();
}

class _SliderState extends State<Slider> {
  /// Which thumb the pointer took hold of. A range whose thumbs sit on the
  /// same value is the case this exists for: without it every drag would move
  /// whichever one the list happens to start with.
  int _active = 0;

  bool get _enabled => widget.onChanged != null;

  double get _span => widget.max - widget.min;

  double _fraction(double value) {
    if (_span <= 0) return 0;
    return ((value - widget.min) / _span).clamp(0.0, 1.0);
  }

  /// Snapped to the step, held inside the range, and kept in order: a range's
  /// thumbs cannot pass each other, which is the least surprising of the three
  /// behaviours a range can have.
  double _clamp(int index, double value) {
    final double snapped = widget.step <= 0
        ? value
        : widget.min +
              ((value - widget.min) / widget.step).round() * widget.step;
    final double low = index == 0 ? widget.min : widget.values[index - 1];
    final double high = index == widget.values.length - 1
        ? widget.max
        : widget.values[index + 1];
    return snapped.clamp(low, high);
  }

  void _set(int index, double value, {bool commit = false}) {
    if (!_enabled) return;
    final List<double> next = [...widget.values];
    next[index] = _clamp(index, value);
    if (next[index] == widget.values[index] && !commit) return;
    widget.onChanged!(next);
    if (commit) widget.onChangeEnd?.call(next);
  }

  int _nearest(double value) {
    int best = 0;
    double distance = double.infinity;
    for (int index = 0; index < widget.values.length; index += 1) {
      final double delta = (widget.values[index] - value).abs();
      if (delta < distance) {
        distance = delta;
        best = index;
      }
    }
    return best;
  }

  double _valueAt(double dx, double width) {
    if (width <= 0) return widget.min;
    return widget.min + (dx / width).clamp(0.0, 1.0) * _span;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;

    final double track = switch (widget.size.namedSize) {
      NamedSize.large => vars.sliderLargeTrack,
      NamedSize.medium => vars.sliderMediumTrack,
      _ => vars.sliderSmallTrack,
    };
    final double thumb = switch (widget.size.namedSize) {
      NamedSize.large => vars.sliderLargeThumb,
      NamedSize.medium => vars.sliderMediumThumb,
      _ => vars.sliderSmallThumb,
    };
    // The row's height comes off the control profile, so a slider in a form
    // sits on the same rhythm as the fields around it.
    final double height = switch (widget.size.namedSize) {
      NamedSize.large => vars.controlLargeSize,
      NamedSize.small => vars.controlSmallSize,
      _ => vars.controlMediumSize,
    };
    final ColorSwatch<int> ramp = switch (widget.tint) {
      SliderTint.primary => vars.colorPrimary,
      SliderTint.neutral => vars.colorNeutral,
      SliderTint.info => vars.colorInfo,
      SliderTint.success => vars.colorSuccess,
      SliderTint.warning => vars.colorWarning,
      SliderTint.danger => vars.colorDanger,
    };

    // Disabled flattens to the groove, like every other control: no lift, no
    // accent, one dead look.
    final Color fill = _enabled
        ? ramp[600]!
        : vars.controlColorNormalContent.disabledColor!;

    final double start = _fraction(
      widget.values.length > 1 ? widget.values.first : widget.min,
    );
    final double end = _fraction(widget.values.last);

    final Widget control = LayoutBuilder(
      builder: (context, constraints) {
        final double width = constraints.maxWidth;

        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: (details) {
            if (!_enabled) return;
            final double value = _valueAt(details.localPosition.dx, width);
            _active = _nearest(value);
            _set(_active, value, commit: true);
          },
          onHorizontalDragStart: (details) {
            if (!_enabled) return;
            _active = _nearest(_valueAt(details.localPosition.dx, width));
          },
          onHorizontalDragUpdate: (details) {
            if (!_enabled) return;
            _set(_active, _valueAt(details.localPosition.dx, width));
          },
          onHorizontalDragEnd: (_) {
            if (_enabled) widget.onChangeEnd?.call(widget.values);
          },
          child: SizedBox(
            height: height,
            child: Stack(
              // The thumb's centre sits on the control's edge at either end,
              // so half of it hangs outside the track's box.
              clipBehavior: Clip.none,
              children: [
                Positioned.fill(
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(track / 2),
                      child: SizedBox(
                        height: track,
                        width: double.infinity,
                        child: ColoredBox(
                          color: vars.colorSurfaceSunken,
                          child: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                start: width * start,
                              ),
                              child: SizedBox(
                                // The filled run, flat rather than the
                                // progress gradient: a gradient reads as
                                // travel, and a slider is not going anywhere
                                // on its own.
                                width: width * (end - start),
                                child: ColoredBox(color: fill),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                for (int index = 0; index < widget.values.length; index += 1)
                  Positioned(
                    left: width * _fraction(widget.values[index]) - thumb / 2,
                    top: (height - thumb) / 2,
                    child: _Thumb(
                      dimension: thumb,
                      enabled: _enabled,
                      accent: ramp[600]!,
                      onStep: (delta) {
                        _set(index, widget.values[index] + delta, commit: true);
                      },
                      onExtreme: (toMax) {
                        _set(
                          index,
                          toMax ? widget.max : widget.min,
                          commit: true,
                        );
                      },
                      step: widget.step,
                      largeStep: widget.largeStep,
                      semanticsLabel: widget.semanticsLabel,
                      semanticsValue: widget.values[index].toString(),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );

    if (widget.valueLabel == null) return control;

    return Row(
      spacing: vars.spacing3,
      children: [
        Expanded(child: control),
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: vars.spacing10),
          child: Text(
            widget.valueLabel!,
            textAlign: TextAlign.end,
            // A reading rather than a label: the mono face, so the row does
            // not reflow as the digits change under the pointer.
            style: vars.labelQuiet
                .copyWith(
                  fontSize: vars.labelSmall.fontSize,
                  height: 1,
                  color: vars.colorContentMuted,
                )
                .inFace(vars.fontCode),
          ),
        ),
      ],
    );
  }
}

/// The raised control that sits on the groove.
///
/// Paper, a hairline edge and the small lift a `filled` button carries, so it
/// reads as sitting on the track rather than in it. It takes the accent only
/// on its edge under the pointer; the focus ring is the system's own.
class _Thumb extends StatefulWidget {
  const _Thumb({
    required this.dimension,
    required this.enabled,
    required this.accent,
    required this.onStep,
    required this.onExtreme,
    required this.step,
    required this.largeStep,
    this.semanticsLabel,
    this.semanticsValue,
  });

  final double dimension;
  final bool enabled;
  final Color accent;
  final ValueChanged<double> onStep;
  final ValueChanged<bool> onExtreme;
  final double step;
  final double largeStep;
  final String? semanticsLabel;
  final String? semanticsValue;

  @override
  State<_Thumb> createState() => _ThumbState();
}

class _ThumbState extends State<_Thumb> {
  bool _hovered = false;
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;
    final bool lit = widget.enabled && (_hovered || _focused);

    Widget thumb = AnimatedContainer(
      duration: vars.motionDuration,
      curve: vars.motionEasing,
      width: widget.dimension,
      height: widget.dimension,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.enabled
            ? vars.colorSurface
            : vars.controlColorNormalSurface.disabledColor!,
        border: Border.all(
          color: lit
              ? widget.accent
              : widget.enabled
              ? vars.colorBorderStrong
              : vars.colorBorder,
          width: context.hairlineWidth,
        ),
        boxShadow: widget.enabled ? vars.shadowXs : null,
      ),
    );

    thumb = FocusRing(
      visible: _focused,
      color: vars.colorPrimary[vars.focusRingShade]!.withValues(
        alpha: vars.focusRingAlpha,
      ),
      borderRadius: BorderRadius.circular(vars.radiusFull),
      width: vars.focusWidth,
      offset: vars.focusOffset,
      child: thumb,
    );

    return Semantics(
      slider: true,
      enabled: widget.enabled,
      label: widget.semanticsLabel,
      value: widget.semanticsValue,
      child: FocusableActionDetector(
        enabled: widget.enabled,
        mouseCursor: widget.enabled
            ? SystemMouseCursors.click
            : SystemMouseCursors.forbidden,
        onShowHoverHighlight: (value) {
          if (value != _hovered) setState(() => _hovered = value);
        },
        onShowFocusHighlight: (value) {
          if (value != _focused) setState(() => _focused = value);
        },
        actions: <Type, Action<Intent>>{
          _StepIntent: CallbackAction<_StepIntent>(
            onInvoke: (intent) {
              widget.onStep(intent.delta);
              return null;
            },
          ),
          _ExtremeIntent: CallbackAction<_ExtremeIntent>(
            onInvoke: (intent) {
              widget.onExtreme(intent.toMax);
              return null;
            },
          ),
        },
        shortcuts: <ShortcutActivator, Intent>{
          SingleActivator(LogicalKeyboardKey.arrowRight): _StepIntent(
            widget.step,
          ),
          SingleActivator(LogicalKeyboardKey.arrowUp): _StepIntent(widget.step),
          SingleActivator(LogicalKeyboardKey.arrowLeft): _StepIntent(
            -widget.step,
          ),
          SingleActivator(LogicalKeyboardKey.arrowDown): _StepIntent(
            -widget.step,
          ),
          SingleActivator(LogicalKeyboardKey.pageUp): _StepIntent(
            widget.largeStep,
          ),
          SingleActivator(LogicalKeyboardKey.pageDown): _StepIntent(
            -widget.largeStep,
          ),
          const SingleActivator(LogicalKeyboardKey.home): const _ExtremeIntent(
            false,
          ),
          const SingleActivator(LogicalKeyboardKey.end): const _ExtremeIntent(
            true,
          ),
        },
        child: thumb,
      ),
    );
  }
}

class _StepIntent extends Intent {
  const _StepIntent(this.delta);

  final double delta;
}

class _ExtremeIntent extends Intent {
  const _ExtremeIntent(this.toMax);

  final bool toMax;
}
