import 'package:biyi_app/i18n/strings.g.dart';
import 'package:biyi_app/services/api_client.dart';
import 'package:biyi_app/states/settings.dart';
import 'package:biyi_app/widgets/customized_app_bar/customized_app_bar.dart';
import 'package:biyi_app/widgets/widgets.dart';

import 'package:go_router/go_router.dart';
import 'package:uikit/uikit.dart';

class AvailableTranslationEnginesPage extends StatefulWidget {
  const AvailableTranslationEnginesPage({
    super.key,
    this.selectedEngineId,
  });

  final String? selectedEngineId;

  @override
  State<StatefulWidget> createState() =>
      _AvailableTranslationEnginesPageState();
}

class _AvailableTranslationEnginesPageState
    extends State<AvailableTranslationEnginesPage> {
  List<TranslationEngineConfig> get _proEngineList {
    return Settings.instance.proTranslationEngines
        .list(where: ((e) => !e.disabled));
  }

  List<TranslationEngineConfig> get _privateEngineList {
    return Settings.instance.privateTranslationEngines
        .list(where: ((e) => !e.disabled));
  }

  String? _selectedEngineId;

  @override
  void initState() {
    super.initState();
    setState(() {
      _selectedEngineId = widget.selectedEngineId;
    });
  }

  void _handleSelectedEngineIdChanged(String? engineId) {
    setState(() {
      _selectedEngineId = engineId;
    });
  }

  Future<void> _handleClickOk() async {
    TranslationEngineConfig? engineConfig =
        Settings.instance.privateTranslationEngine(_selectedEngineId).get() ??
            Settings.instance.proTranslationEngine(_selectedEngineId).get();
    context.pop<TranslationEngineConfig?>(engineConfig);
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: [
        if (_proEngineList.isNotEmpty)
          ListSection(
            children: [
              for (var engineConfig in _proEngineList)
                RadioListTile<String>(
                  value: engineConfig.id,
                  groupValue: _selectedEngineId,
                  onChanged: _handleSelectedEngineIdChanged,
                  useCheckmarkStyle: true,
                  leading: TranslationEngineIcon(engineConfig.type),
                  title: TranslationEngineName(engineConfig),
                ),
            ],
          ),
        ListSection(
          header: Text(
            t.app.translation_engines.private.title,
          ),
          children: [
            for (var engineConfig in _privateEngineList)
              RadioListTile<String>(
                value: engineConfig.id,
                groupValue: _selectedEngineId,
                onChanged: _handleSelectedEngineIdChanged,
                useCheckmarkStyle: true,
                leading: TranslationEngineIcon(engineConfig.type),
                title: TranslationEngineName(engineConfig),
              ),
            if (_privateEngineList.isEmpty)
              ListTile(
                title: Text(
                  t.app.translation_engines.msg.no_available_engines,
                ),
              ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      navigationBar: CustomizedAppBar(
        title: Text(
          t.app.translation_engines.title,
        ),
        actions: [
          Button.primary(
            onPressed: _handleClickOk,
            child: Text(t.ok),
          ),
        ],
      ),
      child: _buildBody(context),
    );
  }
}
