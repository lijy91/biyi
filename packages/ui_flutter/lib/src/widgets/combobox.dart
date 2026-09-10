import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/widgets.dart';

import '../foundation/widget_size.dart';
import '../generated/theme_variables.dart';
import '../theme/theme.dart';
import 'field_box.dart';
import 'menu.dart';
import 'popover.dart';
import 'pressable.dart';
import 'text_field.dart';

/// One choosable option.
@immutable
class ComboboxOption<T> {
  const ComboboxOption({
    required this.value,
    required this.label,
    this.enabled = true,
  });

  final T value;

  /// What is shown, and what the query is matched against.
  final String label;

  final bool enabled;
}

/// A run of options under a heading, the way `<optgroup>` groups.
@immutable
class ComboboxGroup<T> {
  const ComboboxGroup({required this.label, required this.options});

  final String label;
  final List<ComboboxOption<T>> options;
}

/// A choice out of a list too long to scroll: the reader types to narrow it,
/// and picks one of what is left.
///
/// It is a `Select` with a query in front of it, and that is the only question
/// worth asking when choosing between them — a list of six is a select, a list
/// of six hundred is this. Both end in one of the options; neither lets a
/// reader enter something that is not on the list, which is what separates
/// them from an [Autocomplete].
///
/// The box is the [TextField]'s and the list is the [MenuPanel], so a combobox
/// in a form sits on the same rhythm as everything around it and its list is
/// the same panel a [Menu] opens.
class Combobox<T> extends StatefulWidget {
  const Combobox({
    super.key,
    this.options = const [],
    this.groups = const [],
    this.value,
    this.onChanged,
    this.placeholder = 'Search…',
    this.emptyLabel = 'No matches',
    this.clearable = true,
    this.size = WidgetSize.medium,
    this.state = TextFieldState.normal,
    this.tint = TextFieldTint.primary,
  });

  /// The flat list. Leave it empty and pass [groups] instead to group them.
  ///
  /// Grouped or flat, never both: a list read one way would silently lose the
  /// other. It is not asserted in the constructor — `length` is not something
  /// a `const` assert may read, and every story here is const — so the build
  /// reads [groups] first and ignores a flat list beside it.
  final List<ComboboxOption<T>> options;

  /// The grouped list. When it is not empty it is what is drawn.
  final List<ComboboxGroup<T>> groups;

  final T? value;

  final ValueChanged<T?>? onChanged;

  final String placeholder;

  /// What the list says when the query matches nothing.
  final String emptyLabel;

  /// Offers a control that clears the chosen option.
  final bool clearable;

  final WidgetSize size;

  final TextFieldState state;

  final TextFieldTint tint;

  @override
  State<Combobox<T>> createState() => _ComboboxState<T>();
}

class _ComboboxState<T> extends State<Combobox<T>> {
  final OverlayPortalController _controller = OverlayPortalController();
  final LayerLink _link = LayerLink();
  final TextEditingController _query = TextEditingController();
  final FocusNode _focus = FocusNode();
  bool _open = false;
  double _anchorWidth = 0;

  @override
  void initState() {
    super.initState();
    _query.text = _labelFor(widget.value) ?? '';
    _focus.addListener(_handleFocus);
  }

