import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../includes.dart';

class SettingsPage extends StatefulWidget {
  final VoidCallback onDismiss;

  const SettingsPage({Key key, this.onDismiss}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  PackageInfo _packageInfo;
  String _inputSetting = kInputSettingSubmitWithEnter;

  String t(String key, {List<String> args}) {
    return 'page_settings.$key'.tr(args: args);
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    final PackageInfo info = await PackageInfo.fromPlatform();

    setState(() {
      _packageInfo = info;
      _inputSetting = sharedConfig.inputSetting;
    });
  }

  Widget _buildBody(BuildContext context) {
    return LocalDbBuilder(builder: (context, dbData) {
      return PreferenceList(
        children: [
          PreferenceListSection(
            title: Text(t('pref_section_title_general')),
            children: [
              PreferenceListItem(
                title: Text(t('pref_item_title_translate')),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SettingTranslatePage(),
                    ),
                  );
                },
              ),
              PreferenceListItem(
                title: Text(t('pref_item_title_screen_extract_text')),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SettingScreenExtractTextPage(),
                    ),
                  );
                },
              ),
            ],
          ),
          PreferenceListSection(
            title: Text(t('pref_section_title_appearance')),
            children: [
              PreferenceListItem(
                title: Text(t('pref_item_title_app_language')),
                detailText: Text(getLanguageName(sharedConfig.appLanguage)),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SettingAppLanguagePage(
                        initialLanguage: sharedConfig.appLanguage,
                      ),
                    ),
                  );
                },
              ),
              PreferenceListItem(
                title: Text(t('pref_item_title_theme_mode')),
                detailText: Text(
                  'theme_mode.${describeEnum(ThemeMode.light)}'.tr(),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SettingThemeModePage(),
                    ),
                  );
                },
              ),
            ],
          ),
          PreferenceListSection(
            title: Text(t('pref_section_title_shortcuts')),
            children: [
              PreferenceListItem(
                title: Text(t('pref_item_title_keyboard_shortcuts')),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SettingShortcutsPage(),
                    ),
                  );
                },
              ),
            ],
          ),
          PreferenceListSection(
            title: Text(t('pref_section_title_input_settings')),
            children: [
              PreferenceListRadioItem(
                value: kInputSettingSubmitWithEnter,
                groupValue: _inputSetting,
                title: Text(t('pref_item_title_submit_with_enter')),
                onChanged: (newValue) {
                  _inputSetting = newValue;
                  sharedConfigManager.setInputSetting(newValue);
                  setState(() {});
                },
              ),
              PreferenceListRadioItem(
                value: kInputSettingSubmitWithMetaEnter,
                groupValue: _inputSetting,
                title: Text(t('pref_item_title_submit_with_meta_enter')),
                onChanged: (newValue) {
                  _inputSetting = newValue;
                  sharedConfigManager.setInputSetting(newValue);
                  setState(() {});
                },
              ),
            ],
          ),
          PreferenceListSection(
            title: Text(t('pref_section_title_service_integration')),
            children: [
              PreferenceListItem(
                title: Text(t('pref_item_title_engines')),
                detailText: Row(
                  children: [
                    for (var item
                        in dbData.engineList.where((e) => !e.disabled).toList())
                      Container(
                        margin: EdgeInsets.only(left: 4),
                        child: TranslationEngineIcon(
                          item,
                          size: 18,
                        ),
                      ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => TranslationEnginesManagePage(),
                    ),
                  );
                },
              ),
              PreferenceListItem(
                title: Text(t('pref_item_title_ocr_engines')),
                detailText: Row(
                  children: [
                    for (var item in dbData.ocrEngineList
                        .where((e) => !e.disabled)
                        .toList())
                      Container(
                        margin: EdgeInsets.only(left: 4),
                        child: OcrEngineIcon(
                          item,
                          size: 18,
                        ),
                      ),
                  ],
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => OcrEnginesManagePage(),
                    ),
                  );
                },
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 20,
                ),
                child: Text(
                  t('text_version', args: [
                    _packageInfo?.version ?? '',
                    _packageInfo?.buildNumber?.toString() ?? '',
                  ]),
                  style: Theme.of(context).textTheme.caption,
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
        leading: widget.onDismiss != null
            ? CustomAppBarCloseButton(
                onPressed: widget.onDismiss,
              )
            : null,
      ),
      body: _buildBody(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }
}
