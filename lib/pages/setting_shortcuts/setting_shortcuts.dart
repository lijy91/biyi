import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

import '../../../includes.dart';

class SettingShortcutsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingShortcutsPageState();
}

class _SettingShortcutsPageState extends State<SettingShortcutsPage> {
  Config _config = sharedConfigManager.getConfig();

  @override
  void initState() {
    sharedConfigManager.addListener(_configListen);

    super.initState();
  }

  @override
  void dispose() {
    sharedConfigManager.removeListener(_configListen);
    super.dispose();
  }

  void _configListen() {
    _config = sharedConfigManager.getConfig();
    setState(() {});
  }

  Widget _buildBody(BuildContext context) {
    return LocalDbBuilder(builder: (context, dbData) {
      return PreferenceList(
        children: [
          PreferenceListSection(
            children: [
              PreferenceListItem(
                title: Text('显示/隐藏'),
                detailText: Text(
                  _config.shortcutShowOrHide.toString(),
                ),
                onTap: () {},
              ),
            ],
          ),
          PreferenceListSection(
            title: Text('屏幕取词'),
            children: [
              PreferenceListItem(
                title: Text('选中文字'),
                detailText: Text(
                  _config.shortcutExtractFromScreenSelection.toString(),
                ),
                onTap: () {},
              ),
              PreferenceListItem(
                title: Text('截取区域'),
                detailText: Text(
                  _config.shortcutExtractFromScreenCapture.toString(),
                ),
                onTap: () {},
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget _build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('快捷键'),
      ),
      body: _buildBody(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }
}