  @override
  void didUpdateWidget(Combobox<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value && !_open) {
      _query.text = _labelFor(widget.value) ?? '';
    }
  }

  @override
  void dispose() {
    _focus.removeListener(_handleFocus);
    _focus.dispose();
    _query.dispose();
    super.dispose();
  }

  void _handleFocus() {
    if (mounted) setState(() {});
  }

  List<ComboboxOption<T>> get _flat => [
    ...widget.options,
    for (final ComboboxGroup<T> group in widget.groups) ...group.options,
  ];

  String? _labelFor(T? value) {
    if (value == null) return null;
    for (final ComboboxOption<T> option in _flat) {
      if (option.value == value) return option.label;
    }
    return null;
  }

  bool _matches(ComboboxOption<T> option) {
    final String query = _query.text.trim().toLowerCase();
    if (query.isEmpty) return true;
    // The chosen option's own label is not a query: a list that emptied itself
    // the moment it was reopened would look broken.
    if (option.label.toLowerCase() == query) return true;
    return option.label.toLowerCase().contains(query);
  }

  void _openList() {
    if (_open) return;
    setState(() => _open = true);
    _controller.show();
  }

  void _close() {
    if (!_open) return;
    setState(() => _open = false);
    _controller.hide();
    _query.text = _labelFor(widget.value) ?? '';
  }

  void _choose(ComboboxOption<T> option) {
    widget.onChanged?.call(option.value);
    _query.text = option.label;
    _close();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;
    final FieldMetrics metrics = FieldMetrics.of(vars, widget.size);
    final bool enabled = widget.onChanged != null;
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

    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _controller,
        overlayChildBuilder: (context) => PopoverOverlay(
          link: _link,
          side: PopoverSide.bottom,
          align: PopoverAlign.start,
          gap: vars.spacing1,
          onDismiss: _close,
          // The list is at least as wide as the field it dropped from, the way
          // a select's is.
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: _anchorWidth),
            child: _List<T>(
              groups: widget.groups,
              options: widget.options,
              matches: _matches,
              selected: widget.value,
              emptyLabel: widget.emptyLabel,
              onChoose: _choose,
            ),
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth.isFinite) {
              _anchorWidth = constraints.maxWidth;
            }

            return AnimatedContainer(
              duration: vars.motionDuration,
              curve: vars.motionEasing,
              height: metrics.height,
              decoration: fieldBoxDecoration(
                context,
                ramp: ramp,
                focused: _focus.hasFocus || _open,
                invalid: invalid,
                enabled: enabled,
              ),
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
                      controller: _query,
                      focusNode: _focus,
                      enabled: enabled,
                      placeholder: widget.placeholder,
                      size: widget.size,
                      state: widget.state,
                      tint: widget.tint,
                      decoration: const BoxDecoration(),
                      padding: EdgeInsets.zero,
                      onTap: _openList,
                      onChanged: (_) {
                        _openList();
                        setState(() {});
                      },
                    ),
                  ),
                  if (widget.clearable && widget.value != null)
                    _FieldAction(
                      icon: FluentIcons.dismiss_12_regular,
                      semanticsLabel: 'Clear',
                      onPressed: enabled
                          ? () {
                              widget.onChanged?.call(null);
                              _query.clear();
                            }
                          : null,
                    ),
                  _FieldAction(
                    icon: _open
                        ? FluentIcons.chevron_up_12_regular
                        : FluentIcons.chevron_down_12_regular,
                    semanticsLabel: 'Open',
                    onPressed: enabled ? (_open ? _close : _openList) : null,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// The filtered panel, grouped or flat.
class _List<T> extends StatelessWidget {
  const _List({
    required this.groups,
    required this.options,
    required this.matches,
    required this.selected,
    required this.emptyLabel,
    required this.onChoose,
  });

  final List<ComboboxGroup<T>> groups;
  final List<ComboboxOption<T>> options;
  final bool Function(ComboboxOption<T>) matches;
  final T? selected;
  final String emptyLabel;
  final ValueChanged<ComboboxOption<T>> onChoose;

  @override
  Widget build(BuildContext context) {
    final List<Widget> rows = [];

    Widget row(ComboboxOption<T> option) => MenuRow(
      item: MenuItem(
        label: option.label,
        checked: option.value == selected,
        enabled: option.enabled,
      ),
      onSelect: option.enabled ? () => onChoose(option) : null,
    );

    if (groups.isEmpty) {
      rows.addAll(options.where(matches).map(row));
    } else {
      for (final ComboboxGroup<T> group in groups) {
        final List<ComboboxOption<T>> kept = group.options
            .where(matches)
            .toList();
        // A group the query emptied is not a heading over nothing.
        if (kept.isEmpty) continue;
        rows.add(MenuGroupLabel(child: Text(group.label)));
        rows.addAll(kept.map(row));
      }
    }

    return MenuPanel(
      children: rows.isEmpty ? [MenuEmpty(child: Text(emptyLabel))] : rows,
    );
  }
}

/// The clear and the chevron: the field's own furniture rather than buttons on
/// it — no box at rest, the subtle ink, and the neutral wash only under the
/// pointer. A pair of drawn buttons inside a field would read as two more
/// controls in the form.
class _FieldAction extends StatelessWidget {
  const _FieldAction({
    required this.icon,
    required this.semanticsLabel,
    required this.onPressed,
  });

  final IconData icon;
  final String semanticsLabel;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;
    final BorderRadius radius = BorderRadius.circular(vars.radiusSmall);

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
          width: vars.spacing5,
          height: vars.spacing5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: washed ? vars.colorSurfaceSubtle : null,
            borderRadius: radius,
          ),
          child: Icon(
            icon,
            size: vars.labelSmall.fontSize,
            color: washed ? vars.colorContent : vars.colorContentSubtle,
          ),
        );
      },
    );
  }
}

