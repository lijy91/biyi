import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../foundation/widget_size.dart';
import '../foundation/widget_tint.dart';
import '../foundation/widget_variant.dart';
import '../generated/theme_variables.dart';
import '../painting/widget_property.dart';
import '../theme/theme.dart';
import 'pressable.dart';

/// The ramp a selected row is washed with.
enum TreeTint with WidgetTint {
  primary,
  neutral,
  info,
  success,
  warning,
  danger,
}

/// How long a run of keystrokes counts as one word for type-ahead.
const Duration _kTypeahead = Duration(milliseconds: 600);

/// One entry in a [Tree].
@immutable
class TreeNode<T> {
  const TreeNode({
    required this.id,
    required this.label,
    this.icon,
    this.meta,
    this.children,
    this.text,
    this.enabled = true,
  });

  final T id;

  final Widget label;

  /// A glyph before the label — a file's kind, a folder, a status.
  final IconData? icon;

  /// A trailing aside: a count, a change marker, a [Badge].
  final Widget? meta;

  /// Present at all — empty included — marks the node as a branch. An empty
  /// list is how an empty folder still draws a twisty and still opens, which
  /// is the difference between "nothing in here" and "not a folder".
  final List<TreeNode<T>>? children;

  /// What type-ahead matches on, where [label] is not a [Text].
  final String? text;

  final bool enabled;

  bool get isBranch => children != null;
}

/// One visible row: a node, and where it sits.
class _Row<T> {
  const _Row({
    required this.node,
    required this.level,
    required this.parent,
    required this.open,
  });

  final TreeNode<T> node;
  final int level;
  final T? parent;
  final bool open;
}

/// A hierarchy the reader walks.
///
/// The keyboard is the reason this is written out rather than assembled from
/// [Collapsible]s: `ArrowRight` opens a shut branch and descends into an open
/// one, `ArrowLeft` shuts one and climbs out of a leaf, and the whole tree is
/// a single tab stop so focus roves inside it rather than tabbing through a
/// hundred files. A tree of disclosures is a hundred tab stops and no way
/// across them.
///
/// A branch and a leaf answer a tap differently on purpose. Tapping a folder
/// opens it *and* selects it, because in a file tree those are one gesture;
/// tapping the twisty alone opens it and leaves the selection where it was,
/// which is how a reader looks inside a folder without losing the file they
/// were reading.
class Tree<T> extends StatefulWidget {
  const Tree({
    super.key,
    required this.items,
    this.expanded,
    this.initiallyExpanded = const <Never>[],
    this.onExpandedChanged,
    this.selected,
    this.onSelectedChanged,
    this.size = WidgetSize.medium,
    this.tint = TreeTint.primary,
    this.semanticsLabel,
  });

  final List<TreeNode<T>> items;

  /// Drive the open branches from outside. Left null the widget holds them.
  final List<T>? expanded;

  final List<T> initiallyExpanded;

  final ValueChanged<List<T>>? onExpandedChanged;

  final T? selected;

  final ValueChanged<T>? onSelectedChanged;

  /// Two densities, both under control height: a tree is a column of names
  /// rather than a column of controls.
  final WidgetSize size;

  /// Which ramp the selected row is washed with. The hover comes off the
  /// `normal` recipe either way — that one reads the theme's surface roles
  /// rather than a ramp, which is what keeps a row's hover neutral while its
  /// selection carries the accent.
  final TreeTint tint;

  final String? semanticsLabel;

  @override
  State<Tree<T>> createState() => _TreeState<T>();
}

class _TreeState<T> extends State<Tree<T>> {
  late Set<T> _own = <T>{...widget.initiallyExpanded};
  final Map<T, FocusNode> _nodes = <T, FocusNode>{};
  T? _active;
  String _typed = '';
  DateTime _typedAt = DateTime.fromMillisecondsSinceEpoch(0);

  Set<T> get _open => widget.expanded != null ? <T>{...widget.expanded!} : _own;

  @override
  void dispose() {
    for (final FocusNode node in _nodes.values) {
      node.dispose();
    }
    super.dispose();
  }

  List<_Row<T>> _flatten(
    List<TreeNode<T>> items, [
    int level = 1,
    T? parent,
  ]) {
    final Set<T> open = _open;
    final List<_Row<T>> rows = <_Row<T>>[];
    for (final TreeNode<T> node in items) {
      final bool isOpen = node.isBranch && open.contains(node.id);
      rows.add(
        _Row<T>(node: node, level: level, parent: parent, open: isOpen),
      );
      if (isOpen) {
        rows.addAll(_flatten(node.children!, level + 1, node.id));
      }
    }
    return rows;
  }

  void _setOpen(T id, bool next) {
    final Set<T> value = <T>{..._open};
    if (next) {
      value.add(id);
    } else {
      value.remove(id);
    }
    if (widget.expanded == null) setState(() => _own = value);
    widget.onExpandedChanged?.call(value.toList());
  }

  void _focus(T id) {
    setState(() => _active = id);
    _nodes[id]?.requestFocus();
  }

