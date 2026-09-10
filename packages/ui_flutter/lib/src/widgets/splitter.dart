import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../generated/theme_variables.dart';
import '../theme/theme.dart';

/// Which way the panels are laid out, not which way a handle runs.
enum SplitterOrientation { horizontal, vertical }

/// How far one arrow key moves a seam, and one with shift held.
const double _kStep = 1;
const double _kCoarseStep = 10;

/// How much wider the rule is drawn while the pointer is on it.
const double _kGripSwell = 2;

/// One region of a [Splitter].
///
/// It is a description as much as a widget: the splitter counts these to know
/// how many handles to draw and reads their constraints to know what each
/// handle may do.
@immutable
class SplitterPanel {
  const SplitterPanel({
    required this.child,
    this.defaultSize = 1,
    this.minSize = 0,
    this.maxSize = 100,
  });

  final Widget child;

  /// Share of the run at rest. The shares are normalised, so three panels
  /// written `50`, `25`, `25` and three written `2`, `1`, `1` lay out
  /// identically.
  final double defaultSize;

  /// Floor and ceiling, as percentages of the whole run.
  final double minSize;
  final double maxSize;
}

/// Two or more regions the reader can re-proportion.
///
/// A desktop window is mostly this — a column beside a document beside an
/// inspector — and which of the three deserves the room is the reader's
/// decision rather than the designer's. Where a column has one right width and
/// the reader only opens or shuts it, that is [Sidebar] instead: it carries
/// its own width token and its own rail, and drawing it with this would offer
/// a choice the design has already made.
///
/// The handle is drawn *from* the space between two panels rather than added
/// to it: the hit target is a whole step of the scale, so grabbing a seam does
/// not demand pixel accuracy, while the rule itself stays the hairline every
/// other separator in the system is.
///
/// The splitter owns the shares; [onSizesChanged] is for persisting them. A
/// drag that had to round-trip through a host's state would lag the pointer,
/// and a seam that lags the pointer feels broken.
class Splitter extends StatefulWidget {
  const Splitter({
    super.key,
    required this.panels,
    this.orientation = SplitterOrientation.horizontal,
    this.onSizesChanged,
  });

  /// Two or more. One panel has no seam, and the widget would be a `SizedBox`
  /// with extra steps — it is a doc comment rather than an assert because
  /// `List.length` is not const-evaluable, and every story here is a `const`.
  final List<SplitterPanel> panels;

  final SplitterOrientation orientation;

  final ValueChanged<List<double>>? onSizesChanged;

  @override
  State<Splitter> createState() => _SplitterState();
}

class _SplitterState extends State<Splitter> {
  late List<double> _sizes = _normalised();

  /// Normalised to a hundred once, here, so everything downstream — the
  /// clamps, the value a handle reports, what a host is handed to persist —
  /// speaks one unit rather than whatever units the panels were written in.
  List<double> _normalised() {
    final double sum = widget.panels.fold<double>(
      0,
      (double total, SplitterPanel panel) => total + panel.defaultSize,
    );
    return <double>[
      for (final SplitterPanel panel in widget.panels)
        (panel.defaultSize / sum) * 100,
    ];
  }

  @override
  void didUpdateWidget(Splitter old) {
    super.didUpdateWidget(old);
    if (widget.panels.length != old.panels.length) {
      _sizes = _normalised();
    }
  }

  bool get _horizontal => widget.orientation == SplitterOrientation.horizontal;

  /// Both the pointer and the keyboard end here: given the leading panel's new
  /// share, the trailing one takes what the pair has left over. Nothing else
  /// in the row moves, which is what stops a drag at one seam from rippling
  /// through the whole window.
  void _resize(int index, double nextLeading) {
    setState(() {
      final double pair = _sizes[index] + _sizes[index + 1];
      final SplitterPanel lead = widget.panels[index];
      final SplitterPanel trail = widget.panels[index + 1];
      final double leading = nextLeading
          .clamp(lead.minSize, lead.maxSize)
          .clamp(pair - trail.maxSize, pair - trail.minSize)
          .toDouble();
      _sizes[index] = leading;
      _sizes[index + 1] = pair - leading;
    });
    widget.onSizesChanged?.call(List<double>.of(_sizes));
  }

  void _drag(int index, double delta, double run) {
    if (run <= 0) return;
    // Measured against the run the panels actually have, so the seam lands
    // under the pointer rather than near it.
    _resize(index, _sizes[index] + (delta / run) * 100);
  }

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;
    final double target = vars.spacing2;
    final int seams = widget.panels.length - 1;

