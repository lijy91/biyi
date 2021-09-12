import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../includes.dart';

class OcrEnginesManagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OcrEnginesManagePageState();
}

class _OcrEnginesManagePageState extends State<OcrEnginesManagePage> {
  String t(String key, {List<String> args}) {
    return 'page_ocr_engines_manage.$key'.tr(args: args);
  }

  Widget _buildBody(BuildContext context) {
    return LocalDbBuilder(builder: (context, dbData) {
      return PreferenceList(
        children: [
          PreferenceListSection(
            children: [
              for (OcrEngineConfig ocrEngineConfig
                  in dbData.proOcrEngineList ?? [])
                PreferenceListSwitchItem(
                  icon: OcrEngineIcon(
                    ocrEngineConfig,
                  ),
                  value: !ocrEngineConfig.disabled,
                  onChanged: (newValue) {
                    sharedLocalDb
                        .proOcrEngine(ocrEngineConfig.identifier)
                        .update(
                          disabled: !ocrEngineConfig.disabled,
                        );
                    sharedLocalDb.write();
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
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => OcrEngineNewPage(
                          editable: false,
                          ocrEngineConfig: ocrEngineConfig,
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
          PreferenceListSection(
            title: Text(t('pref_section_title_private')),
            children: [
              for (OcrEngineConfig ocrEngineConfig
                  in dbData.privateOcrEngineList ?? [])
                PreferenceListSwitchItem(
                  icon: OcrEngineIcon(
                    ocrEngineConfig,
                  ),
                  value: !ocrEngineConfig.disabled,
                  onChanged: (newValue) {
                    sharedLocalDb
                        .privateOcrEngine(ocrEngineConfig.identifier)
                        .update(
                          disabled: !ocrEngineConfig.disabled,
                        );
                    sharedLocalDb.write();
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
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => OcrEngineNewPage(
                          ocrEngineConfig: ocrEngineConfig,
                        ),
                      ),
                    );
                  },
                ),
              PreferenceListItem(
                title: Text(
                  'add'.tr(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                accessoryView: Container(),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => OcrEngineNewPage(),
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
