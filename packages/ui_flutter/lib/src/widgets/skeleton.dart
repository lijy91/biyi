import 'package:flutter/widgets.dart';

import '../generated/theme_variables.dart';
import '../theme/theme.dart';

/// What a bar is standing in for.
///
/// [text] is a bar on the line box of the type it replaces; [circle] is an
/// avatar or a glyph, squared from its width alone; [rect] is everything with
/// a box of its own — a thumbnail, a chart, a card.
enum SkeletonShape { text, circle, rect }

/// How long one pass of the highlight takes.
///
/// Slower than the spinner's turn: this is scenery behind a layout, and at the
/// spinner's pace a page of bars reads as an alarm.
const Duration _kSweep = Duration(milliseconds: 1600);

/// The shape of something that has not arrived.
///
/// A [Spinner] says the app is busy; a skeleton says *what* is coming, and
/// where it will be — which is why it belongs on the first load of a view
/// whose layout is already known, and a spinner belongs on an action whose
/// result is not. Drawing one for content that then lands somewhere else is
/// worse than drawing nothing.
///
/// The fill is `surface-sunken`, the same dead step a disabled control
/// flattens to, which is exactly what this is: a place where something will
/// be, drawn as though it were not there yet. The highlight sweeping over it
/// is `surface-subtle`, the ink wash the whole system already hovers with, so
/// it moves paper, card and column by the same amount without a per-theme
/// value.
class Skeleton extends StatefulWidget {
  const Skeleton({
    super.key,
    this.shape = SkeletonShape.text,
    this.width,
    this.height,
  });

  final SkeletonShape shape;

  /// Left null, the bar takes whatever width its parent gives it — which is
  /// the whole line inside a [Column] that stretches, and nothing at all
  /// inside a [Row], where a width is the caller's to state.
  final double? width;

  /// [SkeletonShape.text] and [SkeletonShape.circle] derive theirs and ignore
  /// this.
  final double? height;

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: _kSweep,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;
    // Stopped rather than slowed, where the spinner is slowed. A still spinner
    // reads as a hung app because motion is a spinner's only message; a still
    // skeleton still says everything it has to say.
    final bool still = MediaQuery.maybeDisableAnimationsOf(context) ?? false;

    final Color ground = vars.colorSurfaceSunken;
    // The wash is an alpha of the ink, so it has to be composited against the
    // groove rather than handed to the gradient as-is: a gradient stop is a
    // colour, and a translucent stop over a transparent one is a hole.
    final Color crest = Color.alphaBlend(vars.colorSurfaceSubtle, ground);

    final double? height = switch (widget.shape) {
      // The line box of body copy, so a bar occupies the run the sentence it
      // replaces would have.
      SkeletonShape.text =>
        (vars.bodySmall.fontSize ?? 0) * (vars.bodySmall.height ?? 1),
      SkeletonShape.circle => null,
      SkeletonShape.rect => widget.height,
    };

    final BorderRadius radius = switch (widget.shape) {
      SkeletonShape.text => BorderRadius.circular(vars.radiusTiny),
      SkeletonShape.circle => BorderRadius.circular(vars.radiusFull),
      SkeletonShape.rect => BorderRadius.circular(vars.radiusSmall),
    };

    Widget box = AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        // The band starts off one edge and finishes off the other, which is
        // what a sweep is: an alignment that only crossed the box would fade
        // in and out in place.
        final double shift = _controller.value * 4 - 2;
        return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: radius,
            gradient: still
                ? null
                : LinearGradient(
                    begin: Alignment(shift - 1, 0),
                    end: Alignment(shift + 1, 0),
                    colors: <Color>[ground, crest, ground],
                  ),
            color: still ? ground : null,
          ),
        );
      },
    );

    if (widget.shape == SkeletonShape.circle) {
      // Square from the width alone, so one measurement sizes it.
      box = AspectRatio(aspectRatio: 1, child: box);
    }

    return SizedBox(
      width: widget.width,
      height: height,
      child: box,
    );
  }
}

/// A paragraph's worth of bars.
///
/// The last one stops short because a full-width final line reads as a table
/// rather than as prose, and that ragged edge is most of what makes a block of
/// bars legible as text at all.
class SkeletonText extends StatelessWidget {
  const SkeletonText({super.key, this.lines = 3});

  final int lines;

  /// Three fifths: short enough to read as the end of a paragraph at any
  /// measure, long enough not to read as a heading. A proportion rather than a
  /// length, so there is no step of the scale to compose it out of.
  static const double _lastLine = 0.6;

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      // The leading between two lines of body copy rather than a step of the
      // spacing scale, so a stack of bars occupies the run the paragraph
      // would have.
      spacing: vars.spacing15,
      children: <Widget>[
        for (int index = 0; index < lines; index++)
          if (index == lines - 1)
            FractionallySizedBox(
              alignment: AlignmentDirectional.centerStart,
              widthFactor: _lastLine,
              child: const Skeleton(),
            )
          else
            const Skeleton(),
      ],
    );
  }
}
