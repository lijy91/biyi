import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../foundation/widget_size.dart';
import '../generated/theme_variables.dart';
import '../theme/theme.dart';
import 'field_box.dart';
import 'pressable.dart';
import 'text_field.dart';

/// A number, with the two things a plain text field never gets right: a
/// stepper you can hold down, and a value that stays a number.
///
/// The box is the [TextField]'s — field_box.dart draws it for both — so a form
/// mixing the two does not step. What is this widget's own is the stepper at
/// the trailing edge, and the parsing that keeps the value inside its bounds.
class NumberField extends StatefulWidget {
  const NumberField({
    super.key,
    required this.value,
    this.onChanged,
    this.min,
    this.max,
    this.step = 1,
    this.largeStep = 10,
    this.size = WidgetSize.medium,
    this.state = TextFieldState.normal,
    this.tint = TextFieldTint.primary,
    this.placeholder,
    this.unit,
    this.focusNode,
    this.autofocus = false,
  });

  /// The value, or null while the field is empty.
  final double? value;

  final ValueChanged<double?>? onChanged;

  final double? min;

  final double? max;

  /// What one press of the stepper, and one arrow key, moves.
  final double step;

  /// What Page Up and Page Down move.
  final double largeStep;

  final WidgetSize size;

  final TextFieldState state;

  final TextFieldTint tint;

  final String? placeholder;

  /// A trailing unit inside the box — `px`, `%`, `ms`. It is a hint rather
  /// than part of the value, so it never enters what a form submits.
  final String? unit;

  final FocusNode? focusNode;

  final bool autofocus;

  @override
  State<NumberField> createState() => _NumberFieldState();
}

class _NumberFieldState extends State<NumberField> {
  late final TextEditingController _controller = TextEditingController(
    text: _format(widget.value),
  );
  FocusNode? _ownedFocus;
  bool _focused = false;

  FocusNode get _focus => widget.focusNode ?? (_ownedFocus ??= FocusNode());

