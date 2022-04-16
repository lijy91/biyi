import 'package:flutter/material.dart';

import '../../../includes.dart';

class TranslationEnginesManagePage extends StatefulWidget {
  const TranslationEnginesManagePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TranslationEnginesManagePageState();
}

class _TranslationEnginesManagePageState
    extends State<TranslationEnginesManagePage> {
  String t(String key, {List<String> args = const []}) {
    return 'page_translation_engines_manage.$key'.tr(args: args);
  }

  Widget _buildBody(BuildContext context) {
    return LocalDbBuilder(builder: (context, dbData) {
      final privateEngineList = (dbData.privateEngineList ?? []);
      return PreferenceList(
        children: [
          PreferenceListSection(
            title: Text(t('pref_section_title_private')),
            children: [
              for (var engineConfig in privateEngineList)
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
                  'add'.tr(),
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
