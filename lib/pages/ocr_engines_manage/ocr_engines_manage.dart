import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../includes.dart';

class OcrEnginesManagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OcrEnginesManagePageState();
}

class _OcrEnginesManagePageState extends State<OcrEnginesManagePage> {
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
                    sharedLocalDb.proEngine(ocrEngineConfig.identifier).update(
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
            title: Text('私有'),
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
                  '添加',
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
        title: Text('文字识别引擎'),
      ),
      body: _buildBody(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }
}
