import 'package:biyi_app/generated/locale_keys.g.dart';
import 'package:biyi_app/services/ocr_client/ocr_client.dart';
import 'package:biyi_app/widgets/customized_app_bar/customized_app_bar.dart';
import 'package:biyi_app/widgets/ocr_engine_icon/ocr_engine_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:harmonic/noprefix/harmonic.dart';
import 'package:influxui/influxui.dart' show Button, ButtonVariant;

class OcrEngineTypesPage extends StatefulWidget {
  const OcrEngineTypesPage({
    super.key,
    this.selectedEngineType,
  });

  final String? selectedEngineType;

  @override
  State<OcrEngineTypesPage> createState() => _OcrEngineTypesPageState();
}

class _OcrEngineTypesPageState extends State<OcrEngineTypesPage> {
  String? _selectedEngineType;

  @override
  void initState() {
    _selectedEngineType = widget.selectedEngineType;
    super.initState();
  }

  Future<void> _handleClickOk() async {
    context.pop<String?>(_selectedEngineType);
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomizedAppBar(
      title: Text(LocaleKeys.app_ocr_engine_types_title.tr()),
      actions: [
        Button(
          label: LocaleKeys.ok.tr(),
          variant: ButtonVariant.subtle,
          onPressed: _handleClickOk,
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: [
        ListSection(
          children: [
            for (var engineType in kSupportedOcrEngineTypes)
              ListTile(
                leading: OcrEngineIcon(engineType),
                title: Text('ocr_engine.$engineType'.tr()),
                additionalInfo: _selectedEngineType == engineType
                    ? const Icon(
                        FluentIcons.checkmark_circle_16_filled,
                      )
                    : null,
                onTap: () {
                  _selectedEngineType = engineType;
                  setState(() {});
                },
              ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }
}
