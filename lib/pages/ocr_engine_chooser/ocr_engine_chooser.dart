import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../includes.dart';

class OcrEngineChooserPage extends StatefulWidget {
  final OcrEngineConfig initialOcrEngineConfig;
  final ValueChanged<OcrEngineConfig> onChoosed;

  const OcrEngineChooserPage({
    Key key,
    this.initialOcrEngineConfig,
    this.onChoosed,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _OcrEngineChooserPageState();
}

class _OcrEngineChooserPageState extends State<OcrEngineChooserPage> {
  String _identifier;

  initState() {
    super.initState();
    setState(() {
      _identifier = widget.initialOcrEngineConfig?.identifier;
    });
  }

  void _handleClickOk() async {
    if (widget.onChoosed != null) {
      OcrEngineConfig ocrEngineConfig =
          sharedLocalDb.ocrEngine(_identifier).get();
      widget.onChoosed(ocrEngineConfig);
    }

    Navigator.of(context).pop();
  }

  Widget _buildBody(BuildContext context) {
    return LocalDbBuilder(builder: (context, dbData) {
      return PreferenceList(
        children: [
          PreferenceListSection(
            children: [
              for (OcrEngineConfig ocrEngineConfig
                  in dbData.proOcrEngineList ?? [])
                PreferenceListRadioItem(
                  icon: OcrEngineIcon(
                    ocrEngineConfig,
                  ),
                  value: ocrEngineConfig.identifier,
                  groupValue: _identifier,
                  onChanged: (newValue) {
                    setState(() {
                      _identifier = newValue;
                    });
                  },
                  title: Builder(builder: (_) {
                    return Text.rich(
                      TextSpan(
                        text: ocrEngineConfig.typeName,
                        children: [
                          TextSpan(
                            text: ' (${ocrEngineConfig.shortId})',
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
              for (OcrEngineConfig ocrEngineConfig
                  in dbData.privateOcrEngineList ?? [])
                PreferenceListRadioItem(
                  icon: OcrEngineIcon(
                    ocrEngineConfig,
                  ),
                  value: ocrEngineConfig.identifier,
                  groupValue: _identifier,
                  onChanged: (newValue) {
                    setState(() {
                      _identifier = newValue;
                    });
                  },
                  title: Builder(builder: (_) {
                    return Text.rich(
                      TextSpan(
                        text: ocrEngineConfig.typeName,
                        children: [
                          TextSpan(
                            text: ' (${ocrEngineConfig.shortId})',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          )
                        ],
                      ),
                    );
                  }),
                ),
              if ((dbData.privateOcrEngineList ?? []).isEmpty)
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
        title: Text('文字识别引擎'),
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
