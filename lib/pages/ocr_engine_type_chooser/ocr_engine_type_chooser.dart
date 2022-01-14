import 'package:flutter/material.dart';

import '../../includes.dart';

class OcrEngineTypeChooserPage extends StatefulWidget {
  final String engineType;
  final ValueChanged<String> onEngineTypeChanged;

  const OcrEngineTypeChooserPage({
    Key key,
    this.engineType,
    this.onEngineTypeChanged,
  }) : super(key: key);

  @override
  _OcrEngineTypeChooserPageState createState() =>
      _OcrEngineTypeChooserPageState();
}

class _OcrEngineTypeChooserPageState extends State<OcrEngineTypeChooserPage> {
  String _type;

  String t(String key, {List<String> args}) {
    return 'page_ocr_engine_type_chooser.$key'.tr(args: args);
  }

  void initState() {
    _type = widget.engineType;
    super.initState();
  }

  void _handleClickOk() async {
    if (widget.onEngineTypeChanged != null) {
      widget.onEngineTypeChanged(_type);
    }

    Navigator.of(context).pop();
  }

  Widget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: Text(t('title')),
      actions: [
        CustomAppBarActionItem(
          text: 'ok'.tr(),
          onPressed: _handleClickOk,
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return PreferenceList(
      children: [
        PreferenceListSection(
          children: [
            for (var engineType in kSupportedOcrEngineTypes)
              PreferenceListRadioItem(
                icon: OcrEngineIcon(
                  OcrEngineConfig(type: engineType),
                ),
                title: Text('ocr_engine.$engineType'.tr()),
                value: engineType,
                groupValue: _type,
                onChanged: (newGroupValue) {
                  _type = engineType;
                  setState(() {});
                },
              ),
          ],
        ),
      ],
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
