import 'package:flutter/widgets.dart';

import '../generated/theme_variables.dart';
import '../theme/theme.dart';
import 'form.dart';

/// Label, control, hint.
///
/// The wrapper draws no box of its own — the control it holds does that — so
/// it owns only the space between the three and the type of the two it prints
/// itself.
class FormField extends StatelessWidget {
  const FormField({
    super.key,
    this.label,
    this.hint,
    this.name,
    this.invalid = false,
    required this.child,
  });

  final String? label;
  final String? hint;

  /// Identifies the field to the `Form` above it. Given one, a message the
  /// form was handed for this name replaces the hint and marks the field
  /// invalid — which is the whole reason a form is a widget rather than a
  /// column.
  final String? name;

  /// Erroring, the label and the hint join the control on the danger ramp,
  /// which the wrapper is re-tinted to rather than given its own error
  /// colours.
  final bool invalid;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;
    final String? error = FormErrors.of(context, name);
    final bool invalid = this.invalid || error != null;
    final String? hint = error ?? this.hint;
    final Color ink = invalid
        ? vars.colorDanger[vars.controlColorPlainContent.normalShade!]!
        : vars.colorContentSubtle;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: vars.spacing15,
      children: [
        if (label != null)
          Text(label!, style: vars.labelSmall.copyWith(color: ink)),
        child,
        if (hint != null)
          Text(
            hint,
            style: vars.labelQuiet.copyWith(height: 1.6, color: ink),
          ),
      ],
    );
  }
}