  KeyEventResult _onKey(List<_Row<T>> rows, _Row<T> row, KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }
    final int here = rows.indexWhere(
      (_Row<T> one) => one.node.id == row.node.id,
    );

    void move(int by) {
      if (here + by < 0 || here + by >= rows.length) return;
      final _Row<T> next = rows[here + by];
      if (next.node.enabled) _focus(next.node.id);
    }

    final LogicalKeyboardKey key = event.logicalKey;
    if (key == LogicalKeyboardKey.arrowDown) {
      move(1);
    } else if (key == LogicalKeyboardKey.arrowUp) {
      move(-1);
    } else if (key == LogicalKeyboardKey.arrowRight) {
      // Open, then descend — two presses rather than one, so a reader opening
      // a folder does not also lose their place inside it.
      if (row.node.isBranch && !row.open) {
        _setOpen(row.node.id, true);
      } else if (row.open) {
        move(1);
      }
    } else if (key == LogicalKeyboardKey.arrowLeft) {
      if (row.node.isBranch && row.open) {
        _setOpen(row.node.id, false);
      } else if (row.parent != null) {
        _focus(row.parent as T);
      }
    } else if (key == LogicalKeyboardKey.home) {
      if (rows.isNotEmpty) _focus(rows.first.node.id);
    } else if (key == LogicalKeyboardKey.end) {
      if (rows.isNotEmpty) _focus(rows.last.node.id);
    } else if (key == LogicalKeyboardKey.enter ||
        key == LogicalKeyboardKey.space) {
      if (row.node.enabled) widget.onSelectedChanged?.call(row.node.id);
      if (row.node.isBranch) _setOpen(row.node.id, !row.open);
    } else {
      final String? character = event.character;
      if (character == null || character.trim().isEmpty) {
        return KeyEventResult.ignored;
      }
      // Type-ahead over the *visible* rows only: a name inside a shut folder
      // is not on screen, and jumping to something the reader cannot see is
      // worse than not jumping.
      final DateTime now = DateTime.now();
      _typed = now.difference(_typedAt) < _kTypeahead
          ? _typed + character.toLowerCase()
          : character.toLowerCase();
      _typedAt = now;
      final List<_Row<T>> order = <_Row<T>>[
        ...rows.skip(here + 1),
        ...rows.take(here + 1),
      ];
      for (final _Row<T> candidate in order) {
        if (!candidate.node.enabled) continue;
        if (_label(candidate.node).startsWith(_typed)) {
          _focus(candidate.node.id);
          break;
        }
      }
    }
    return KeyEventResult.handled;
  }

  String _label(TreeNode<T> node) {
    final Widget label = node.label;
    final String text = node.text ?? (label is Text ? (label.data ?? '') : '');
    return text.trim().toLowerCase();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;
    final List<_Row<T>> rows = _flatten(widget.items);

    // Shutting a folder can take the roving tab stop with it, and a tree with
    // no reachable row cannot be tabbed into at all. So the stop falls back to
    // the first row rather than to nothing.
    final bool activeVisible =
        _active != null && rows.any((_Row<T> row) => row.node.id == _active);
    final T? stop = activeVisible
        ? _active
        : (rows.isEmpty ? null : rows.first.node.id);

    final double height = switch (widget.size.namedSize) {
      NamedSize.small => vars.spacing6,
      _ => vars.spacing7,
    };
    final TextStyle face = switch (widget.size.namedSize) {
      NamedSize.small => vars.labelQuiet.copyWith(
        fontSize: vars.labelSmall.fontSize,
      ),
      _ => vars.labelQuiet,
    };

    return Semantics(
      container: true,
      label: widget.semanticsLabel,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (final _Row<T> row in rows)
            _TreeRow<T>(
              key: ValueKey<T>(row.node.id),
              row: row,
              height: height,
              face: face,
              tint: widget.tint,
              selected: widget.selected == row.node.id,
              focusNode: _nodes.putIfAbsent(row.node.id, FocusNode.new),
              // One tab stop for the whole tree: every other row is reachable
              // by an arrow key and skipped by Tab, which is the roving
              // tabindex written the way Flutter spells it.
              skipTraversal: row.node.id != stop,
              onKey: (KeyEvent event) => _onKey(rows, row, event),
              onFocused: () => setState(() => _active = row.node.id),
              onPressed: () {
                if (!row.node.enabled) return;
                widget.onSelectedChanged?.call(row.node.id);
                if (row.node.isBranch) _setOpen(row.node.id, !row.open);
              },
              onTwisty: row.node.isBranch && row.node.enabled
                  ? () => _setOpen(row.node.id, !row.open)
                  : null,
            ),
        ],
      ),
    );
  }
}

class _TreeRow<T> extends StatelessWidget {
  const _TreeRow({
    super.key,
    required this.row,
    required this.height,
    required this.face,
    required this.tint,
    required this.selected,
    required this.focusNode,
    required this.skipTraversal,
    required this.onKey,
    required this.onFocused,
    required this.onPressed,
    required this.onTwisty,
  });

