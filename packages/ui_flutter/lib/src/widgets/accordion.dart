import 'package:flutter/widgets.dart';

import '../generated/theme_variables.dart';
import '../theme/theme.dart';
import 'collapsible.dart';

/// One section of an [Accordion]: the header that opens it, and everything it
/// discloses.
@immutable
class AccordionItem {
  const AccordionItem({
    required this.value,
    required this.title,
    required this.child,
    this.icon,
    this.meta,
    this.enabled = true,
  });

  /// Identifies the section. It is what [Accordion.open] holds, so it survives
  /// a re-order where an index would not.
  final String value;

  final Widget title;

  final Widget child;

  final IconData? icon;

  final Widget? meta;

  final bool enabled;
}

/// Several disclosures that know about each other.
///
/// That knowledge is the whole difference from a run of [Collapsible]s: by
/// default opening one shuts the last, so a reader is always looking at one
/// section rather than at a page that grew while they were reading it.
/// [multiple] is the deliberate opt-in for the case where they are comparing
/// rather than choosing.
///
/// The rows and the panels are the same drawing a [Collapsible] wears. What is
/// the accordion's own is the run between the sections — the thing a single
/// disclosure has no opinion about.
class Accordion extends StatefulWidget {
  const Accordion({
    super.key,
    required this.items,
    this.open,
    this.initiallyOpen = const <String>[],
    this.onOpenChanged,
    this.multiple = false,
    this.divided = false,
    this.enabled = true,
  });

  final List<AccordionItem> items;

  /// Drive it from outside. Left null the widget holds its own state.
  final Set<String>? open;

  final List<String> initiallyOpen;

  final ValueChanged<Set<String>>? onOpenChanged;

  /// Whether two sections may be open at once.
  final bool multiple;

  /// Draws a hairline between the sections, for a run that has to read as one
  /// list rather than as a stack of separate disclosures.
  final bool divided;

  final bool enabled;

  @override
  State<Accordion> createState() => _AccordionState();
}

class _AccordionState extends State<Accordion> {
  late Set<String> _open = widget.initiallyOpen.toSet();

  Set<String> get _value => widget.open ?? _open;

  void _toggle(String value) {
    final Set<String> current = _value;
    final Set<String> next = current.contains(value)
        ? (current.toSet()..remove(value))
        : widget.multiple
        ? (current.toSet()..add(value))
        : <String>{value};

    if (widget.open == null) setState(() => _open = next);
    widget.onOpenChanged?.call(next);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;
    final Set<String> open = _value;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int index = 0; index < widget.items.length; index += 1)
          Builder(
            builder: (context) {
              final AccordionItem item = widget.items[index];
              final bool isOpen = open.contains(item.value);
              final bool enabled = widget.enabled && item.enabled;

              final Widget section = Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DisclosureHeader(
                    title: item.title,
                    icon: item.icon,
                    meta: item.meta,
                    open: isOpen,
                    enabled: enabled,
                    onPressed: () => _toggle(item.value),
                  ),
                  ClipRect(
                    child: AnimatedSize(
                      duration: vars.motionDuration,
                      curve: vars.motionEasing,
                      alignment: Alignment.topCenter,
                      child: isOpen
                          ? DisclosurePanel(child: item.child)
                          : const SizedBox(width: double.infinity),
                    ),
                  ),
                ],
              );

              // Undivided, the sections sit on one run with nothing between
              // them: the rows are already separated by their own hover wash,
              // and a rule under every one would draw a table. `divided` is
              // for the case where they are genuinely a list.
              if (!widget.divided || index == 0) return section;

              return DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: vars.colorBorder,
                      width: context.hairlineWidth,
                    ),
                  ),
                ),
                child: section,
              );
            },
          ),
      ],
    );
  }
}
