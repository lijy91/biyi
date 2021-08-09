import 'package:flutter/cupertino.dart';
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

  initState() {
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
      return PreferenceList(
        children: [
          PreferenceListSection(
            children: [
              for (TranslationEngineConfig engineConfig
                  in dbData.proEngineList ?? [])
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
            ],
          ),
          PreferenceListSection(
            title: Text('私有'),
            children: [
              for (TranslationEngineConfig engineConfig
                  in dbData.privateEngineList ?? [])
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
              if ((dbData.privateEngineList ?? []).isEmpty)
                PreferenceListItem(
                  title: Text('无'),
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
        title: Text('文本翻译引擎'),
        actions: [
          CustomAppBarActionItem(
            text: '确定',
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
