import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

import '../../includes.dart';
import '../custom_alert_dialog/custom_alert_dialog.dart';

class RecordHotKeyDialog extends StatefulWidget {
  final ValueChanged<HotKey> onHotKeyRecorded;

  const RecordHotKeyDialog({
    Key key,
    this.onHotKeyRecorded,
  }) : super(key: key);

  @override
  _RecordHotKeyDialogState createState() => _RecordHotKeyDialogState();
}

class _RecordHotKeyDialogState extends State<RecordHotKeyDialog> {
  HotKey _hotKey = HotKey(null);

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: Text('widget_record_shortcut_dialog.title'.tr()),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Container(
              width: 100,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: BorderRadius.circular(2),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  HotKeyRecorder(
                    onHotKeyRecorded: (hotKey) {
                      _hotKey = hotKey;
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        CustomDialogAction(
          child: Text('cancel'.tr()),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        CustomDialogAction(
          child: Text('ok'.tr()),
          onPressed: !_hotKey.isSetted
              ? null
              : () {
                  widget.onHotKeyRecorded(_hotKey);
                  Navigator.of(context).pop();
                },
        ),
      ],
    );
  }
}
