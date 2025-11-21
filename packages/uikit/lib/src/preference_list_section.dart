import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Denotes what type of the list section a [CupertinoListSection] is.
///
/// This is for internal use only.
enum PreferenceListSectionType {
  /// A basic form of [CupertinoListSection].
  base,

  /// An inset-grouped style of [CupertinoListSection].
  insetGrouped,
}

class PreferenceListSection extends StatelessWidget {
  const PreferenceListSection({
    super.key,
    this.type = PreferenceListSectionType.base,
    this.header,
    this.footer,
    this.children,
  });

  /// Creates a new inset-grouped list section.
  ///
  /// The [header] and [footer] arguments must not be null.
  ///
  /// The [children] argument must not be null.
  const PreferenceListSection.insetGrouped({
    super.key,
    this.type = PreferenceListSectionType.insetGrouped,
    this.header,
    this.footer,
    this.children,
  });

  /// The type of list section, either base or inset grouped.
  ///
  /// This member is public for testing purposes only and cannot be set
  /// manually. Instead, use a corresponding constructors.
  @visibleForTesting
  final PreferenceListSectionType type;

  /// Sets the form section header. The section header lies above the [children]
  /// rows. Usually a [Text] widget.
  final Widget? header;

  /// Sets the form section footer. The section footer lies below the [children]
  /// rows. Usually a [Text] widget.
  final Widget? footer;

  /// The list of rows in the section. Usually a list of [ListTile]s.
  ///
  /// This takes a list, as opposed to a more efficient builder function that
  /// lazy builds, because such lists are intended to be short in row count.
  /// It is recommended that only [ListTile] widget be included in the
  /// [children] list in order to retain the iOS look.
  final List<Widget>? children;

  Widget _buildChildren(BuildContext context) {
    final theme = Theme.of(context);
    if (type == PreferenceListSectionType.insetGrouped) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.colorScheme.card,
          borderRadius: theme.borderRadiusXl,
          border: Border.all(color: theme.colorScheme.border),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.foreground.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        margin: const EdgeInsets.only(top: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...children!,
          ],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: theme.scaling * 8,
      children: children!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   color: Colors.gray.shade300,
      // ),
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20, right: 20),
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (header != null) ...[
            Container(
              // decoration: BoxDecoration(
              //   color: Colors.gray.shade400,
              // ),
              constraints: const BoxConstraints(
                minHeight: 36,
              ),
              padding: EdgeInsets.zero,
              child: Align(
                alignment: Alignment.centerLeft,
                child: header!.large().medium(),
              ),
            ),
            if (type == PreferenceListSectionType.base)
              const Padding(
                padding: EdgeInsets.only(top: 0, bottom: 8),
                child: Divider(),
              ),
          ],
          if (children != null) _buildChildren(context),
          if (footer != null) footer!,
        ],
      ),
    );
  }
}

class ListSection extends PreferenceListSection {
  const ListSection({
    super.key,
    super.type,
    super.header,
    super.footer,
    super.children,
    bool hasLeading = true,
  });
}
