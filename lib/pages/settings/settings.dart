import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../includes.dart';

class SettingsPage extends StatefulWidget {
  final VoidCallback? onDismiss;

  const SettingsPage({Key? key, this.onDismiss}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _inputSetting = kInputSettingSubmitWithEnter;
  bool _launchAtStartupIsEnabled = false;

  String t(String key, {List<String> args = const []}) {
    return 'page_settings.$key'.tr(args: args);
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    _inputSetting = sharedConfig.inputSetting;
    if (kIsMacOS || kIsWindows) {
      _launchAtStartupIsEnabled = await LaunchAtStartup.instance.isEnabled();
    }
    setState(() {});
  }

  Widget _buildBody(BuildContext context) {
    return LocalDbBuilder(builder: (context, dbData) {
      return PreferenceList(
        children: [
          PreferenceListSection(
            title: Text(t('pref_section_title_general')),
            children: [
              PreferenceListItem(
                title: Text(t('pref_item_title_extract_text')),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SettingExtractTextPage(),
                    ),
                  );
                },
              ),
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
            ],
          ),
          PreferenceListSection(
            title: Text(t('pref_section_title_appearance')),
            children: [
              PreferenceListItem(
                title: Text(t('pref_item_title_interface')),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SettingInterfacePage(),
                    ),
                  );
                },
              ),
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
                  'theme_mode.${describeEnum(sharedConfig.themeMode)}'.tr(),
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
              PreferenceListRadioItem<String>(
                value: kInputSettingSubmitWithEnter,
                groupValue: _inputSetting,
                title: Text(t('pref_item_title_submit_with_enter')),
                onChanged: (newValue) {
                  _inputSetting = newValue;
                  sharedConfigManager.setInputSetting(newValue);
                  setState(() {});
                },
              ),
              PreferenceListRadioItem<String>(
                value: kInputSettingSubmitWithMetaEnter,
                groupValue: _inputSetting,
                title: Text(t(kIsMacOS
                    ? 'pref_item_title_submit_with_meta_enter_mac'
                    : 'pref_item_title_submit_with_meta_enter')),
                onChanged: (newValue) {
                  _inputSetting = newValue;
                  sharedConfigManager.setInputSetting(newValue);
                  setState(() {});
                },
              ),
            ],
          ),
          PreferenceListSection(
            title: Text(t('pref_section_title_advanced')),
            children: [
              PreferenceListSwitchItem(
                value: _launchAtStartupIsEnabled,
                title: Text(t('pref_item_title_launch_at_startup')),
                onChanged: (newValue) async {
                  if (newValue) {
                    LaunchAtStartup.instance.enable();
                  } else {
                    LaunchAtStartup.instance.disable();
                  }
                  _launchAtStartupIsEnabled =
                      await LaunchAtStartup.instance.isEnabled();
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
          PreferenceListSection(
            title: Text(t('pref_section_title_others')),
            children: [
              PreferenceListItem(
                title: Text(t('pref_item_title_about')),
                onTap: () async {
                  String url = 'https://github.com/biyidev/biyi';
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                },
              ),
            ],
          ),
          PreferenceListSection(
            children: [
              PreferenceListItem(
                title: Container(
                  width: double.infinity,
                  child: Text(
                    t('pref_item_title_exit_app'),
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
                accessoryView: Container(),
                onTap: () async {
                  return showDialog<void>(
                    context: context,
                    builder: (BuildContext ctx) {
                      return CustomAlertDialog(
                        title: Text(t('exit_app_dialog.title')),
                        actions: <Widget>[
                          CustomDialogAction(
                            child: Text('cancel'.tr()),
                            onPressed: () async {
                              Navigator.of(ctx).pop();
                            },
                          ),
                          CustomDialogAction(
                            child: Text('ok'.tr()),
                            onPressed: () async {
                              await trayManager.destroy();
                              exit(0);
                            },
                          ),
                        ],
                      );
                    },
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
                    sharedEnv.appVersion,
                    '${sharedEnv.appBuildNumber}',
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
