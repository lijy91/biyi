import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../includes.dart';

class SettingAppLanguagePage extends StatefulWidget {
  final String initialLanguage;
  final ValueChanged<String> onChoosed;

  const SettingAppLanguagePage({
    Key key,
    this.initialLanguage,
    this.onChoosed,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SettingAppLanguagePageState();
}

class _SettingAppLanguagePageState extends State<SettingAppLanguagePage> {
  String _language;

  void initState() {
    _language = widget.initialLanguage;
    super.initState();
  }

  void _handleClickOk() async {
    if (widget.onChoosed != null) {
      widget.onChoosed(_language);
    }

    Navigator.of(context).pop();
  }

  Widget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: Text('显示语言'),
      actions: [
        CustomAppBarActionItem(
          text: '确定',
          onPressed: _handleClickOk,
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      child: PreferenceList(
        children: [
          PreferenceListSection(
            children: [
              for (var appLanguage in kAppLanguages)
                PreferenceListRadioItem(
                  title: LanguageLabel(appLanguage),
                  accessoryView: Container(),
                  value: appLanguage,
                  groupValue: _language,
                  onChanged: (newGroupValue) {
                    _language = appLanguage;
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
