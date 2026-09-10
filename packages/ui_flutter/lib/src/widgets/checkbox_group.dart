import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../theme/theme.dart';
import 'checkbox.dart';

/// Several checkboxes that are one answer, and the parent that turns them all
/// on or off.
///
/// The parent is where a group earns its place. A checkbox with `parent: true`
/// reads the group rather than a value of its own: it is checked when every
/// child is, *mixed* when only some are — the state a lone checkbox can never
/// arrive at by itself — and pressing it sets or clears the lot, restoring
/// what was checked before if it is pressed twice.
///
/// [allValues] is what tells the group which children exist; without it the
/// parent has nothing to count.
class CheckboxGroup extends StatefulWidget {
  const CheckboxGroup({
    super.key,
    required this.allValues,
    required this.value,
    this.onChanged,
    required this.children,
  });

  /// Every name a child in this group may carry, in order.
  final List<String> allValues;

  /// The names currently checked.
  final Set<String> value;

  final ValueChanged<Set<String>>? onChanged;

  final List<Widget> children;

  @override
  State<CheckboxGroup> createState() => _CheckboxGroupState();

  /// The group a [Checkbox] with a name sits in, or null outside one.
  static CheckboxGroupScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CheckboxGroupScope>();
  }
}

class _CheckboxGroupState extends State<CheckboxGroup> {
  /// What was checked before the parent last cleared everything, so pressing
  /// it twice puts the group back rather than leaving the reader to re-tick.
  Set<String>? _restore;

  void _toggle(String name) {
    final Set<String> next = widget.value.contains(name)
        ? (widget.value.toSet()..remove(name))
        : (widget.value.toSet()..add(name));
    _restore = null;
    widget.onChanged?.call(next);
  }

  void _toggleAll() {
    final bool all = widget.value.length == widget.allValues.length;
    if (all) {
      _restore = widget.value.toSet();
      widget.onChanged?.call(<String>{});
      return;
    }
    if (widget.value.isEmpty && _restore != null && _restore!.isNotEmpty) {
      final Set<String> back = _restore!;
      _restore = null;
      widget.onChanged?.call(back);
      return;
    }
    _restore = null;
    widget.onChanged?.call(widget.allValues.toSet());
  }

  /// Whether one of the direct children is the parent box. The measure is the
  /// medium box because a parent and its children are one list, and a
  /// mixed-size list is not a case this indent has to serve.
  bool get hasParent =>
      widget.children.any((child) => child is Checkbox && child.parent);

  @override
  Widget build(BuildContext context) {
    return CheckboxGroupScope(
      value: widget.value,
      allValues: widget.allValues,
      enabled: widget.onChanged != null,
      onToggle: _toggle,
      onToggleAll: _toggleAll,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        // Tighter than a form's run between fields: these are the options of a
        // single question, and air between them would read as separate
        // questions.
        spacing: Theme.of(context).vars.spacing25,
        children: [
          for (final Widget child in widget.children)
            // Where the group has a parent, its children are indented to
            // where the parent's label starts — the box plus the row's gap.
            // The indent is what says these are under it; the wiring alone is
            // invisible.
            if (hasParent && child is Checkbox && !child.parent)
              Padding(
                padding: EdgeInsetsDirectional.only(
                  start:
                      Theme.of(context).vars.checkboxMediumBox +
                      Theme.of(context).vars.spacing25,
                ),
                child: child,
              )
            else
              child,
        ],
      ),
    );
  }
}

/// What a [Checkbox] inside a [CheckboxGroup] reads.
class CheckboxGroupScope extends InheritedWidget {
  const CheckboxGroupScope({
    super.key,
    required this.value,
    required this.allValues,
    required this.enabled,
    required this.onToggle,
    required this.onToggleAll,
    required super.child,
  });

  final Set<String> value;
  final List<String> allValues;
  final bool enabled;
  final ValueChanged<String> onToggle;
  final VoidCallback onToggleAll;

  bool get allChecked =>
      allValues.isNotEmpty && value.length == allValues.length;

  bool get someChecked => value.isNotEmpty && !allChecked;

  @override
  bool updateShouldNotify(CheckboxGroupScope oldWidget) {
    return !setEquals(oldWidget.value, value) ||
        oldWidget.enabled != enabled ||
        !listEquals(oldWidget.allValues, allValues);
  }
}
