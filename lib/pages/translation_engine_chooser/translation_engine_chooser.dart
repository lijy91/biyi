import 'package:flutter/material.dart';

import '../../../includes.dart';

class TranslationEngineChooserPage extends StatefulWidget {
  final TranslationEngineConfig initialEngineConfig;
  final ValueChanged<TranslationEngineConfig> onChoosed;

  const TranslationEngineChooserPage({
    Key key,
    this.initialEngineConfig,
    this.onChoosed,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TranslationEngineChooserPageState();
}

class _TranslationEngineChooserPageState
    extends State<TranslationEngineChooserPage> {
  String _identifier;

  String t(String key, {List<String> args}) {
    return 'page_translation_engine_chooser.$key'.tr(args: args);
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _identifier = widget.initialEngineConfig?.identifier;
    });
  }

  void _handleClickOk() async {
    if (widget.onChoosed != null) {
      TranslationEngineConfig engineConfig =
          sharedLocalDb.engine(_identifier).get();
      widget.onChoosed(engineConfig);
    }

    Navigator.of(context).pop();
  }

  Widget _buildBody(BuildContext context) {
    return LocalDbBuilder(builder: (context, dbData) {
      final proEngineList =
          (dbData.proEngineList ?? []).where((e) => !e.disabled).toList();
      final privateEngineList =
          (dbData.privateEngineList ?? []).where((e) => !e.disabled).toList();
      return PreferenceList(
        children: [
          if (proEngineList.isNotEmpty)
            PreferenceListSection(
              children: [
                for (var engineConfig in proEngineList)
                  PreferenceListRadioItem(
                    icon: TranslationEngineIcon(
                      engineConfig,
                    ),
                    value: engineConfig.identifier,
                    groupValue: _identifier,
                    onChanged: (newValue) {
                      setState(() {
                        _identifier = newValue;
                      });
                    },
                    title: Builder(builder: (_) {
                      return Text.rich(
                        TextSpan(
                          text: engineConfig.typeName,
                          children: [
                            TextSpan(
                              text: ' (${engineConfig.shortId})',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey),
                            )
                          ],
                        ),
                      );
                    }),
                  ),
              ],
            ),
          PreferenceListSection(
            title: Text(t('pref_section_title_private')),
            children: [
              for (var engineConfig in privateEngineList)
                PreferenceListRadioItem(
                  icon: TranslationEngineIcon(
                    engineConfig,
                  ),
                  value: engineConfig.identifier,
                  groupValue: _identifier,
                  onChanged: (newValue) {
                    setState(() {
                      _identifier = newValue;
                    });
                  },
                  title: Builder(builder: (_) {
                    return Text.rich(
                      TextSpan(
                        text: engineConfig.typeName,
                        children: [
                          TextSpan(
                            text: ' (${engineConfig.shortId})',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          )
                        ],
                      ),
                    );
                  }),
                ),
              if (privateEngineList.isEmpty)
                PreferenceListItem(
                  title: Text(t('pref_item_title_no_available_engines')),
                  accessoryView: Container(),
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
        actions: [
          CustomAppBarActionItem(
            text: 'ok'.tr(),
            onPressed: _handleClickOk,
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }
}
