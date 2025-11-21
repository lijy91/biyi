import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class PreferenceListItem extends StatelessWidget {
  const PreferenceListItem({
    super.key,
    required this.title,
    this.subtitle,
    this.additionalInfo,
    this.leading,
    this.trailing,
    this.onTap,
  });

  final Widget? title;
  final Widget? subtitle;
  final Widget? additionalInfo;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // decoration: BoxDecoration(
        //   color: Colors.gray.shade400,
        // ),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
        constraints: BoxConstraints(
          minHeight: subtitle != null ? theme.scaling * 52 : theme.scaling * 32,
        ),
        child: Label(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (leading != null) leading!,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 4,
                  children: [
                    if (title != null) title!.base(),
                    if (subtitle != null) subtitle!.small().muted(),
                  ],
                ),
              ),
              if (additionalInfo != null) additionalInfo!,
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}

class ListTile extends PreferenceListItem {
  const ListTile({
    super.key,
    required super.title,
    super.subtitle,
    super.additionalInfo,
    super.leading,
    super.trailing,
    super.onTap,
  });
}

class RadioListTile<T> extends StatelessWidget {
  const RadioListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.additionalInfo,
    this.leading,
    this.trailing,
    this.onTap,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.useCheckmarkStyle = false,
  });

  final Widget? title;
  final Widget? subtitle;
  final Widget? additionalInfo;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final T value;
  final T? groupValue;
  final ValueChanged<T> onChanged;
  final bool useCheckmarkStyle;

  @override
  Widget build(BuildContext context) {
    bool isChecked = value == groupValue;
    return PreferenceListItem(
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      onTap: () {
        onTap?.call();
        onChanged(value);
      },
      additionalInfo: useCheckmarkStyle
          ? isChecked
                ? const Icon(FluentIcons.checkmark_circle_20_filled)
                : null
          : Radio(value: isChecked),
    );
  }
}

class SwitchListTile extends StatelessWidget {
  const SwitchListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.additionalInfo,
    this.leading,
    this.trailing,
    this.onTap,
    required this.value,
    required this.onChanged,
  });

  final Widget? title;
  final Widget? subtitle;
  final Widget? additionalInfo;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return PreferenceListItem(
      title: title,
      subtitle: subtitle,
      leading: leading,
      trailing: trailing,
      onTap: () {
        onTap?.call();
        onChanged(value);
      },
      additionalInfo: Switch(
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}

class ListTileChevron extends StatelessWidget {
  /// Creates a typical widget used to denote that a `ListTile` is a
  /// button with action.
  const ListTileChevron({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Icon(
      FluentIcons.chevron_right_20_regular,
      size: 18.0,
      color: themeData.colorScheme.border,
    );
  }
}
