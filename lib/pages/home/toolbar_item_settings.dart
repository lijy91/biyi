import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

import '../../includes.dart';

class ToolbarItemSettings extends StatefulWidget {
  final VoidCallback onSettingsPageDismiss;

  const ToolbarItemSettings({
    Key key,
    this.onSettingsPageDismiss,
  }) : super(key: key);

  @override
  _ToolbarItemSettingsState createState() => _ToolbarItemSettingsState();
}

class _ToolbarItemSettingsState extends State<ToolbarItemSettings> {
  void _handleDismiss() async {
    await Future.delayed(Duration(milliseconds: 100));
    widget.onSettingsPageDismiss();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CustomButton(
        padding: EdgeInsets.zero,
        borderRadius: BorderRadius.zero,
        child: Icon(
          IcoMoonIcons.gear_fill,
          size: 16,
          color: Theme.of(context).iconTheme.color,
        ),
        onPressed: () async {
          Future<void> future = showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(8),
              ),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            builder: (ctx) {
              return Container(
                height: 600,
                child: AppNavigator(
                  home: SettingsPage(
                    onDismiss: () {
                      Navigator.of(ctx).pop();
                      _handleDismiss();
                    },
                  ),
                ),
              );
            },
          );
          future.whenComplete(() => _handleDismiss());

          if (kIsLinux || kIsMacOS || kIsWindows) {
            await Future.delayed(Duration(milliseconds: 120));
            Size size = await windowManager.getSize();
            await windowManager.setSize(Size(size.width, 680.0));
          }
        },
      ),
    );
  }
}
