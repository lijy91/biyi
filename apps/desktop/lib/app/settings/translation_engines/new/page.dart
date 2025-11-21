import 'package:biyi_app/app/router_config.dart';
import 'package:biyi_app/i18n/strings.g.dart';
import 'package:biyi_app/services/api_client.dart';
import 'package:biyi_app/services/translate_client/translate_client.dart';
import 'package:biyi_app/states/settings.dart';
import 'package:biyi_app/widgets/customized_app_bar/customized_app_bar.dart';
import 'package:biyi_app/widgets/feature_status_icon/feature_status_icon.dart';
import 'package:biyi_app/widgets/translation_engine_icon/translation_engine_icon.dart';
import 'package:biyi_app/widgets/translation_engine_name/translation_engine_name.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uikit/uikit.dart';
import 'package:shortid/shortid.dart';
import 'package:uni_translate_client/uni_translate_client.dart';

class TranslationEnginesNewOrEditPage extends StatefulWidget {
  const TranslationEnginesNewOrEditPage({
    super.key,
    this.editable = true,
    this.engineType,
    this.engineConfig,
  });

  final bool editable;
  final String? engineType;
  final TranslationEngineConfig? engineConfig;

  @override
  State<TranslationEnginesNewOrEditPage> createState() =>
      _TranslationEnginesNewOrEditPageState();
}

class _TranslationEnginesNewOrEditPageState
    extends State<TranslationEnginesNewOrEditPage> {
  final Map<String, TextEditingController> _textEditingControllerMap = {};

  String? _id;
  String? _type;
  Map<String, dynamic> _option = {};

  List<String> get _engineOptionKeys {
    return kKnownSupportedEngineOptionKeys[_type] ?? [];
  }

  TranslationEngine? get translationEngine {
    if (_type != null) {
      var engineConfig = TranslationEngineConfig(
        id: '',
        type: _type!,
        option: _option,
      );
      if (widget.engineConfig != null && widget.engineConfig?.option == null) {
        engineConfig = TranslationEngineConfig(
          id: '',
          type: _type!,
          option: {},
        );
      }
      return createTranslationEngine(engineConfig)!;
    }
    return null;
  }

  @override
  void initState() {
    if (widget.engineConfig != null) {
      _id = widget.engineConfig?.id;
      _type = widget.engineConfig?.type;
      _option = widget.engineConfig?.option ?? {};

      for (var optionKey in _engineOptionKeys) {
        var textEditingController = TextEditingController(
          text: _option[optionKey] ?? '',
        );
        _textEditingControllerMap[optionKey] = textEditingController;
      }
    } else {
      _id = shortid.generate();
      _type = widget.engineType;
    }

    super.initState();
  }

  void _handleClickOk() {
    context
        .read<Settings>() // Linewrap
        .privateTranslationEngine(_id!)
        .updateOrCreate(
          type: _type!,
          option: _option,
        );

    (translateClient.adapter as AutoloadTranslateClientAdapter).renew(_id!);

    Navigator.of(context).pop();
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomizedAppBar(
      title: widget.engineConfig != null
          ? TranslationEngineName(widget.engineConfig!)
          : Text(t.app.translation_engines_new.title),
      actions: [
        if (widget.editable)
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
          header: Text(
            t.app.translation_engines_new.engine_type.title,
          ),
          children: [
            ListTile(
              leading: _type == null ? null : TranslationEngineIcon(_type!),
              title:
                  _type == null ? Text(t.please_choose) : Text('engine.$_type'),
              trailing: widget.editable ? const ListTileChevron() : null,
              onTap: widget.editable
                  ? () async {
                      final newEngineType = await context.push<String?>(
                        PageId.settingsTranslationEngineTypes,
                        extra: {
                          'selectedEngineType': _type,
                        },
                      );
                      if (newEngineType != null) {
                        setState(() {
                          _type = newEngineType;
                        });
                      }
                    }
                  : null,
            ),
          ],
        ),
        if (translationEngine != null)
          ListSection(
            hasLeading: false,
            header: Text(
              t.app.translation_engines_new.support_interface.title,
            ),
            children: [
              for (var scope in TranslationEngineScope.values)
                ListTile(
                  // padding: const EdgeInsets.only(
                  //   top: 10,
                  //   bottom: 10,
                  //   left: 12,
                  //   right: 12,
                  // ),
                  title: Text(
                    'engine_scope.${scope.name.toLowerCase()}',
                  ),
                  subtitle: Text(scope.name),
                  additionalInfo: FeatureStatusIcon(
                    supported: (translationEngine?.supportedScopes ?? [])
                        .contains(scope),
                  ),
                ),
            ],
          ),
        if (widget.editable && _type != null)
          ListSection(
            hasLeading: false,
            header: Text(
              t.app.translation_engines_new.option.title,
            ),
            children: [
              for (var optionKey in _engineOptionKeys)
                ListTile(
                  title: TextField(
                    controller: _textEditingControllerMap[optionKey],
                    placeholder: Text(optionKey),
                    onChanged: (value) {
                      _option[optionKey] = value;
                      setState(() {});
                    },
                  ),
                ),
              if (_engineOptionKeys.isEmpty)
                const ListTile(
                  title: Text('No options'),
                ),
            ],
          ),
        if (widget.editable && widget.engineConfig != null)
          ListSection(
            header: const Text(''),
            children: [
              ListTile(
                title: Center(
                  child: Text(
                    t.delete,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                onTap: () async {
                  context
                      .read<Settings>() // Linewrap
                      .privateTranslationEngine(_id!)
                      .delete();
                  Navigator.of(context).pop();
                },
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
