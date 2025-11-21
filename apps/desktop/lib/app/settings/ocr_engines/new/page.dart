import 'package:biyi_app/app/router_config.dart';
import 'package:biyi_app/i18n/strings.g.dart';
import 'package:biyi_app/services/api_client.dart';
import 'package:biyi_app/services/ocr_client/ocr_client.dart';
import 'package:biyi_app/states/settings.dart';
import 'package:biyi_app/widgets/customized_app_bar/customized_app_bar.dart';
import 'package:biyi_app/widgets/ocr_engine_icon/ocr_engine_icon.dart';
import 'package:biyi_app/widgets/ocr_engine_name/ocr_engine_name.dart';

import 'package:go_router/go_router.dart';
import 'package:ocr_engine_youdao/ocr_engine_youdao.dart';
import 'package:provider/provider.dart';
import 'package:uikit/uikit.dart';
import 'package:shortid/shortid.dart';

class OcrEnginesNewOrEditPage extends StatefulWidget {
  const OcrEnginesNewOrEditPage({
    super.key,
    this.editable = true,
    this.ocrEngineType,
    this.ocrEngineConfig,
  });

  final bool editable;
  final String? ocrEngineType;
  final OcrEngineConfig? ocrEngineConfig;

  @override
  State<OcrEnginesNewOrEditPage> createState() =>
      _OcrEnginesNewOrEditPageState();
}

class _OcrEnginesNewOrEditPageState extends State<OcrEnginesNewOrEditPage> {
  final Map<String, TextEditingController> _textEditingControllerMap = {};

  String? _id;
  String? _type;
  Map<String, dynamic> _option = {};

  List<String> get _engineOptionKeys {
    switch (_type) {
      case kOcrEngineTypeYoudao:
        return YoudaoOcrEngine.optionKeys;
    }
    return [];
  }

  @override
  void initState() {
    if (widget.ocrEngineConfig != null) {
      _id = widget.ocrEngineConfig?.id;
      _type = widget.ocrEngineConfig?.type;
      _option = widget.ocrEngineConfig?.option ?? {};

      for (var optionKey in _engineOptionKeys) {
        var textEditingController =
            TextEditingController(text: _option[optionKey]);
        _textEditingControllerMap[optionKey] = textEditingController;
      }
    } else {
      _id = shortid.generate();
      _type = widget.ocrEngineType;
    }
    super.initState();
  }

  void _handleClickOk() {
    context.read<Settings>().privateOcrEngine(_id!).updateOrCreate(
          type: _type,
          option: _option,
        );

    (sharedOcrClient.adapter as AutoloadOcrClientAdapter).renew(_id!);

    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomizedAppBar(
      title: widget.ocrEngineConfig != null
          ? OcrEngineName(widget.ocrEngineConfig!)
          : Text(t.app.ocr_engines_new.title),
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
            t.app.ocr_engines_new.engine_type.title,
          ),
          children: [
            ListTile(
              leading: _type == null ? null : OcrEngineIcon(_type!),
              title: _type == null
                  ? Text(t.please_choose)
                  : Text('ocr_engine.$_type'),
              trailing: widget.editable ? const ListTileChevron() : null,
              onTap: widget.editable
                  ? () async {
                      final newEngineType = await context.push<String?>(
                        PageId.settingsOcrEngineTypes,
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
        if (widget.editable && _type != null)
          ListSection(
            header: Text(
              t.app.ocr_engines_new.option.title,
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
        if (widget.editable && widget.ocrEngineConfig != null)
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
                onTap: () {
                  if (_id != null) {
                    context.read<Settings>().privateOcrEngine(_id!).delete();
                  }
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
