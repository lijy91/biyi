import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../includes.dart';

class LanguageChooserPage extends StatefulWidget {
  final String initialLanguage;
  final ValueChanged<String> onChoosed;

  const LanguageChooserPage({
    Key key,
    this.initialLanguage,
    this.onChoosed,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LanguageChooserPageState();
}

class _LanguageChooserPageState extends State<LanguageChooserPage> {
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
      title: Text('选择语言'),
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
            title: Text('全部'),
            children: [
              for (var supportedLanguage in kSupportedLanguages)
                PreferenceListRadioItem(
                  title: LanguageLabel(supportedLanguage),
                  accessoryView: Container(),
                  value: supportedLanguage,
                  groupValue: _language,
                  onChanged: (newGroupValue) {
                    _language = supportedLanguage;
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
