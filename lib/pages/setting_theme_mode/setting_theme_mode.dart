import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../includes.dart';

class SettingThemeModePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingThemeModePageState();
}

class _SettingThemeModePageState extends State<SettingThemeModePage> {
  ThemeMode _themeMode = ThemeMode.light;

  String t(String key, {List<String> args}) {
    return 'page_setting_theme_mode.$key'.tr(args: args);
  }

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
                title: Text(
                  'theme_mode.${describeEnum(ThemeMode.light)}'.tr(),
                ),
              ),
              PreferenceListRadioItem(
                value: ThemeMode.dark,
                groupValue: _themeMode,
                onChanged: _handleChanged,
                title: Text(
                  'theme_mode.${describeEnum(ThemeMode.dark)}'.tr(),
                ),
              ),
              if (!kIsWindows)
                PreferenceListRadioItem(
                  value: ThemeMode.system,
                  groupValue: _themeMode,
                  onChanged: _handleChanged,
                  title: Text(
                    'theme_mode.${describeEnum(ThemeMode.system)}'.tr(),
                  ),
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
