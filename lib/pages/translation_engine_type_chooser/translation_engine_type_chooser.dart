import 'package:flutter/material.dart';

import '../../includes.dart';

class TranslationEngineTypeChooserPage extends StatefulWidget {
  final String? engineType;
  final ValueChanged<String>? onChoosed;

  const TranslationEngineTypeChooserPage({
    Key? key,
    this.engineType,
    this.onChoosed,
  }) : super(key: key);

  @override
  _TranslationEngineTypeChooserPageState createState() =>
      _TranslationEngineTypeChooserPageState();
}

class _TranslationEngineTypeChooserPageState
    extends State<TranslationEngineTypeChooserPage> {
  String? _type;

  String t(String key, {List<String> args = const []}) {
    return 'page_translation_engine_type_chooser.$key'.tr(args: args);
  }

  @override
  void initState() {
    _type = widget.engineType;
    super.initState();
  }

  void _handleClickOk() async {
    if (widget.onChoosed != null) {
      widget.onChoosed!(_type!);
    }
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
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
            for (var engineType in kSupportedEngineTypes)
              PreferenceListRadioItem(
                icon: TranslationEngineIcon(engineType),
                title: Text('engine.$engineType'.tr()),
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
