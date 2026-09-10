import 'package:flutter/widgets.dart';

import '../generated/theme_variables.dart';
import '../theme/theme.dart';
import 'dialog.dart';

/// The edge a [Drawer] comes in from.
enum DrawerSide { start, end, top, bottom }

/// A sheet pinned to one edge of the view.
///
/// It is the [Dialog]'s sibling, and the choice between them is about where
/// the reader's attention has to go rather than about the screen it is on: a
/// dialog takes the middle of the view and asks a question; a drawer takes a
/// side of it and holds a panel the reader dips into — filters, a detail
/// pane — while what they were reading stays where it was.
///
/// The header, body and footer are properties here rather than the separate
/// widgets a [Dialog] has, because a `DialogHeader` inside a drawer would be
/// the same three rows drawn twice.
class Drawer extends StatelessWidget {
  const Drawer({
    super.key,
    this.side = DrawerSide.end,
    this.size,
    this.title,
    this.description,
    this.footer,
    this.child,
  });

  final DrawerSide side;

  /// Overrides the token width — or height, on a top or bottom drawer.
  final double? size;

  final String? title;

  final String? description;

  /// A row of controls pinned to the far edge, clear of the scrolling body.
  final List<Widget>? footer;

  final Widget? child;

  bool get _horizontal => side == DrawerSide.start || side == DrawerSide.end;

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;
    final double extent = size ?? vars.drawerSize;
    final Radius corner = Radius.circular(vars.frameWindowRadius);

    // It keeps a corner only on the two sides still inside the view. A sheet
    // flush to an edge with all four corners rounded reads as floating just
    // off the screen rather than as attached to it.
    final BorderRadius radius = switch (side) {
      DrawerSide.end => BorderRadius.only(
        topLeft: corner,
        bottomLeft: corner,
      ),
      DrawerSide.start => BorderRadius.only(
        topRight: corner,
        bottomRight: corner,
      ),
      DrawerSide.top => BorderRadius.only(
        bottomLeft: corner,
        bottomRight: corner,
      ),
      DrawerSide.bottom => BorderRadius.only(
        topLeft: corner,
        topRight: corner,
      ),
    };

    final BorderSide edge = BorderSide(
      color: vars.colorBorderStrong,
      width: context.hairlineWidth,
    );
    final Border border = switch (side) {
      DrawerSide.end => Border(left: edge),
      DrawerSide.start => Border(right: edge),
      DrawerSide.top => Border(bottom: edge),
      DrawerSide.bottom => Border(top: edge),
    };

    return Align(
      alignment: switch (side) {
        DrawerSide.end => AlignmentDirectional.centerEnd,
        DrawerSide.start => AlignmentDirectional.centerStart,
        DrawerSide.top => Alignment.topCenter,
        DrawerSide.bottom => Alignment.bottomCenter,
      },
      child: SizedBox(
        width: _horizontal ? extent : double.infinity,
        height: _horizontal ? double.infinity : extent,
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: vars.colorSurfaceOverlay,
            border: border,
            borderRadius: radius,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // The grabber, on the two edges a thumb actually pushes. It is
              // the one mark that says the sheet can be pushed away.
              if (!_horizontal)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: vars.spacing2),
                  child: Center(
                    child: Container(
                      width: vars.spacing9,
                      height: vars.spacing1,
                      decoration: BoxDecoration(
                        color: vars.colorBorderStrong,
                        borderRadius: BorderRadius.circular(vars.radiusFull),
                      ),
                    ),
                  ),
                ),
              // The three rows are the dialog's, at the dialog's own insets,
              // so a drawer and a sheet in the same app are set the same way.
              if (title != null || description != null)
                DialogHeader(title: title ?? '', subtitle: description),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    vertical: vars.spacing4 + vars.spacing05,
                    horizontal: vars.spacing5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    spacing: vars.spacing4,
                    children: [?child],
                  ),
                ),
              ),
              if (footer != null) DialogFooter(children: footer!),
            ],
          ),
        ),
      ),
    );
  }
}

/// Puts a drawer over the window.
///
/// The counterpart of [showDialog], and for the same reason: a sheet has to
/// reach the [Navigator] to cover the window. It arrives from its own edge and
/// leaves the same way — the one transform that says which edge it belongs to.
Future<T?> showDrawer<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  DrawerSide side = DrawerSide.end,
  bool dismissible = true,
}) {
  final ThemeData theme = Theme.of(context);
  final bool rtl = Directionality.of(context) == TextDirection.rtl;

  final Offset from = switch (side) {
    DrawerSide.end => Offset(rtl ? -1 : 1, 0),
    DrawerSide.start => Offset(rtl ? 1 : -1, 0),
    DrawerSide.top => const Offset(0, -1),
    DrawerSide.bottom => const Offset(0, 1),
  };

  return Navigator.of(context, rootNavigator: true).push<T>(
    RawDialogRoute<T>(
      barrierDismissible: dismissible,
      barrierLabel: 'Dismiss',
      barrierColor: const Color(0x00000000),
      transitionDuration: theme.vars.motionDuration,
      pageBuilder: (context, animation, secondaryAnimation) => Theme(
        data: theme,
        child: Builder(
          builder: (context) => _DrawerScrim(
            onDismiss: dismissible ? () => Navigator.of(context).pop() : null,
            child: builder(context),
          ),
        ),
      ),
      transitionBuilder: (context, animation, secondary, child) {
        final CurvedAnimation curved = CurvedAnimation(
          parent: animation,
          curve: theme.vars.motionEasing,
        );
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: from,
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    ),
  );
}

/// The dim behind a drawer. The dialog's own, minus the padding: a drawer is
/// flush to its edge rather than centred in a margin.
class _DrawerScrim extends StatelessWidget {
  const _DrawerScrim({this.onDismiss, required this.child});

  final VoidCallback? onDismiss;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeVariables vars = Theme.of(context).vars;

    return GestureDetector(
      onTap: onDismiss,
      behavior: HitTestBehavior.opaque,
      child: ColoredBox(
        color: vars.colorContent.withValues(alpha: vars.dialogScrimAlpha),
        child: GestureDetector(onTap: () {}, child: child),
      ),
    );
  }
}
