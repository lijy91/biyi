import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../includes.dart';

class SettingInterfacePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingInterfacePageState();
}

class _SettingInterfacePageState extends State<SettingInterfacePage> {
  List<double> _maxWindowHeightOptions = [600, 700, 800, 900];

  bool _showTrayIcon = false;
  String _trayIconStyle;
  double _maxWindowHeight = 0;

  String t(String key, {List<String> args}) {
    return 'page_setting_interface.$key'.tr(args: args);
  }

  @override
  void initState() {
    _showTrayIcon = sharedConfig.showTrayIcon;
    _trayIconStyle = sharedConfig.trayIconStyle;
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
          if (_showTrayIcon)
            PreferenceListSection(
              title: Text(t('pref_section_title_tray_icon_style')),
              children: [
                PreferenceListRadioItem(
                  value: kTrayIconStyleWhite,
                  groupValue: _trayIconStyle,
                  title: Text(t('pref_item_title_tray_icon_style_white')),
                  onChanged: (newValue) {
                    _trayIconStyle = newValue;
                    sharedConfigManager.setTrayIconStyle(newValue);
                    setState(() {});
                  },
                ),
                PreferenceListRadioItem(
                  value: kTrayIconStyleBlack,
                  groupValue: _trayIconStyle,
                  title: Text(t('pref_item_title_tray_icon_style_black')),
                  onChanged: (newValue) {
                    _trayIconStyle = newValue;
                    sharedConfigManager.setTrayIconStyle(newValue);
                    setState(() {});
                  },
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
