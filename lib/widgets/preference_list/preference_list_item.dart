import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PreferenceListItem extends StatelessWidget {
  final EdgeInsets? padding;
  final Widget? icon;
  final Widget? title;
  final Widget? summary;
  final Widget? detailText;
  final Widget? accessoryView;
  final Widget? bottomView;
  final bool disabled;
  final VoidCallback? onTap;

  const PreferenceListItem({
    Key? key,
    this.padding,
    this.icon,
    this.title,
    this.summary,
    this.detailText,
    this.accessoryView,
    this.bottomView,
    this.disabled = false,
    this.onTap,
  }) : super(key: key);

  _onTap() {
    if (onTap != null) {
      onTap!();
    }
  }

  Widget buildDetailText(BuildContext context) {
    if (detailText != null) {
      return DefaultTextStyle(
        style: Theme.of(context).textTheme.caption!,
        child: detailText!,
      );
    } else {
      return Container();
    }
  }

  Widget buildAccessoryView(BuildContext context) {
    if (accessoryView != null) {
      return accessoryView!;
    } else {
      return Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Icon(
          FluentIcons.chevron_right_20_regular,
          size: 18,
          color: Theme.of(context).textTheme.caption!.color,
        ),
      );
    }
  }

  Widget buildBottomView(BuildContext context) {
    return bottomView ?? Container();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).canvasColor,
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: disabled ? null : _onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: 48,
              ),
              padding: padding ?? EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Row(
                children: [
                  if (icon != null)
                    Container(
                      child: icon,
                      margin: EdgeInsets.only(right: 10),
                    ),
                  if (title != null || summary != null)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (title != null)
                            DefaultTextStyle(
                              style: Theme.of(context).textTheme.bodyText2!,
                              child: title!,
                            ),
                          if (summary != null)
                            DefaultTextStyle(
                              style: Theme.of(context).textTheme.caption!,
                              child: Padding(
                                padding: EdgeInsets.only(top: 4, bottom: 4),
                                child: summary,
                              ),
                            ),
                        ],
                      ),
                    ),
                  buildDetailText(context),
                  buildAccessoryView(context),
                ],
              ),
            ),
            buildBottomView(context),
          ],
        ),
      ),
    );
  }
}

class PreferenceListRadioItem<T> extends PreferenceListItem {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;

  const PreferenceListRadioItem({
    Key? key,
    Widget? icon,
    Widget? title,
    Widget? summary,
    Widget? detailText,
    Widget? accessoryView,
    VoidCallback? onTap,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(
          key: key,
          icon: icon,
          title: title,
          summary: summary,
          detailText: detailText,
          accessoryView: accessoryView,
          onTap: onTap,
        );

  @override
  void _onTap() {
    onChanged(value);
    super._onTap();
  }

  @override
  Widget buildAccessoryView(BuildContext context) {
    if (value != null && value == groupValue) {
      return Container(
        child: Icon(
          FluentIcons.checkmark_circle_20_filled,
          size: 22,
          color: Theme.of(context).primaryColor,
        ),
      );
    }
    return Container();
  }
}

class PreferenceListSwitchItem extends PreferenceListItem {
  final bool value;
  final ValueChanged<bool> onChanged;

  const PreferenceListSwitchItem({
    Key? key,
    Widget? icon,
    Widget? title,
    Widget? summary,
    Widget? detailText,
    Widget? accessoryView,
    VoidCallback? onTap,
    required this.value,
    required this.onChanged,
  }) : super(
          key: key,
          icon: icon,
          title: title,
          summary: summary,
          detailText: detailText,
          accessoryView: accessoryView,
          onTap: onTap,
        );

  @override
  void _onTap() {
    if (onTap == null) {
      onChanged(!value);
    }
    super._onTap();
  }

  @override
  Widget buildAccessoryView(BuildContext context) {
    return Container(
      height: 22,
      width: 34,
      child: Transform.scale(
        scale: 0.68,
        child: CupertinoSwitch(
          value: value,
          onChanged: onChanged,
          activeColor: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

class PreferenceListTextFieldItem extends PreferenceListItem {
  final TextEditingController? controller;
  final String? placeholder;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;

  PreferenceListTextFieldItem({
    Key? key,
    Widget? icon,
    Widget? title,
    Widget? summary,
    Widget? accessoryView,
    VoidCallback? onTap,
    this.controller,
    this.placeholder,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
  }) : super(
          key: key,
          icon: icon,
          title: title,
          summary: summary,
          accessoryView: accessoryView,
          onTap: onTap,
        );

  @override
  bool get disabled => true;

  @override
  Widget buildDetailText(BuildContext context) {
    return Expanded(
      child: CupertinoTextField(
        controller: this.controller,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(),
        placeholder: placeholder,
        style: TextStyle(
          fontSize: 14,
        ),
        onChanged: onChanged,
        onEditingComplete: onEditingComplete,
        onSubmitted: onSubmitted,
      ),
    );
  }
}
