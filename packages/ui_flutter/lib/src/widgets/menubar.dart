import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../generated/theme_variables.dart';
import '../theme/theme.dart';
import 'menu.dart';
import 'popover.dart';
import 'pressable.dart';

/// One name on the bar, and the rows it opens.
@immutable
class MenubarMenu {
  const MenubarMenu({
    required this.label,
    required this.items,
    this.enabled = true,
  });

  /// The name on the bar — File, Edit, View.
  final String label;

  final List<MenuItem> items;

  final bool enabled;
}

/// The application menu bar: several menus that behave as one.
///
/// That is the whole reason it exists rather than a row of [Menu]s. Once one
/// of them is open, moving the pointer along the bar opens the next without a
/// second click, and the arrow keys walk the bar as well as the rows — the
/// behaviour every desktop menu bar has and none of them documents.
///
/// Each panel is a [MenuPanel] of [MenuRow]s, so the drawing is the same
/// everywhere; the bar adds only its triggers.
class Menubar extends StatefulWidget {
  const Menubar({super.key, required this.menus});

  final List<MenubarMenu> menus;

  @override
  State<Menubar> createState() => _MenubarState();
}

class _MenubarState extends State<Menubar> {
  final OverlayPortalController _controller = OverlayPortalController();
  final Map<int, LayerLink> _links = {};
  int? _open;

  LayerLink _linkFor(int index) => _links.putIfAbsent(index, LayerLink.new);

  void _openAt(int index) {
    if (!widget.menus[index].enabled) return;
    setState(() => _open = index);
    _controller.show();
  }

  void _close() {
    if (_open == null) return;
    setState(() => _open = null);
    _controller.hide();
  }

  void _step(int delta) {
    if (_open == null) return;
    final int count = widget.menus.length;
    for (int hop = 1; hop <= count; hop += 1) {
      final int next = (_open! + delta * hop) % count;
      if (widget.menus[(next + count) % count].enabled) {
        setState(() => _open = (next + count) % count);
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;
    final int? open = _open;

    return OverlayPortal(
      controller: _controller,
      overlayChildBuilder: (context) {
        if (open == null) return const SizedBox.shrink();
        return PopoverOverlay(
          link: _linkFor(open),
          side: PopoverSide.bottom,
          align: PopoverAlign.start,
          gap: vars.spacing1,
          onDismiss: _close,
          child: Shortcuts(
            shortcuts: const {
              SingleActivator(LogicalKeyboardKey.arrowRight): _StepIntent(1),
              SingleActivator(LogicalKeyboardKey.arrowLeft): _StepIntent(-1),
            },
            child: Actions(
              actions: <Type, Action<Intent>>{
                _StepIntent: CallbackAction<_StepIntent>(
                  onInvoke: (intent) {
                    _step(intent.delta);
                    return null;
                  },
                ),
              },
              child: MenuPanel(
                children: [
                  for (final MenuItem item in widget.menus[open].items)
                    MenuRow(
                      item: item,
                      onSelect: () {
                        item.onSelect?.call();
                        _close();
                      },
                    ),
                ],
              ),
            ),
          ),
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: vars.spacing05,
        children: [
          for (int index = 0; index < widget.menus.length; index += 1)
            CompositedTransformTarget(
              link: _linkFor(index),
              child: _Trigger(
                menu: widget.menus[index],
                open: open == index,
                onPressed: () => open == index ? _close() : _openAt(index),
                // Once one is open the bar is armed: crossing another name
                // opens it, which is what makes this a bar rather than a row
                // of separate menus.
                onHover: open == null || open == index
                    ? null
                    : () => _openAt(index),
              ),
            ),
        ],
      ),
    );
  }
}

class _StepIntent extends Intent {
  const _StepIntent(this.delta);

  final int delta;
}

/// A name on the bar. It is chrome rather than a control, so it has no box at
/// rest: the name is the affordance, and the wash arrives only under the
/// pointer or while its own menu is open. An open trigger keeps the wash — a
/// bar where the open menu's name looked idle would leave the panel belonging
/// to nothing.
class _Trigger extends StatelessWidget {
  const _Trigger({
    required this.menu,
    required this.open,
    required this.onPressed,
    required this.onHover,
  });

  final MenubarMenu menu;
  final bool open;
  final VoidCallback onPressed;
  final VoidCallback? onHover;

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;
    final BorderRadius radius = BorderRadius.circular(vars.radiusSmall);

    return Pressable(
      onPressed: menu.enabled ? onPressed : null,
      enabled: menu.enabled,
      borderRadius: radius,
      selected: open,
      cursor: SystemMouseCursors.basic,
      onHover: (hovered) {
        if (hovered) onHover?.call();
      },
      builder: (context, states) {
        final bool washed =
            menu.enabled && (open || states.contains(WidgetState.hovered));

        return AnimatedContainer(
          duration: vars.motionDuration,
          curve: vars.motionEasing,
          height: vars.controlSmallSize,
          padding: EdgeInsets.symmetric(horizontal: vars.spacing2),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: washed ? vars.colorSurfaceSubtle : null,
            borderRadius: radius,
          ),
          child: Text(
            menu.label,
            style: vars.controlSmallContent.copyWith(
              height: 1,
              color: menu.enabled
                  ? vars.colorContent
                  : vars.controlColorNormalContent.disabledColor!,
            ),
          ),
        );
      },
    );
  }
}
