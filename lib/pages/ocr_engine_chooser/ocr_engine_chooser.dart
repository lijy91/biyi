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

  String t(String key, {List<String> args}) {
    return 'page_ocr_engine_chooser.$key'.tr(args: args);
  }

  @override
  void initState() {
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
            title: Text(t('pref_section_title_private')),
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
                  title: Text('Nothing'),
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
