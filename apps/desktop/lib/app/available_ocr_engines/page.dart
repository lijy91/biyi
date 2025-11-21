import 'package:biyi_app/i18n/strings.g.dart';
import 'package:biyi_app/services/api_client.dart';
import 'package:biyi_app/states/settings.dart';
import 'package:biyi_app/widgets/customized_app_bar/customized_app_bar.dart';
import 'package:biyi_app/widgets/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:uikit/uikit.dart';

class AvailableOcrEnginesPage extends StatefulWidget {
  const AvailableOcrEnginesPage({
    super.key,
    this.selectedEngineId,
  });

  final String? selectedEngineId;

  @override
  State<StatefulWidget> createState() => _AvailableOcrEnginesPageState();
}

class _AvailableOcrEnginesPageState extends State<AvailableOcrEnginesPage> {
  List<OcrEngineConfig> get _proOcrEngineList {
    return Settings.instance.proOcrEngines.list(where: ((e) => !e.disabled));
  }

  List<OcrEngineConfig> get _privateOcrEngineList {
    return Settings.instance.privateOcrEngines
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
    OcrEngineConfig? ocrEngineConfig =
        Settings.instance.privateOcrEngine(_selectedEngineId).get() ??
            Settings.instance.proOcrEngine(_selectedEngineId).get();
    context.pop<OcrEngineConfig?>(ocrEngineConfig);
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: [
        if (_proOcrEngineList.isNotEmpty)
          ListSection(
            children: [
              for (var ocrEngineConfig in _proOcrEngineList)
                RadioListTile<String>(
                  value: ocrEngineConfig.id,
                  groupValue: _selectedEngineId,
                  onChanged: _handleSelectedEngineIdChanged,
                  useCheckmarkStyle: true,
                  leading: OcrEngineIcon(ocrEngineConfig.type),
                  title: OcrEngineName(ocrEngineConfig),
                ),
            ],
          ),
        ListSection(
          header: Text(
            t.app.ocr_engines.private.title,
          ),
          children: [
            for (var ocrEngineConfig in _privateOcrEngineList)
              RadioListTile<String>(
                value: ocrEngineConfig.id,
                groupValue: _selectedEngineId,
                onChanged: _handleSelectedEngineIdChanged,
                useCheckmarkStyle: true,
                leading: OcrEngineIcon(ocrEngineConfig.type),
                title: OcrEngineName(ocrEngineConfig),
              ),
            if (_privateOcrEngineList.isEmpty)
              ListTile(
                title: Text(
                  t.app.ocr_engines.msg.no_available_engines,
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
          t.app.ocr_engines.title,
        ),
        actions: [
          Button.secondary(
            onPressed: _handleClickOk,
            child: Text(t.ok),
          ),
        ],
      ),
      child: _buildBody(context),
    );
  }
}
