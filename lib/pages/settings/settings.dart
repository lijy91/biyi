import 'package:flutter/cupertino.dart';
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
  String _appVersion = 'Unknown';
  String _inputSetting = kInputSettingSubmitWithEnter;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    final PackageInfo info = await PackageInfo.fromPlatform();

    String version = info.version;
    String buildNumber = info.buildNumber;

    setState(() {
      _inputSetting = sharedConfig.inputSetting;
      _appVersion = "版本 $version BUILD $buildNumber";
    });
  }

  Widget _buildBody(BuildContext context) {
    return LocalDbBuilder(builder: (context, dbData) {
      return PreferenceList(
        children: [
          PreferenceListSection(
            title: Text('常规'),
            children: [
              // PreferenceListItem(
              //   title: Text('查词'),
              //   onTap: () {},
              // ),
              PreferenceListItem(
                title: Text('翻译'),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => SettingTranslatePage(),
                    ),
                  );
                },
              ),
              PreferenceListItem(
                title: Text('屏幕取词'),
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
            title: Text('外观'),
            children: [
              // PreferenceListItem(
              //   title: Text('显示语言'),
              //   detailText: Text(getLanguageName(sharedConfig.appLanguage)),
              //   onTap: () {
              //     Navigator.of(context).push(
              //       MaterialPageRoute(
              //         builder: (_) => SettingAppLanguagePage(
              //           initialLanguage: sharedConfig.appLanguage,
              //           onChoosed: (newAppLanguage) {
              //             sharedConfigManager.setAppLanguage(newAppLanguage);
              //           },
              //         ),
              //       ),
              //     );
              //   },
              // ),
              PreferenceListItem(
                title: Text('主题模式'),
                detailText: Text(kKnownThemeModeLabels[sharedConfig.themeMode]),
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
            title: Text('快捷键'),
            children: [
              PreferenceListItem(
                title: Text('键盘快捷键'),
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
            title: Text('输入设置'),
            children: [
              PreferenceListRadioItem(
                value: kInputSettingSubmitWithEnter,
                groupValue: _inputSetting,
                title: Text('用 Enter 提交'),
                onChanged: (newValue) {
                  _inputSetting = newValue;
                  sharedConfigManager.setInputSetting(newValue);
                  setState(() {});
                },
              ),
              PreferenceListRadioItem(
                value: kInputSettingSubmitWithMetaEnter,
                groupValue: _inputSetting,
                title: Text('用 ⌘ + Enter 提交'),
                onChanged: (newValue) {
                  _inputSetting = newValue;
                  sharedConfigManager.setInputSetting(newValue);
                  setState(() {});
                },
              ),
            ],
          ),
          PreferenceListSection(
            title: Text('服务接入'),
            children: [
              PreferenceListItem(
                title: Text('文本翻译'),
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
                title: Text('文字识别'),
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
                  _appVersion,
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
        title: Text('设置'),
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
