import 'package:biyi_app/app/router_config.dart';
import 'package:biyi_app/i18n/strings.g.dart';
import 'package:biyi_app/services/api_client.dart';
import 'package:biyi_app/states/settings.dart';
import 'package:biyi_app/widgets/customized_app_bar/customized_app_bar.dart';
import 'package:biyi_app/widgets/widgets.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uikit/uikit.dart';
import 'package:reorderables/reorderables.dart';

class OcrEnginesSettingPage extends StatefulWidget {
  const OcrEnginesSettingPage({super.key});

  @override
  State<OcrEnginesSettingPage> createState() => _OcrEnginesSettingPageState();
}

class _OcrEnginesSettingPageState extends State<OcrEnginesSettingPage> {
  Future<void> _handleClickAdd() async {
    final ocrEngineType = await context.push<String?>(
      PageId.settingsOcrEngineTypes,
    );
    if (ocrEngineType != null) {
      // ignore: use_build_context_synchronously
      await context.push<String?>(
        PageId.settingsOcrEnginesNew,
        extra: {
          'ocrEngineType': ocrEngineType,
          'editable': true,
        },
      );
    }
  }

  Widget _buildListSectionProEngines(BuildContext context) {
    final proOcrEngineList = context.watch<Settings>().proOcrEngines.list();
    if (proOcrEngineList.isEmpty) return Container();
    return ListSection(
      children: [
        for (OcrEngineConfig item in proOcrEngineList)
          SwitchListTile(
            value: !item.disabled,
            onChanged: (newValue) {
              context
                  .read<Settings>() // Linewrap
                  .proOcrEngine(item.id)
                  .update(
                    disabled: !item.disabled,
                  );
            },
            leading: OcrEngineIcon(item.type),
            title: OcrEngineName(item),
            onTap: () {
              context.push<String?>(
                PageId.settingsOcrEngine(item.id),
                extra: {
                  'ocrEngineConfig': item,
                  'editable': false,
                },
              );
            },
          ),
      ],
    );
  }

  Widget _buildListSectionPrivateEngines(BuildContext context) {
    final privateOcrEngineList =
        context.watch<Settings>().privateOcrEngines.list();

    void onReorder(int oldIndex, int newIndex) {
      List<String> idList = privateOcrEngineList.map((e) => e.id).toList();
      String oldId = idList.removeAt(oldIndex);
      idList.insert(newIndex, oldId);

      for (var i = 0; i < idList.length; i++) {
        final id = idList[i];
        context.read<Settings>().privateOcrEngine(id).update(
              position: i + 1,
            );
      }
    }

    return ListSection(
      header: Text(
        t.app.settings.ocr_engines.private.title,
      ),
      footer: Text(
        t.app.settings.ocr_engines.private.description,
      ),
      children: [
        if (privateOcrEngineList.isNotEmpty)
          ReorderableColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            onReorder: onReorder,
            children: [
              for (var i = 0; i < privateOcrEngineList.length; i++)
                ReorderableWidget(
                  reorderable: true,
                  key: ValueKey(i),
                  child: Builder(
                    builder: (_) {
                      bool isLastItem = i == privateOcrEngineList.length - 1;
                      final item = privateOcrEngineList[i];
                      return Column(
                        children: [
                          SwitchListTile(
                            value: !item.disabled,
                            onChanged: (newValue) {
                              context
                                  .read<Settings>()
                                  .privateOcrEngine(item.id)
                                  .update(
                                    disabled: !item.disabled,
                                  );
                            },
                            leading: OcrEngineIcon(item.type),
                            title: OcrEngineName(item),
                            onTap: () {
                              context.push<String?>(
                                PageId.settingsOcrEngine(item.id),
                                extra: {
                                  'ocrEngineConfig': item,
                                  'editable': true,
                                },
                              );
                            },
                          ),
                          if (!isLastItem) const Divider(height: 1),
                        ],
                      );
                    },
                  ),
                ),
            ],
          ),
        ListTile(
          title: Text(
            t.add,
            style: const TextStyle(),
          ),
          onTap: _handleClickAdd,
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: [
        _buildListSectionProEngines(context),
        _buildListSectionPrivateEngines(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      navigationBar: CustomizedAppBar(
        title: Text(t.app.settings.ocr_engines.title),
      ),
      child: _buildBody(context),
    );
  }
}
