import 'dart:async';

import 'package:flutter/widgets.dart';

import '../generated/theme_variables.dart';
import '../theme/theme.dart';
import 'popover.dart';

/// What is behind a link, shown without following it — a repository, a person,
/// an issue.
///
/// It is a [Tooltip] that holds a card rather than a label, and the difference
/// is what may go in it: a tooltip must carry nothing a reader needs, because
/// a pointer never reaches it; a preview card stays open while the pointer
/// travels, so it can hold a link of its own. It is never the only way to
/// reach what it shows.
///
/// The sheet is the [PopoverPanel] — a preview card is a popover the pointer
/// opens, so a second drawing of it could only drift. What is its own is a
/// ceiling on the width: a popover is as wide as what a caller put in it; this
/// is filled from whatever it previews, so it needs a width it cannot exceed
/// no matter what comes back.
class PreviewCard extends StatefulWidget {
  const PreviewCard({
    super.key,
    required this.trigger,
    required this.child,
    this.side = PopoverSide.bottom,
    this.align = PopoverAlign.center,
    this.delay = const Duration(milliseconds: 600),
    this.closeDelay = const Duration(milliseconds: 300),
    this.width,
  });

  /// What it previews — a link, usually.
  final Widget trigger;

  final Widget child;

  final PopoverSide side;

  final PopoverAlign align;

  /// How long the pointer has to rest before it opens.
  final Duration delay;

  /// How long it stays after the pointer leaves. It is not zero on purpose:
  /// the card has to survive the pointer travelling to it, or nothing in it
  /// can be reached.
  final Duration closeDelay;

  final double? width;

  @override
  State<PreviewCard> createState() => _PreviewCardState();
}

class _PreviewCardState extends State<PreviewCard> {
  final OverlayPortalController _controller = OverlayPortalController();
  final LayerLink _link = LayerLink();
  Timer? _timer;
  bool _open = false;
  bool _overTrigger = false;
  bool _overCard = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _schedule({required bool open}) {
    _timer?.cancel();
    _timer = Timer(open ? widget.delay : widget.closeDelay, () {
      if (!mounted) return;
      if (open == _open) return;
      // Re-read at the moment the timer fires: the pointer may have crossed
      // the gap into the card while it was running.
      if (!open && (_overTrigger || _overCard)) return;
      setState(() => _open = open);
      open ? _controller.show() : _controller.hide();
    });
  }

  void _close() {
    _timer?.cancel();
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
          // The pointer opened it, so the pointer closes it: a full-screen
          // press-catcher would swallow the click meant for whatever is under
          // the card.
          dismissOnOutsidePress: false,
          child: MouseRegion(
            onEnter: (_) {
              _overCard = true;
              _timer?.cancel();
            },
            onExit: (_) {
              _overCard = false;
              _schedule(open: false);
            },
            child: PopoverPanel(
              maxWidth: widget.width ?? vars.previewCardWidth,
              child: widget.child,
            ),
          ),
        ),
        child: MouseRegion(
          onEnter: (_) {
            _overTrigger = true;
            _schedule(open: true);
          },
          onExit: (_) {
            _overTrigger = false;
            _schedule(open: false);
          },
          child: Focus(
            onFocusChange: (focused) {
              _overTrigger = focused;
              _schedule(open: focused);
            },
            child: widget.trigger,
          ),
        ),
      ),
    );
  }
}