    return LayoutBuilder(
      builder: (context, constraints) {
        // The handles take their width off the top and the panels divide what
        // is left, so a share is a share of the panels' run rather than of the
        // box.
        final double whole = _horizontal
            ? constraints.maxWidth
            : constraints.maxHeight;
        final double run = whole.isFinite ? whole - seams * target : 0;

        final List<Widget> children = <Widget>[];
        for (int index = 0; index < widget.panels.length; index++) {
          children.add(
            Expanded(
              // Flex is an integer, so a share is carried at a thousandth of
              // a percent — finer than a pointer can ask for.
              flex: (_sizes[index] * 1000).round().clamp(1, 1 << 30),
              child: ClipRect(child: widget.panels[index].child),
            ),
          );
          if (index < seams) {
            children.add(
              _Handle(
                orientation: widget.orientation,
                target: target,
                value: _sizes[index],
                min: widget.panels[index].minSize,
                max: widget.panels[index].maxSize,
                onDrag: (double delta) => _drag(index, delta, run),
                onStep: (double step) => _resize(index, _sizes[index] + step),
                onHome: () => _resize(index, widget.panels[index].minSize),
                onEnd: () => _resize(index, widget.panels[index].maxSize),
                onReset: () =>
                    _resize(index, (_sizes[index] + _sizes[index + 1]) / 2),
              ),
            );
          }
        }

        return _horizontal
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              );
      },
    );
  }
}

/// The seam: a hit target with a rule inside it.
class _Handle extends StatefulWidget {
  const _Handle({
    required this.orientation,
    required this.target,
    required this.value,
    required this.min,
    required this.max,
    required this.onDrag,
    required this.onStep,
    required this.onHome,
    required this.onEnd,
    required this.onReset,
  });

  final SplitterOrientation orientation;
  final double target;
  final double value;
  final double min;
  final double max;
  final ValueChanged<double> onDrag;
  final ValueChanged<double> onStep;
  final VoidCallback onHome;
  final VoidCallback onEnd;
  final VoidCallback onReset;

  @override
  State<_Handle> createState() => _HandleState();
}

class _HandleState extends State<_Handle> {
  bool _hovered = false;
  bool _focused = false;
  bool _dragging = false;

  bool get _horizontal => widget.orientation == SplitterOrientation.horizontal;

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent && event is! KeyRepeatEvent) {
      return KeyEventResult.ignored;
    }
    final bool shift = HardwareKeyboard.instance.isShiftPressed;
    final double step = shift ? _kCoarseStep : _kStep;
    final LogicalKeyboardKey back = _horizontal
        ? LogicalKeyboardKey.arrowLeft
        : LogicalKeyboardKey.arrowUp;
    final LogicalKeyboardKey forward = _horizontal
        ? LogicalKeyboardKey.arrowRight
        : LogicalKeyboardKey.arrowDown;

    if (event.logicalKey == back) {
      widget.onStep(-step);
    } else if (event.logicalKey == forward) {
      widget.onStep(step);
    } else if (event.logicalKey == LogicalKeyboardKey.home) {
      widget.onHome();
    } else if (event.logicalKey == LogicalKeyboardKey.end) {
      widget.onEnd();
    } else {
      return KeyEventResult.ignored;
    }
    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;
    final bool lit = _hovered || _focused || _dragging;

    // Under the pointer the rule takes the accent and thickens, which is the
    // whole affordance: a hairline that never answers is indistinguishable
    // from a border, and a reader has no way to learn that this one can be
    // dragged. It swells rather than reflows — a seam that pushed its
    // neighbours aside on the way to a drag would be a layout jump.
    final Color ink = lit
        ? vars.colorPrimary[vars.controlColorFilledSurface.normalShade!]!
        : vars.colorBorder;
    final double weight = vars.strokeHairline * (lit ? _kGripSwell : 1);

    final Widget grip = Center(
      child: AnimatedContainer(
        duration: vars.motionDuration,
        curve: vars.motionEasing,
        width: _horizontal ? weight : double.infinity,
        height: _horizontal ? double.infinity : weight,
        color: ink,
      ),
    );

    return Focus(
      onKeyEvent: _onKey,
      onFocusChange: (bool value) => setState(() => _focused = value),
      child: MouseRegion(
        cursor: _horizontal
            ? SystemMouseCursors.resizeColumn
            : SystemMouseCursors.resizeRow,
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        child: Semantics(
          slider: true,
          value: '${widget.value.round()}%',
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            // An even split of this pair alone, which is what a reader means
            // by double-tapping one seam.
            onDoubleTap: widget.onReset,
            onHorizontalDragStart: _horizontal
                ? (_) => setState(() => _dragging = true)
                : null,
            onHorizontalDragUpdate: _horizontal
                ? (DragUpdateDetails d) => widget.onDrag(d.delta.dx)
                : null,
            onHorizontalDragEnd: _horizontal
                ? (_) => setState(() => _dragging = false)
                : null,
            onVerticalDragStart: _horizontal
                ? null
                : (_) => setState(() => _dragging = true),
            onVerticalDragUpdate: _horizontal
                ? null
                : (DragUpdateDetails d) => widget.onDrag(d.delta.dy),
            onVerticalDragEnd: _horizontal
                ? null
                : (_) => setState(() => _dragging = false),
            child: SizedBox(
              width: _horizontal ? widget.target : null,
              height: _horizontal ? null : widget.target,
              child: grip,
            ),
          ),
        ),
      ),
    );
  }
}