  bool get _enabled => widget.onChanged != null;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_handleFocus);
  }

  @override
  void didUpdateWidget(NumberField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.removeListener(_handleFocus);
      _focus.addListener(_handleFocus);
    }
    // Only when the caller moved it: rewriting the text on every rebuild would
    // fight the caret while the reader is typing.
    if (widget.value != oldWidget.value &&
        _parse(_controller.text) != widget.value) {
      _controller.text = _format(widget.value);
    }
  }

  @override
  void dispose() {
    _focus.removeListener(_handleFocus);
    _ownedFocus?.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _handleFocus() {
    if (_focus.hasFocus != _focused) setState(() => _focused = _focus.hasFocus);
  }

  static String _format(double? value) {
    if (value == null) return '';
    return value == value.roundToDouble()
        ? value.toStringAsFixed(0)
        : value.toString();
  }

  static double? _parse(String text) => double.tryParse(text.trim());

  double _clamp(double value) {
    double result = value;
    if (widget.min != null && result < widget.min!) result = widget.min!;
    if (widget.max != null && result > widget.max!) result = widget.max!;
    return result;
  }

  void _nudge(double delta) {
    if (!_enabled) return;
    final double base = widget.value ?? widget.min ?? 0;
    final double next = _clamp(base + delta);
    _controller.text = _format(next);
    widget.onChanged!(next);
  }

  void _commit(String text) {
    if (!_enabled) return;
    final double? parsed = _parse(text);
    widget.onChanged!(parsed == null ? null : _clamp(parsed));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;
    final FieldMetrics metrics = FieldMetrics.of(vars, widget.size);
    final bool invalid = widget.state == TextFieldState.error;
    final ColorSwatch<int> ramp = _ramp(vars);

    final bool canIncrease =
        _enabled &&
        (widget.max == null || (widget.value ?? widget.min ?? 0) < widget.max!);
    final bool canDecrease =
        _enabled &&
        (widget.min == null || (widget.value ?? widget.max ?? 0) > widget.min!);

    return Shortcuts(
      shortcuts: <ShortcutActivator, Intent>{
        const SingleActivator(LogicalKeyboardKey.arrowUp): _NudgeIntent(1),
        const SingleActivator(LogicalKeyboardKey.arrowDown): _NudgeIntent(-1),
        const SingleActivator(LogicalKeyboardKey.pageUp): _NudgeIntent(10),
        const SingleActivator(LogicalKeyboardKey.pageDown): _NudgeIntent(-10),
      },
      child: Actions(
        actions: <Type, Action<Intent>>{
          _NudgeIntent: CallbackAction<_NudgeIntent>(
            onInvoke: (intent) {
              _nudge(
                intent.notches.abs() == 10
                    ? widget.largeStep * intent.notches.sign
                    : widget.step * intent.notches,
              );
              return null;
            },
          ),
        },
        child: AnimatedContainer(
          duration: vars.motionDuration,
          curve: vars.motionEasing,
          height: metrics.height,
          decoration: fieldBoxDecoration(
            context,
            ramp: ramp,
            focused: _focused,
            invalid: invalid,
            enabled: _enabled,
          ),
          // The trailing step is the stepper's own inset: it is a control
          // rather than text, so it sits closer to the edge than a value.
          padding: EdgeInsetsDirectional.fromSTEB(
            vars.spacing3,
            0,
            vars.spacing1,
            0,
          ),
          child: Row(
            spacing: vars.spacing1,
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focus,
                  autofocus: widget.autofocus,
                  enabled: _enabled,
                  placeholder: widget.placeholder,
                  size: widget.size,
                  state: widget.state,
                  tint: widget.tint,
                  // The box is drawn by the container above; the field itself
                  // is only the inside of it.
                  decoration: const BoxDecoration(),
                  padding: EdgeInsets.zero,
                  keyboardType: const TextInputType.numberWithOptions(
                    signed: true,
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^-?[0-9]*\.?[0-9]*'),
                    ),
                  ],
                  onChanged: _commit,
                ),
              ),
              if (widget.unit != null)
                Text(
                  widget.unit!,
                  style: vars.labelQuiet.copyWith(
                    fontSize: vars.labelSmall.fontSize,
                    height: 1,
                    color: vars.colorContentFaint,
                  ),
                ),
              // Stacked rather than a minus and a plus on either side: the
              // field is read left to right, and a value with a control on
              // both sides of it reads as three things. The pair is one
              // AppKit stepper.
              _Stepper(
                height: metrics.height - vars.spacing1 * 2,
                onIncrease: canIncrease ? () => _nudge(widget.step) : null,
                onDecrease: canDecrease ? () => _nudge(-widget.step) : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  ColorSwatch<int> _ramp(ThemeVariables vars) {
    return switch (tintForState(widget.state, widget.tint)) {
      TextFieldTint.primary => vars.colorPrimary,
      TextFieldTint.neutral => vars.colorNeutral,
      TextFieldTint.info => vars.colorInfo,
      TextFieldTint.success => vars.colorSuccess,
      TextFieldTint.warning => vars.colorWarning,
      TextFieldTint.danger => vars.colorDanger,
    };
  }
}

class _NudgeIntent extends Intent {
  const _NudgeIntent(this.notches);

  final int notches;
}

/// Two half-height buttons in one column, hairlined off the value.
class _Stepper extends StatelessWidget {
  const _Stepper({
    required this.height,
    required this.onIncrease,
    required this.onDecrease,
  });

  /// What is left of the field's height once the stepper's own inset is taken
  /// off it. The two buttons split it: a fixed height per button would
  /// overflow the small profile, whose box is barely two glyphs tall.
  final double height;

  final VoidCallback? onIncrease;
  final VoidCallback? onDecrease;

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;

    return Container(
      height: height,
      margin: EdgeInsets.symmetric(vertical: vars.spacing1),
      padding: EdgeInsetsDirectional.only(start: vars.spacing1),
      decoration: BoxDecoration(
        border: BorderDirectional(
          start: BorderSide(
            color: vars.colorBorder,
            width: context.hairlineWidth,
          ),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: _StepButton(
              icon: FluentIcons.chevron_up_12_regular,
              onPressed: onIncrease,
              semanticsLabel: 'Increase',
            ),
          ),
          Expanded(
            child: _StepButton(
              icon: FluentIcons.chevron_down_12_regular,
              onPressed: onDecrease,
              semanticsLabel: 'Decrease',
            ),
          ),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({
    required this.icon,
    required this.onPressed,
    required this.semanticsLabel,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String semanticsLabel;

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;
    final BorderRadius radius = BorderRadius.circular(vars.radiusTiny);

    return Pressable(
      onPressed: onPressed,
      enabled: onPressed != null,
      borderRadius: radius,
      semanticsLabel: semanticsLabel,
      builder: (context, states) {
        final bool washed =
            onPressed != null && states.contains(WidgetState.hovered);

        return AnimatedContainer(
          duration: vars.motionDuration,
          curve: vars.motionEasing,
          width: vars.spacing4,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: washed ? vars.colorSurfaceSubtle : null,
            borderRadius: radius,
          ),
          child: Icon(
            icon,
            size: vars.captionSmall.fontSize,
            color: onPressed == null
                ? vars.controlColorNormalContent.disabledColor!
                : washed
                ? vars.colorContent
                : vars.colorContentSubtle,
          ),
        );
      },
    );
  }
}
