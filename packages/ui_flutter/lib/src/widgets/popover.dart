import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../generated/theme_variables.dart';
import '../theme/theme.dart';

/// Which side of the trigger the panel opens on.
enum PopoverSide { top, bottom, left, right }

/// Which edge of the trigger the panel lines up with.
enum PopoverAlign { start, center, end }

/// What the trigger builder is handed.
@immutable
class PopoverTriggerState {
  const PopoverTriggerState({required this.open, required this.toggle});

  final bool open;
  final VoidCallback toggle;
}

/// The floating sheet a popover and a preview card both wear.
///
/// It is the [MenuPanel]'s materials — the overlay surface, the strong
/// hairline, the deep shadow — padded for prose rather than for rows: a sheet
/// built for 26px rows pads by a single step, and a paragraph in that would
/// sit on its own edge.
///
/// The width is deliberately not set. A menu has a minimum because a menu
/// narrower than its trigger reads as broken; a popover is as wide as what is
/// in it, and a caller who knows better passes one.
class PopoverPanel extends StatelessWidget {
  const PopoverPanel({
    super.key,
    this.title,
    this.description,
    this.width,
    this.maxWidth,
    required this.child,
  });

  final Widget? title;
  final Widget? description;
  final double? width;
  final double? maxWidth;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
      child: Container(
        width: width,
        padding: EdgeInsets.all(vars.spacing4 + vars.spacing05),
        decoration: BoxDecoration(
          color: vars.colorSurfaceOverlay,
          border: Border.all(
            color: vars.colorBorderStrong,
            width: context.hairlineWidth,
          ),
          borderRadius: BorderRadius.circular(vars.radiusLarge),
          boxShadow: vars.shadowLg,
        ),
        child: DefaultTextStyle.merge(
          style: vars.bodySmall.copyWith(color: vars.colorContent),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                DefaultTextStyle.merge(
                  style: vars.labelLarge.copyWith(color: vars.colorContent),
                  child: title!,
                ),
              if (description != null)
                Padding(
                  padding: EdgeInsets.only(top: vars.spacing1),
                  child: DefaultTextStyle.merge(
                    style: vars.bodySmall.copyWith(
                      color: vars.colorContentSecondary,
                    ),
                    child: description!,
                  ),
                ),
              // The run between the head and whatever the panel is actually
              // for. It is a gap above the body rather than on the panel, so a
              // popover that is only a form has no leading space to trim.
              if (title != null || description != null)
                SizedBox(height: vars.spacing3),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

/// A panel of anything, anchored to what opened it.
///
/// It is the sibling of [Menu] rather than of [Dialog]: it wears the same kind
/// of floating sheet and is positioned against its trigger, but it holds
/// content rather than rows. Reach for a dialog instead when the reader has to
/// finish before doing anything else — a popover closes on an outside press,
/// which makes it the wrong home for something half-typed.
class Popover extends StatefulWidget {
  const Popover({
    super.key,
    required this.trigger,
    this.title,
    this.description,
    this.child,
    this.side = PopoverSide.bottom,
    this.align = PopoverAlign.center,
    this.width,
  });

  /// Renders the trigger; receives the open state and a toggle handler.
  final Widget Function(BuildContext context, PopoverTriggerState state)
  trigger;

  /// Names the panel to a screen reader as well as heading it.
  final Widget? title;

  /// A line under the title, and the panel's accessible description.
  final Widget? description;

  final Widget? child;

  final PopoverSide side;

  final PopoverAlign align;

  /// Overrides the panel's own width, which is otherwise its content's.
  final double? width;

  @override
  State<Popover> createState() => _PopoverState();
}

class _PopoverState extends State<Popover> {
  final OverlayPortalController _controller = OverlayPortalController();
  final LayerLink _link = LayerLink();
  bool _open = false;

  void _toggle() => _open ? _close() : _openPanel();

  void _openPanel() {
    setState(() => _open = true);
    _controller.show();
  }

  void _close() {
    if (!_open) return;
    setState(() => _open = false);
    _controller.hide();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;

    return CompositedTransformTarget(
      link: _link,
      child: OverlayPortal(
        controller: _controller,
        overlayChildBuilder: (context) => PopoverOverlay(
          link: _link,
          side: widget.side,
          align: widget.align,
          gap: vars.spacing1,
          onDismiss: _close,
          child: PopoverPanel(
            title: widget.title,
            description: widget.description,
            width: widget.width,
            child: widget.child ?? const SizedBox.shrink(),
          ),
        ),
        child: widget.trigger(
          context,
          PopoverTriggerState(open: _open, toggle: _toggle),
        ),
      ),
    );
  }
}

/// The anchored layer every content popup shares: the outside press that
/// dismisses, the Escape that dismisses, and the gap between the panel and its
/// trigger — which is padding on the follower rather than a number passed in,
/// so it stays a token.
class PopoverOverlay extends StatelessWidget {
  const PopoverOverlay({
    super.key,
    required this.link,
    required this.side,
    required this.align,
    required this.gap,
    required this.onDismiss,
    this.dismissOnOutsidePress = true,
    required this.child,
  });

  final LayerLink link;
  final PopoverSide side;
  final PopoverAlign align;
  final double gap;
  final VoidCallback onDismiss;
  final bool dismissOnOutsidePress;
  final Widget child;

  (Alignment target, Alignment follower, Offset offset) get _anchors {
    final double cross = switch (align) {
      PopoverAlign.start => -1,
      PopoverAlign.center => 0,
      PopoverAlign.end => 1,
    };

    return switch (side) {
      PopoverSide.bottom => (
        Alignment(cross, 1),
        Alignment(cross, -1),
        Offset(0, gap),
      ),
      PopoverSide.top => (
        Alignment(cross, -1),
        Alignment(cross, 1),
        Offset(0, -gap),
      ),
      PopoverSide.left => (
        Alignment(-1, cross),
        Alignment(1, cross),
        Offset(-gap, 0),
      ),
      PopoverSide.right => (
        Alignment(1, cross),
        Alignment(-1, cross),
        Offset(gap, 0),
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final (Alignment target, Alignment follower, Offset offset) = _anchors;

    return Stack(
      children: [
        if (dismissOnOutsidePress)
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onDismiss,
            ),
          ),
        CompositedTransformFollower(
          link: link,
          targetAnchor: target,
          followerAnchor: follower,
          offset: offset,
          child: Align(
            alignment: follower,
            child: Shortcuts(
              shortcuts: const {
                SingleActivator(LogicalKeyboardKey.escape): DismissIntent(),
              },
              child: Actions(
                actions: {
                  DismissIntent: CallbackAction<DismissIntent>(
                    onInvoke: (_) {
                      onDismiss();
                      return null;
                    },
                  ),
                },
                child: FocusScope(autofocus: true, child: child),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
