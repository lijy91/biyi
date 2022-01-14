import 'package:flutter/material.dart';

import '../../includes.dart';

const List<String> _kAllScopes = [
  kScopeDetectLanguage,
  kScopeLookUp,
  kScopeTranslate,
];

class TranslationEngineNewPage extends StatefulWidget {
  final bool editable;
  final TranslationEngineConfig engineConfig;

  const TranslationEngineNewPage({
    Key key,
    this.editable = true,
    this.engineConfig,
  }) : super(key: key);

  @override
  _TranslationEngineNewPageState createState() =>
      _TranslationEngineNewPageState();
}

class _TranslationEngineNewPageState extends State<TranslationEngineNewPage> {
  Map<String, TextEditingController> _textEditingControllerMap = {};

  String _identifier;
  String _type;
  Map<String, dynamic> _option = Map();
  List<String> _disabledScopes = [];

  List<String> get _engineOptionKeys {
    return kKnownSupportedEngineOptionKeys[_type] ?? [];
  }

  TranslationEngine get translationEngine {
    if (_type != null) {
      var engineConfig = TranslationEngineConfig(
        type: _type,
        option: _option,
      );
      if (widget.engineConfig != null && widget.engineConfig.option == null) {
        engineConfig = TranslationEngineConfig(
          type: _type,
          option: null,
          supportedScopes: widget.engineConfig.supportedScopes,
        );
      }
      return createTranslationEngine(engineConfig);
    }
    return null;
  }

  String t(String key, {List<String> args}) {
    return 'page_translation_engine_new.$key'.tr(args: args);
  }

  @override
  void initState() {
    if (widget.engineConfig != null) {
      _identifier = widget.engineConfig.identifier;
      _type = widget.engineConfig.type;
      _option = widget.engineConfig.option ?? {};
      _disabledScopes = widget.engineConfig.disabledScopes ?? [];

      for (var optionKey in _engineOptionKeys) {
        var textEditingController = TextEditingController(
          text: _option[optionKey] ?? '',
        );
        _textEditingControllerMap[optionKey] = textEditingController;
      }
    }

    super.initState();
  }

  void _handleClickOk() async {
    final id = widget.engineConfig?.identifier;
    await sharedLocalDb.privateEngine(id).updateOrCreate(
          type: _type,
          option: _option,
          disabledScopes: _disabledScopes,
        );
    await sharedLocalDb.write();

    (sharedTranslateClient.adapter as AutoloadTranslateClientAdapter).renew(id);

    Navigator.of(context).pop();
  }

  Widget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: widget.engineConfig != null
          ? Text.rich(
              TextSpan(
                text: widget.engineConfig.typeName,
                children: [
                  TextSpan(
                    text: ' (${widget.engineConfig.shortId})',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  )
                ],
              ),
            )
          : Text(t('title')),
      actions: [
        if (widget.editable)
          CustomAppBarActionItem(
            text: 'ok'.tr(),
            onPressed: _handleClickOk,
          ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return PreferenceList(
      children: [
        PreferenceListSection(
          title: Text(t('pref_section_title_engine_type')),
          children: [
            PreferenceListItem(
              icon: _type == null
                  ? null
                  : TranslationEngineIcon(
                      TranslationEngineConfig(type: _type),
                    ),
              title: _type == null
                  ? Text('please_choose'.tr())
                  : Text('engine.$_type'.tr()),
              accessoryView: widget.editable ? null : Container(),
              onTap: widget.editable
                  ? () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => TranslationEngineTypeChooserPage(
                            engineType: _type,
                            onEngineTypeChanged: (newEngineType) {
                              setState(() {
                                _type = newEngineType;
                              });
                            },
                          ),
                        ),
                      );
                    }
                  : null,
            ),
          ],
        ),
        if (translationEngine != null)
          PreferenceListSection(
            title: Text(t('pref_section_title_support_interface')),
            children: [
              for (var scope in _kAllScopes)
                PreferenceListItem(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 12,
                    right: 12,
                  ),
                  title: Text(
                    'engine_scope.${scope.toLowerCase()}'.tr(),
                  ),
                  summary: Text(scope),
                  accessoryView: Container(
                    child: Text(
                      translationEngine.supportedScopes.contains(scope)
                          ? '✅'
                          : '❌',
                    ),
                  ),
                ),
            ],
          ),
        if (widget.editable && _type != null)
          PreferenceListSection(
            title: Text(t('pref_section_title_option')),
            children: [
              for (var optionKey in _engineOptionKeys)
                PreferenceListTextFieldItem(
                  controller: _textEditingControllerMap[optionKey],
                  placeholder: optionKey,
                  accessoryView: Container(),
                  onChanged: (value) {
                    _option[optionKey] = value;
                    setState(() {});
                  },
                ),
              if (_engineOptionKeys.isEmpty)
                PreferenceListItem(
                  title: const Text('No options'),
                  accessoryView: Container(),
                ),
            ],
          ),
        if (widget.editable && widget.engineConfig != null)
          PreferenceListSection(
            title: const Text(''),
            children: [
              PreferenceListItem(
                title: Center(
                  child: Text(
                    'delete'.tr(),
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                accessoryView: Container(),
                onTap: () async {
                  await sharedLocalDb.privateEngine(_identifier).delete();
                  await sharedLocalDb.write();
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
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }
}
