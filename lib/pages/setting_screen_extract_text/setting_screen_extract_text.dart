import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../includes.dart';

class SettingScreenExtractTextPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingScreenExtractTextPageState();
}

class _SettingScreenExtractTextPageState
    extends State<SettingScreenExtractTextPage> {
  OcrEngineConfig _defaultOcrEngineConfig;

  @override
  void initState() {
    _defaultOcrEngineConfig =
        sharedLocalDb.ocrEngine(sharedConfig.defaultOcrEngineId).get();
    super.initState();
  }

  Widget _buildBody(BuildContext context) {
    return LocalDbBuilder(builder: (context, dbData) {
      return PreferenceList(
        children: [
          PreferenceListSection(
            title: Text('默认文字识别引擎'),
            description: Text(
              '当你载取屏幕某区域后，将使用该引擎进行文字识别',
            ),
            children: [
              PreferenceListItem(
                icon: _defaultOcrEngineConfig == null
                    ? null
                    : OcrEngineIcon(
                        _defaultOcrEngineConfig,
                      ),
                title: Builder(builder: (_) {
                  if (_defaultOcrEngineConfig == null) return Text('请选择');
                  return Text.rich(
                    TextSpan(
                      text: _defaultOcrEngineConfig.typeName,
                      children: [
                        TextSpan(
                          text: ' (${_defaultOcrEngineConfig.shortId})',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        )
                      ],
                    ),
                  );
                }),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => OcrEngineChooserPage(
                        initialOcrEngineConfig: _defaultOcrEngineConfig,
                        onChoosed: (ocrEngineConfig) {
                          sharedConfigManager.setDefaultOcrEngineId(
                            ocrEngineConfig.identifier,
                          );
                          setState(() {
                            _defaultOcrEngineConfig = ocrEngineConfig;
                          });
                        },
                      ),
                    ),
                  );
                },
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
        title: Text('屏幕取词'),
      ),
      body: _buildBody(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }
}
