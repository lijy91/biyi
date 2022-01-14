import 'package:flutter/material.dart';
import 'package:hotkey_manager/hotkey_manager.dart';

import '../../../includes.dart';

class SettingShortcutsPage extends StatefulWidget {
  const SettingShortcutsPage({Key key}) : super(key: key);

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
    ShortcutService.instance.stop();
    sharedConfigManager.addListener(_configListen);

    super.initState();
  }

  @override
  void dispose() {
    ShortcutService.instance.start();
    sharedConfigManager.removeListener(_configListen);
    super.dispose();
  }

  void _configListen() {
    _config = sharedConfigManager.getConfig();
    setState(() {});
  }

  Future<void> _handleClickRegisterNewHotKey(
    BuildContext context, {
    String shortcutKey,
    HotKeyScope shortcutScope = HotKeyScope.system,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return RecordHotKeyDialog(
          onHotKeyRecorded: (newHotKey) {
            sharedConfigManager.setShortcut(
              shortcutKey,
              newHotKey..scope = shortcutScope,
            );
          },
        );
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return LocalDbBuilder(builder: (context, dbData) {
      return PreferenceList(
        children: [
          PreferenceListSection(
            children: [
              PreferenceListItem(
                title: Text(t('pref_item_title_show_or_hide')),
                detailText: HotKeyVirtualView(
                  hotKey: _config.shortcutShowOrHide,
                ),
                onTap: () {
                  _handleClickRegisterNewHotKey(
                    context,
                    shortcutKey: kShortcutShowOrHide,
                  );
                },
              ),
              PreferenceListItem(
                title: Text(t('pref_item_title_hide')),
                detailText: HotKeyVirtualView(
                  hotKey: _config.shortcutHide,
                ),
                onTap: () {
                  _handleClickRegisterNewHotKey(
                    context,
                    shortcutKey: kShortcutHide,
                    shortcutScope: HotKeyScope.inapp,
                  );
                },
              ),
            ],
          ),
          PreferenceListSection(
            title: Text(t('pref_section_title_extract_text')),
            children: [
              PreferenceListItem(
                title: Text(t('pref_item_title_extract_text_from_selection')),
                detailText: HotKeyVirtualView(
                  hotKey: _config.shortcutExtractFromScreenSelection,
                ),
                onTap: () {
                  _handleClickRegisterNewHotKey(
                    context,
                    shortcutKey: kShortcutExtractFromScreenSelection,
                  );
                },
              ),
              if (!kIsLinux)
                PreferenceListItem(
                  title: Text(t('pref_item_title_extract_text_from_capture')),
                  detailText: HotKeyVirtualView(
                    hotKey: _config.shortcutExtractFromScreenCapture,
                  ),
                  onTap: () {
                    _handleClickRegisterNewHotKey(
                      context,
                      shortcutKey: kShortcutExtractFromScreenCapture,
                    );
                  },
                ),
              PreferenceListItem(
                title: Text(t('pref_item_title_extract_text_from_clipboard')),
                detailText: HotKeyVirtualView(
                  hotKey: _config.shortcutExtractFromClipboard,
                ),
                onTap: () {
                  _handleClickRegisterNewHotKey(
                    context,
                    shortcutKey: kShortcutExtractFromClipboard,
                  );
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
