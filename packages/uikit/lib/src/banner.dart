import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:uikit/src/gapped_column.dart';
import 'package:uikit/src/gapped_row.dart';

/// A banner widget.
class Banner extends StatefulWidget {
  const Banner({
    super.key,
    this.icon,
    this.title,
    this.message,
    this.actions,
  });

  final Widget? icon;

  /// An optional title of the action sheet. When the [message] is non-null,
  /// the font of the [title] is bold.
  ///
  /// Typically a [Text] widget.
  final Widget? title;

  /// An optional descriptive message that provides more details about the
  /// reason for the banner.
  ///
  /// Typically a [Text] widget.
  final Widget? message;

  /// The set of actions that are displayed for the user to select.
  ///
  /// This must be a list of [CupertinoActionSheetAction] widgets.
  final List<Widget>? actions;

  @override
  State<Banner> createState() => _BannerState();
}

class _BannerState extends State<Banner> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      foregroundDecoration: BoxDecoration(
        border: Border.all(),
      ),
      decoration: const BoxDecoration(
        color: Colors.orange,
      ),
      child: GappedRow(
        gap: 8,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.icon != null)
            IconTheme(
              data: const IconThemeData(
                size: 18,
              ),
              child: widget.icon!,
            ),
          Expanded(
            child: GappedColumn(
              gap: 4,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.title != null)
                  DefaultTextStyle(
                    style: themeData.typography.base.copyWith(
                      // color: effectiveForegroundColor,
                      fontWeight: FontWeight.w600,
                    ),
                    child: widget.title!,
                  ),
                if (widget.message != null)
                  DefaultTextStyle(
                    style: themeData.typography.base.copyWith(
                      // color: effectiveForegroundColor,
                    ),
                    child: widget.message!,
                  ),
                if ((widget.actions ?? []).isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: GappedRow(gap: 8, children: widget.actions!),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
