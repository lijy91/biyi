import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../generated/theme_variables.dart';
import '../theme/theme.dart';

/// The run of fields, and the one thing above them that knows about all of
/// them: [errors].
///
/// That is what it is for. A column of [FormField]s already lays out; what it
/// cannot do is take what the server said back — `{'email': 'Already taken'}`
/// — and put each message under the field it belongs to. [FormErrors.of] is
/// how a field asks, so a field inside a form needs only its name.
///
/// It also owns the rhythm between the fields, which is the other thing no
/// single field can decide.
class Form extends StatelessWidget {
  const Form({
    super.key,
    this.errors = const <String, String>{},
    required this.children,
  });

  /// Validation messages returned from outside — a server, a form action —
  /// keyed by the name a [FormField] carries.
  final Map<String, String> errors;

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;

    return FormErrors(
      errors: errors,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        spacing: vars.spacing4,
        children: children,
      ),
    );
  }
}

/// What a named field reads to find its own message.
class FormErrors extends InheritedWidget {
  const FormErrors({super.key, required this.errors, required super.child});

  final Map<String, String> errors;

  /// The message for [name], or null when the form has none for it.
  static String? of(BuildContext context, String? name) {
    if (name == null) return null;
    final FormErrors? form = context
        .dependOnInheritedWidgetOfExactType<FormErrors>();
    return form?.errors[name];
  }

  @override
  bool updateShouldNotify(FormErrors oldWidget) =>
      !mapEquals(oldWidget.errors, errors);
}

/// A run of fields that are one question between them — a date's three boxes,
/// an address, a set of radios.
///
/// The legend is the group's accessible name, which is the whole point: a
/// screen reader announces it before each field inside, so "Street" is heard
/// as "Billing address, Street". A heading in a [Text] above the fields looks
/// the same and says none of that.
///
/// It is not the way to head a *section* of unrelated fields — that is a
/// [SectionLabel], or a [PreferenceSection]. A fieldset claims the fields
/// inside it belong together.
class Fieldset extends StatelessWidget {
  const Fieldset({super.key, this.legend, required this.children});

  /// Names the group. It is the fieldset's accessible name as well.
  final String? legend;

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;

    final Widget group = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      spacing: vars.spacing3,
      children: [
        if (legend != null)
          // The section label's voice: it names a group rather than labelling
          // a control, so it takes the caption face and not the field label's.
          Text(
            legend!,
            style: vars.captionSmall.copyWith(
              fontWeight: vars.labelSmall.fontWeight,
              height: 1,
              color: vars.colorContentSubtle,
            ),
          ),
        ...children,
      ],
    );

    return legend == null
        ? group
        : Semantics(container: true, label: legend, child: group);
  }
}
