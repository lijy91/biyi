import 'package:flutter/material.dart';

import '../../../includes.dart';

class SettingExtractTextPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingExtractTextPageState();
}

class _SettingExtractTextPageState extends State<SettingExtractTextPage> {
  OcrEngineConfig? _defaultOcrEngineConfig;
  bool _autoCopyDetectedText = true;

  String t(String key, {List<String> args = const []}) {
    return 'page_setting_extract_text.$key'.tr(args: args);
  }

  @override
  void initState() {
    _autoCopyDetectedText = sharedConfig.autoCopyDetectedText;
    _defaultOcrEngineConfig =
        sharedLocalDb.ocrEngine(sharedConfig.defaultOcrEngineId).get();
    super.initState();
  }

  Widget _buildBody(BuildContext context) {
    return LocalDbBuilder(builder: (context, dbData) {
      return PreferenceList(
        children: [
          PreferenceListSection(
            title: Text(t('pref_section_title_default_detect_text_engine')),
            children: [
              PreferenceListItem(
                icon: _defaultOcrEngineConfig == null
                    ? null
                    : OcrEngineIcon(
                        _defaultOcrEngineConfig!,
                      ),
                title: Builder(builder: (_) {
                  if (_defaultOcrEngineConfig == null)
                    return Text('please_choose'.tr());
                  return Text.rich(
                    TextSpan(
                      text: _defaultOcrEngineConfig?.typeName,
                      children: [
                        TextSpan(
                          text: ' (${_defaultOcrEngineConfig?.shortId})',
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
          PreferenceListSection(
            children: [
              PreferenceListSwitchItem(
                value: _autoCopyDetectedText,
                title: Text(t('pref_item_auto_copy_detected_text')),
                onChanged: (newValue) async {
                  sharedConfigManager.setAutoCopyDetectedText(newValue);

                  _autoCopyDetectedText = newValue;
                  setState(() {});
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
        title: Text(t('title')),
      ),
      body: _buildBody(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }
}
