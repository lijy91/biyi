import 'package:biyi_app/i18n/strings.g.dart';
import 'package:biyi_app/services/translate_client/translate_client.dart';
import 'package:biyi_app/widgets/customized_app_bar/customized_app_bar.dart';
import 'package:biyi_app/widgets/widgets.dart';

import 'package:go_router/go_router.dart';
import 'package:uikit/uikit.dart';

class TranslationEngineTypesPage extends StatefulWidget {
  const TranslationEngineTypesPage({
    super.key,
    this.selectedEngineType,
  });

  final String? selectedEngineType;

  @override
  State<TranslationEngineTypesPage> createState() =>
      _TranslationEngineTypesPageState();
}

class _TranslationEngineTypesPageState
    extends State<TranslationEngineTypesPage> {
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
      title: Text(t.app.translation_engine_types.title),
      actions: [
        Button.primary(
          onPressed: _handleClickOk,
          child: Text(t.ok),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView(
      children: [
        ListSection(
          children: [
            for (final engineType in kSupportedEngineTypes)
              RadioListTile<String>(
                value: engineType,
                groupValue: _selectedEngineType,
                onChanged: (value) {
                  _selectedEngineType = value;
                  setState(() {});
                },
                useCheckmarkStyle: true,
                leading: TranslationEngineIcon(engineType),
                title: Text('engine.$engineType'),
              ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      navigationBar: _buildAppBar(context),
      child: _buildBody(context),
    );
  }
}
