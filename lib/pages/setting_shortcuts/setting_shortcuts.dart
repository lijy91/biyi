import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../includes.dart';

class SettingShortcutsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingShortcutsPageState();
}

class _SettingShortcutsPageState extends State<SettingShortcutsPage> {
  Config _config = sharedConfigManager.getConfig();

  String t(String key) {
    return 'page_setting_shortcuts.$key'.tr();
  }

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
                title: Text(t('pref_item_title_show_or_hide')),
                detailText: Text(
                  _config.shortcutShowOrHide.toString(),
                ),
                onTap: () {},
              ),
            ],
          ),
          PreferenceListSection(
            title: Text(t('pref_section_title_screen_extract_text')),
            children: [
              PreferenceListItem(
                title: Text(t('pref_item_title_extract_text_from_selection')),
                detailText: Text(
                  _config.shortcutExtractFromScreenSelection.toString(),
                ),
                onTap: () {},
              ),
              PreferenceListItem(
                title: Text(t('pref_item_title_extract_text_from_capture')),
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
