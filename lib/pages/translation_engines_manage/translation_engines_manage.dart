import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../includes.dart';

class TranslationEnginesManagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TranslationEnginesManagePageState();
}

class _TranslationEnginesManagePageState
    extends State<TranslationEnginesManagePage> {
  Widget _buildBody(BuildContext context) {
    return LocalDbBuilder(builder: (context, dbData) {
      return PreferenceList(
        children: [
          PreferenceListSection(
            children: [
              for (TranslationEngineConfig engineConfig
                  in dbData.proEngineList ?? [])
                PreferenceListSwitchItem(
                  icon: TranslationEngineIcon(
                    engineConfig,
                  ),
                  value: !engineConfig.disabled,
                  onChanged: (newValue) {
                    sharedLocalDb
                        .proEngine(engineConfig.identifier)
                        .update(
                          disabled: !engineConfig.disabled,
                        );
                    sharedLocalDb.write();
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
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => TranslationEngineNewPage(
                          editable: false,
                          engineConfig: engineConfig,
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
              for (TranslationEngineConfig engineConfig
                  in dbData.privateEngineList ?? [])
                PreferenceListSwitchItem(
                  icon: TranslationEngineIcon(
                    engineConfig,
                  ),
                  value: !engineConfig.disabled,
                  onChanged: (newValue) {
                    sharedLocalDb.privateEngine(engineConfig.identifier).update(
                          disabled: !engineConfig.disabled,
                        );
                    sharedLocalDb.write();
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
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => TranslationEngineNewPage(
                          engineConfig: engineConfig,
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
                      builder: (_) => TranslationEngineNewPage(),
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
        title: Text('文本翻译引擎'),
      ),
      body: _buildBody(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _build(context);
  }
}
