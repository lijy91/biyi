import 'package:flutter/material.dart';

import '../../includes.dart';

class SettingAppLanguagePage extends StatefulWidget {
  final String? initialLanguage;

  const SettingAppLanguagePage({
    Key? key,
    this.initialLanguage,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingAppLanguagePageState();
}

class _SettingAppLanguagePageState extends State<SettingAppLanguagePage> {
  String? _language;

  String t(String key) {
    return 'page_setting_app_language.$key'.tr();
  }

  @override
  void initState() {
    _language = widget.initialLanguage;
    super.initState();
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: Text(t('title')),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      child: PreferenceList(
        children: [
          PreferenceListSection(
            children: [
              for (var appLanguage in kAppLanguages)
                PreferenceListRadioItem<String>(
                  title: LanguageLabel(appLanguage),
                  accessoryView: Container(),
                  value: appLanguage,
                  groupValue: _language ?? '',
                  onChanged: (newGroupValue) async {
                    _language = newGroupValue;
                    await context.setLocale(languageToLocale(newGroupValue));
                    sharedConfigManager.setAppLanguage(newGroupValue);
                    setState(() {});
                  },
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }
}
