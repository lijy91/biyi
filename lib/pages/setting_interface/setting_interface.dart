import 'package:flutter/material.dart';

import '../../../includes.dart';

class SettingInterfacePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingInterfacePageState();
}

class _SettingInterfacePageState extends State<SettingInterfacePage> {
  List<double> _maxWindowHeightOptions = [700, 800, 900, 1000];

  bool _showTrayIcon = false;
  double _maxWindowHeight = 0;

  String t(String key, {List<String> args}) {
    return 'page_setting_interface.$key'.tr(args: args);
  }

  @override
  void initState() {
    _showTrayIcon = sharedConfig.showTrayIcon;
    _maxWindowHeight = sharedConfig.maxWindowHeight;
    super.initState();
  }

  void _handleShowTrayIconChanged(newValue) {
    _showTrayIcon = newValue;
    sharedConfigManager.setShowTrayIcon(newValue);
  }

  Widget _buildBody(BuildContext context) {
    return LocalDbBuilder(builder: (context, dbData) {
      return PreferenceList(
        children: [
          PreferenceListSection(
            title: Text(t('pref_section_title_tray_icon')),
            children: [
              PreferenceListSwitchItem(
                title: Text(t('pref_item_title_show_tray_icon')),
                value: _showTrayIcon,
                onChanged: _handleShowTrayIconChanged,
              ),
            ],
          ),
          PreferenceListSection(
            title: Text(t('pref_section_title_max_window_height')),
            children: [
              for (var option in _maxWindowHeightOptions)
                PreferenceListRadioItem<double>(
                  title: Text('${option.toInt()}'),
                  value: option,
                  groupValue: _maxWindowHeight,
                  onChanged: (newValue) {
                    _maxWindowHeight = newValue;
                    sharedConfigManager.setMaxWindowHeight(newValue);
                    setState(() {});
                  },
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
        title: Text(t('title')),
      ),
      body: _buildBody(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }
}