  final _Row<T> row;
  final double height;
  final TextStyle face;
  final TreeTint tint;
  final bool selected;
  final FocusNode focusNode;
  final bool skipTraversal;
  final KeyEventResult Function(KeyEvent event) onKey;
  final VoidCallback onFocused;
  final VoidCallback onPressed;
  final VoidCallback? onTwisty;

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;
    final BorderRadius radius = BorderRadius.circular(vars.radiusSmall);
    final Color seed = vars.controlColor.tinted<ColorSwatch<int>>(tint);

    focusNode.skipTraversal = skipTraversal;

    return Focus(
      focusNode: focusNode,
      onKeyEvent: (FocusNode node, KeyEvent event) => onKey(event),
      onFocusChange: (bool value) {
        if (value) onFocused();
      },
      child: Pressable(
        onPressed: row.node.enabled ? onPressed : null,
        enabled: row.node.enabled,
        selected: selected,
        borderRadius: radius,
        // The row carries its own focus above; a second focusable inside it
        // would be a second stop on a tree that is meant to have one.
        showFocusRing: false,
        builder: (context, states) {
          final bool hovered = states.contains(WidgetState.hovered);

          Color surface = const Color(0x00000000);
          Color content = row.node.enabled
              ? vars.colorContentNav
              : vars.colorContentFaint;
          TextStyle style = face;

          if (selected) {
            // Selection shifts weight as well as colour, the way every
            // selected thing in this system does. On a column of forty rows
            // the weight is doing most of the work — one grade of colour is
            // hardest to find in exactly this shape.
            surface = vars.controlColorSurface.varianted<Color>(
              _TreeSelected.tinted,
              const <WidgetState>{},
              seed,
            );
            content = vars.controlColorContent.varianted<Color>(
              _TreeSelected.tinted,
              const <WidgetState>{},
              seed,
            );
            style = face.copyWith(
              fontFamily: vars.labelMedium.fontFamily,
              fontWeight: vars.labelMedium.fontWeight,
            );
          } else if (hovered && row.node.enabled) {
            // The neutral control's wash — the card step — which is what a
            // menu item, a table row and a tree row all want. `plain` would
            // come off the tinted ramp and sit heavier than the selection one
            // rung below it.
            surface = vars.colorSurfaceSubtle;
            content = vars.colorContent;
          }

          return AnimatedContainer(
            duration: vars.motionDuration,
            curve: vars.motionEasing,
            height: height,
            padding: EdgeInsetsDirectional.only(
              // One step per level, plus the row's own leading inset. The
              // twisty column is inside the indent, which is what keeps the
              // glyphs of one level in a straight line.
              start: vars.spacing1 + (row.level - 1) * vars.spacing4,
              end: vars.spacing2,
            ),
            decoration: BoxDecoration(color: surface, borderRadius: radius),
            child: Row(
              children: <Widget>[
                _Twisty(
                  open: row.open,
                  branch: row.node.isBranch,
                  onPressed: onTwisty,
                ),
                if (row.node.icon != null) ...<Widget>[
                  SizedBox(width: vars.spacing1),
                  Icon(
                    row.node.icon,
                    size: vars.spacing4,
                    color: selected ? content : vars.colorContentSubtle,
                  ),
                ],
                SizedBox(width: vars.spacing1),
                Expanded(
                  child: DefaultTextStyle.merge(
                    style: style.copyWith(color: content),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    child: row.node.label,
                  ),
                ),
                if (row.node.meta != null)
                  Padding(
                    padding: EdgeInsetsDirectional.only(start: vars.spacing2),
                    child: DefaultTextStyle.merge(
                      style: vars.captionSmall.copyWith(
                        color: selected ? content : vars.colorContentFaint,
                      ),
                      child: row.node.meta!,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// The recipe a selected row is washed with. `varianted` is keyed by an enum
/// that mixes in `WidgetVariant`, and a tree has no variant axis to expose.
enum _TreeSelected with WidgetVariant { tinted }

/// The twisty keeps its column on a leaf as well as a branch, empty.
///
/// Files and folders at one level start at one x, which is what makes a deep
/// tree scannable — a leaf that reclaimed the space would put every filename
/// at a different indent from its siblings.
class _Twisty extends StatelessWidget {
  const _Twisty({
    required this.open,
    required this.branch,
    required this.onPressed,
  });

  final bool open;
  final bool branch;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;

    final Widget glyph = SizedBox(
      width: vars.spacing4,
      height: vars.spacing4,
      child: branch
          ? Center(
              child: AnimatedRotation(
                duration: vars.motionDuration,
                curve: vars.motionEasing,
                turns: open ? 0.25 : 0,
                child: Icon(
                  FluentIcons.chevron_right_12_regular,
                  size: vars.spacing3,
                  color: vars.colorContentFaint,
                ),
              ),
            )
          : null,
    );

    if (!branch || onPressed == null) return glyph;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // The twisty is the one target that opens without selecting, so its tap
      // must not reach the row behind it.
      onTap: onPressed,
      child: glyph,
    );
  }
}
