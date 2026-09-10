import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../generated/theme_variables.dart';
import '../theme/theme.dart';
import 'menu.dart';

/// The menu a right-click opens, over the thing that was clicked.
///
/// It is the same menu a button opens — the panel and the rows are [MenuPanel]
/// and [MenuRow], so this shares the drawing rather than resembling it. What
/// is its own is where it opens: at the pointer rather than against a
/// trigger's edge, and on a long press as well as a secondary click, so it is
/// reachable on a touch screen.
///
/// Every affordance in a context menu must also be reachable somewhere a
/// pointer can see: a right-click is a shortcut, never the only door.
class ContextMenu extends StatefulWidget {
  const ContextMenu({super.key, required this.items, required this.child});

  final List<MenuItem> items;

  /// The region that opens the menu. It is rendered as given — the listener is
  /// on it, not a wrapper around it — so a row, a card or a canvas keeps its
  /// own layout.
  final Widget child;

  @override
  State<ContextMenu> createState() => _ContextMenuState();
}

class _ContextMenuState extends State<ContextMenu> {
  final OverlayPortalController _controller = OverlayPortalController();
  Offset _at = Offset.zero;
  bool _open = false;

  void _openAt(Offset global) {
    setState(() {
      _at = global;
      _open = true;
    });
    _controller.show();
  }

  void _close() {
    if (!_open) return;
    setState(() => _open = false);
    _controller.hide();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _controller,
      overlayChildBuilder: (context) => _ContextMenuOverlay(
        at: _at,
        items: widget.items,
        onDismiss: _close,
      ),
      child: Listener(
        onPointerDown: (event) {
          if (event.buttons & kSecondaryButton != 0) _openAt(event.position);
        },
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onLongPressStart: (details) => _openAt(details.globalPosition),
          child: widget.child,
        ),
      ),
    );
  }
}

/// The panel, placed at the pointer and nudged back inside the window.
///
/// There is no trigger to anchor to, so the collision handling every other
/// popup gets from its follower has to be done here: a menu opened near the
/// right edge would otherwise hang off it.
class _ContextMenuOverlay extends StatelessWidget {
  const _ContextMenuOverlay({
    required this.at,
    required this.items,
    required this.onDismiss,
  });

  final Offset at;
  final List<MenuItem> items;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;

    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onDismiss,
          ),
        ),
        CustomSingleChildLayout(
          delegate: _AtPointer(at: at, margin: vars.spacing2),
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
              child: FocusScope(
                autofocus: true,
                child: MenuPanel(
                  children: [
                    for (final MenuItem item in items)
                      MenuRow(
                        item: item,
                        onSelect: () {
                          item.onSelect?.call();
                          onDismiss();
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _AtPointer extends SingleChildLayoutDelegate {
  const _AtPointer({required this.at, required this.margin});

  final Offset at;
  final double margin;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(constraints.biggest);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final double x = at.dx + childSize.width + margin > size.width
        ? at.dx - childSize.width
        : at.dx;
    final double y = at.dy + childSize.height + margin > size.height
        ? at.dy - childSize.height
        : at.dy;
    return Offset(
      x.clamp(margin, (size.width - childSize.width).clamp(margin, size.width)),
      y.clamp(
        margin,
        (size.height - childSize.height).clamp(margin, size.height),
      ),
    );
  }

  @override
  bool shouldRelayout(_AtPointer oldDelegate) => oldDelegate.at != at;
}
