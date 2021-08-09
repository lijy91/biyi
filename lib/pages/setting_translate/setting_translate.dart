import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../includes.dart';

class SettingTranslatePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingTranslatePageState();
}

class _SettingTranslatePageState extends State<SettingTranslatePage> {
  String _translationMode = kTranslationModeManual;
  TranslationEngineConfig _defaultEngineConfig;

  @override
  void initState() {
    _translationMode = sharedConfig.translationMode;
    _defaultEngineConfig =
        sharedLocalDb.engine(sharedConfig.defaultEngineId).get();
    super.initState();
  }

  void _handleChanged(newValue) {
    _translationMode = newValue;
    sharedConfigManager.setTranslationMode(_translationMode);
  }

  Widget _buildBody(BuildContext context) {
    return LocalDbBuilder(builder: (context, dbData) {
      return PreferenceList(
        children: [
          PreferenceListSection(
            title: Text('翻译模式'),
            children: [
              PreferenceListRadioItem(
                value: kTranslationModeManual,
                groupValue: _translationMode,
                onChanged: _handleChanged,
                title:
                    Text(kKnownTranslationModeLabels[kTranslationModeManual]),
              ),
              PreferenceListRadioItem(
                value: kTranslationModeAuto,
                groupValue: _translationMode,
                onChanged: _handleChanged,
                title: Text(kKnownTranslationModeLabels[kTranslationModeAuto]),
              ),
            ],
          ),
          if (sharedConfig.translationMode == kTranslationModeAuto)
            PreferenceListSection(
              title: Text('默认语种识别引擎'),
              description: Text(
                '当你提交翻译后，将使用该引擎进行语种识别',
              ),
              children: [
                PreferenceListItem(
                  icon: _defaultEngineConfig == null
                      ? null
                      : TranslationEngineIcon(_defaultEngineConfig),
                  title: Builder(builder: (_) {
                    if (_defaultEngineConfig == null) return Text('请选择');
                    return Text.rich(
                      TextSpan(
                        text: _defaultEngineConfig.typeName,
                        children: [
                          TextSpan(
                            text: ' (${_defaultEngineConfig.shortId})',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          )
                        ],
                      ),
                    );
                  }),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => TranslationEngineChooserPage(
                          initialEngineConfig: _defaultEngineConfig,
                          onChoosed: (engineConfig) {
                            sharedConfigManager.setDefaultEngineId(
                              engineConfig.identifier,
                            );
                            setState(() {
                              _defaultEngineConfig = engineConfig;
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          if (sharedConfig.translationMode == kTranslationModeAuto)
            PreferenceListSection(
              title: Text('翻译目标'),
              description: Text(
                '应用将匹配你的翻译目标并显示相应的翻译结果',
              ),
              children: [
                for (TranslationTarget translationTarget
                    in dbData.translationTargetList ?? [])
                  PreferenceListItem(
                    title: Builder(
                      builder: (_) {
                        return Row(
                          children: [
                            if (translationTarget.sourceLanguage != null)
                              LanguageLabel(translationTarget.sourceLanguage),
                            if (translationTarget.targetLanguage != null)
                              Container(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                child: Icon(
                                  IcoMoonIcons.arrow_right,
                                  size: 17,
                                  color: Theme.of(context).iconTheme.color,
                                ),
                              ),
                            if (translationTarget.targetLanguage != null)
                              LanguageLabel(translationTarget.targetLanguage),
                          ],
                        );
                      },
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => TranslationTargetNewPage(
                            translationTarget: translationTarget,
                          ),
                        ),
                      );
                    },
                  ),
                PreferenceListItem(
                  title: Text(
                    '添加',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  accessoryView: Container(),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => TranslationTargetNewPage(),
                      ),
                    );
                  },
                )
              ],
            ),
        ],
      );
    });
  }

  Widget _build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text('翻译'),
      ),
      body: _buildBody(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }
}
