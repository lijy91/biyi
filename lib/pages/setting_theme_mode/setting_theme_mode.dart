import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../includes.dart';

class SettingThemeModePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingThemeModePageState();
}

class _SettingThemeModePageState extends State<SettingThemeModePage> {
  ThemeMode _themeMode = ThemeMode.light;

  @override
  void initState() {
    _themeMode = sharedConfig.themeMode;
    super.initState();
  }

  void _handleChanged(newValue) {
    _themeMode = newValue;
    sharedConfigManager.setThemeMode(_themeMode);
  }

  Widget _buildBody(BuildContext context) {
    return LocalDbBuilder(builder: (context, dbData) {
      return PreferenceList(
        children: [
          PreferenceListSection(
            children: [
              PreferenceListRadioItem(
                value: ThemeMode.light,
                groupValue: _themeMode,
                onChanged: _handleChanged,
                title: Text(kKnownThemeModeLabels[ThemeMode.light]),
              ),
              PreferenceListRadioItem(
                value: ThemeMode.dark,
                groupValue: _themeMode,
                onChanged: _handleChanged,
                title: Text(kKnownThemeModeLabels[ThemeMode.dark]),
              ),
              PreferenceListRadioItem(
                value: ThemeMode.system,
                groupValue: _themeMode,
                onChanged: _handleChanged,
                title: Text(kKnownThemeModeLabels[ThemeMode.system]),
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
        title: Text('颜色主题'),
      ),
      body: _buildBody(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }
}
