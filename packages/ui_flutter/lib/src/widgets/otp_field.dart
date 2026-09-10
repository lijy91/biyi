import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../foundation/font_face.dart';
import '../foundation/widget_size.dart';
import '../generated/theme_variables.dart';
import '../theme/theme.dart';
import 'field_box.dart';
import 'text_field.dart';

/// The one-time code a reader is copying out of a message.
///
/// It is drawn as a run of cells but it is one field underneath, and that is
/// deliberate: a paste of the whole code fills every cell at once, the
/// platform's own SMS autofill has somewhere to put the code, and the caret
/// only ever has one place to be. A run of separate inputs gets all three
/// wrong and has to reinvent the moves between them.
///
/// Each cell is the text controls' box at one character wide, so a code sits
/// on the same rhythm as the fields around it.
class OtpField extends StatefulWidget {
  const OtpField({
    super.key,
    required this.length,
    required this.value,
    this.onChanged,
    this.onCompleted,
    this.groupAfter,
    this.mask = false,
    this.size = WidgetSize.medium,
    this.state = TextFieldState.normal,
    this.tint = TextFieldTint.primary,
    this.focusNode,
    this.autofocus = false,
  }) : assert(length > 0);

  final int length;

  final String value;

  final ValueChanged<String>? onChanged;

  /// Fired the moment the last cell fills — what a form submits on.
  final ValueChanged<String>? onCompleted;

  /// Breaks the run where a printed code breaks: `3` on a six-digit code makes
  /// it two groups of three, which is how it is read aloud.
  final int? groupAfter;

  /// For a code that is a secret rather than a one-time token — a PIN.
  final bool mask;

  final WidgetSize size;

  final TextFieldState state;

  final TextFieldTint tint;

  final FocusNode? focusNode;

  final bool autofocus;

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.value,
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
  void didUpdateWidget(OtpField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.removeListener(_handleFocus);
      _focus.addListener(_handleFocus);
    }
    if (widget.value != _controller.text) {
      _controller.value = TextEditingValue(
        text: widget.value,
        selection: TextSelection.collapsed(offset: widget.value.length),
      );
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

  void _handleChanged(String next) {
    widget.onChanged?.call(next);
    if (next.length == widget.length) widget.onCompleted?.call(next);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;
    final FieldMetrics metrics = FieldMetrics.of(vars, widget.size);
    final bool invalid = widget.state == TextFieldState.error;
    final ColorSwatch<int> ramp = switch (tintForState(
      widget.state,
      widget.tint,
    )) {
      TextFieldTint.primary => vars.colorPrimary,
      TextFieldTint.neutral => vars.colorNeutral,
      TextFieldTint.info => vars.colorInfo,
      TextFieldTint.success => vars.colorSuccess,
      TextFieldTint.warning => vars.colorWarning,
      TextFieldTint.danger => vars.colorDanger,
    };

    final int caret = widget.value.length.clamp(0, widget.length - 1);

    final List<Widget> cells = [];
    for (int index = 0; index < widget.length; index += 1) {
      final bool filled = index < widget.value.length;
      final bool here = _focused && _enabled && index == caret;

      // The break between two groups of digits is a step of air rather than a
      // rule, which is what a printed code does.
      if (widget.groupAfter != null &&
          index > 0 &&
          index % widget.groupAfter! == 0) {
        cells.add(SizedBox(width: vars.spacing3 - vars.spacing2));
      }

      cells.add(
        AnimatedContainer(
          duration: vars.motionDuration,
          curve: vars.motionEasing,
          width: metrics.height,
          height: metrics.height,
          alignment: Alignment.center,
          decoration: fieldBoxDecoration(
            context,
            ramp: ramp,
            // A filled cell lifts to the paper and keeps it, so the run says
            // how far through the code the reader is without the caret having
            // to be the only thing that does.
            focused: here || (filled && !invalid),
            invalid: invalid,
            enabled: _enabled,
          ).copyWith(boxShadow: here ? null : const <BoxShadow>[]),
          child: Text(
            !filled
                ? ''
                : widget.mask
                ? '•'
                : widget.value[index],
            // The mono face: a code is digits being compared, and a 1
            // narrower than a 7 makes the run look mis-typed.
            style: metrics.face
                .copyWith(
                  fontWeight: vars.bodySmall.fontWeight,
                  height: 1,
                  color: invalid ? ramp[800]! : vars.colorContent,
                )
                .inFace(vars.fontCode),
          ),
        ),
      );
    }

    return Stack(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          spacing: vars.spacing2,
          children: cells,
        ),
        // One field under the run, drawn in nothing: it holds the value, takes
        // the paste and the platform's own code autofill, and is what the tap
        // focuses. The cells above are a picture of it.
        Positioned.fill(
          child: TextField(
            controller: _controller,
            focusNode: _focus,
            autofocus: widget.autofocus,
            enabled: _enabled,
            size: widget.size,
            decoration: const BoxDecoration(),
            padding: EdgeInsets.zero,
            maxLength: widget.length,
            keyboardType: TextInputType.number,
            autofillHints: const [AutofillHints.oneTimeCode],
            cursorColor: const Color(0x00000000),
            style: const TextStyle(color: Color(0x00000000)),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(widget.length),
            ],
            onChanged: _handleChanged,
          ),
        ),
      ],
    );
  }
}