/// A text field that suggests as you type.
///
/// The difference from a [Combobox] is what the value is: a combobox ends in
/// one of its options and nothing else; an autocomplete's value is whatever
/// was typed, and the list is a shortcut to a likely answer rather than the
/// set of allowed ones. A branch name, a search query, a tag that may not
/// exist yet.
///
/// So there is no chevron and no clear: nothing here is opened or chosen, and
/// the field is emptied the way any text field is.
class Autocomplete extends StatefulWidget {
  const Autocomplete({
    super.key,
    required this.items,
    required this.value,
    this.onChanged,
    this.placeholder,
    this.emptyLabel = 'No matches',
    this.size = WidgetSize.medium,
    this.state = TextFieldState.normal,
    this.tint = TextFieldTint.primary,
  });

  /// The suggestions offered as the reader types.
  final List<String> items;

  final String value;

  final ValueChanged<String>? onChanged;

  final String? placeholder;

  final String emptyLabel;

  final WidgetSize size;

  final TextFieldState state;

  final TextFieldTint tint;

  @override
  State<Autocomplete> createState() => _AutocompleteState();
}

class _AutocompleteState extends State<Autocomplete> {
  final OverlayPortalController _controller = OverlayPortalController();
  final LayerLink _link = LayerLink();
  late final TextEditingController _text = TextEditingController(
    text: widget.value,
  );
  final FocusNode _focus = FocusNode();
  bool _open = false;
  double _anchorWidth = 0;

  @override
  void didUpdateWidget(Autocomplete oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != _text.text) _text.text = widget.value;
  }

  @override
  void dispose() {
    _focus.dispose();
    _text.dispose();
    super.dispose();
  }

  void _openList() {
    if (_open) return;
    setState(() => _open = true);
    _controller.show();
  }

  void _close() {
    if (!_open) return;
    setState(() => _open = false);
    _controller.hide();
  }

  List<String> get _matches {
    final String query = widget.value.trim().toLowerCase();
    if (query.isEmpty) return widget.items;
    return widget.items
        .where((item) => item.toLowerCase().contains(query))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;
    final List<String> matches = _matches;

    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _controller,
        overlayChildBuilder: (context) => PopoverOverlay(
          link: _link,
          side: PopoverSide.bottom,
          align: PopoverAlign.start,
          gap: vars.spacing1,
          onDismiss: _close,
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: _anchorWidth),
            child: MenuPanel(
              children: matches.isEmpty
                  ? [MenuEmpty(child: Text(widget.emptyLabel))]
                  : [
                      for (final String item in matches)
                        MenuRow(
                          item: MenuItem(label: item),
                          onSelect: () {
                            widget.onChanged?.call(item);
                            _close();
                          },
                        ),
                    ],
            ),
          ),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth.isFinite) {
              _anchorWidth = constraints.maxWidth;
            }

            return TextField(
              controller: _text,
              focusNode: _focus,
              enabled: widget.onChanged != null,
              placeholder: widget.placeholder,
              size: widget.size,
              state: widget.state,
              tint: widget.tint,
              onTap: _openList,
              onChanged: (value) {
                widget.onChanged?.call(value);
                _openList();
              },
            );
          },
        ),
      ),
    );
  }
}
