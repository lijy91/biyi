import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ocr_engine_youdao/ocr_engine_youdao.dart';

import '../../includes.dart';

class OcrEngineNewPage extends StatefulWidget {
  final bool editable;
  final OcrEngineConfig ocrEngineConfig;

  const OcrEngineNewPage({
    Key key,
    this.editable = true,
    this.ocrEngineConfig,
  }) : super(key: key);

  @override
  _OcrEngineNewPageState createState() => _OcrEngineNewPageState();
}

class _OcrEngineNewPageState extends State<OcrEngineNewPage> {
  Map<String, TextEditingController> _textEditingControllerMap = {};

  String _identifier;
  String _type;
  Map<String, dynamic> _option = Map();

  List<String> get _engineOptionKeys {
    switch (_type) {
      case kOcrEngineTypeYoudao:
        return YoudaoOcrEngine.optionKeys;
    }
    return [];
  }

  void initState() {
    if (widget.ocrEngineConfig != null) {
      _identifier = widget.ocrEngineConfig.identifier;
      _type = widget.ocrEngineConfig.type;
      _option = widget.ocrEngineConfig.option;

      for (var optionKey in _engineOptionKeys) {
        var textEditingController =
            TextEditingController(text: _option[optionKey]);
        _textEditingControllerMap[optionKey] = textEditingController;
      }
    }
    super.initState();
  }

  void _handleClickOk() async {
    await sharedLocalDb.privateOcrEngine(_identifier).updateOrCreate(
          type: _type,
          option: _option,
        );
    await sharedLocalDb.write();

    Navigator.of(context).pop();
  }

  Widget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: widget.ocrEngineConfig != null
          ? Text.rich(
              TextSpan(
                text: R
                    .string('common.ocr_engine.${widget.ocrEngineConfig.type}'),
                children: [
                  TextSpan(
                    text: ' (${widget.ocrEngineConfig.shortId})',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  )
                ],
              ),
            )
          : Text('添加文字识别引擎'),
      actions: [
        if (widget.editable)
          CustomAppBarActionItem(
            text: '保存',
            onPressed: _handleClickOk,
          ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return PreferenceList(
      children: [
        PreferenceListSection(
          title: Text('引擎类型'),
          children: [
            PreferenceListItem(
              icon: _type == null
                  ? null
                  : OcrEngineIcon(
                      OcrEngineConfig(type: _type),
                    ),
              title: _type == null
                  ? Text('请选择')
                  : Text(R.string('common.ocr_engine.$_type')),
              accessoryView: widget.editable ? null : Container(),
              onTap: widget.editable
                  ? () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => OcrEngineTypeChooserPage(
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
        if (widget.editable && _type != null)
          PreferenceListSection(
            title: Text('选项'),
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
                  title: Text('无选项'),
                  accessoryView: Container(),
                ),
            ],
          ),
        if (widget.editable && widget.ocrEngineConfig != null)
          PreferenceListSection(
            title: Text(''),
            children: [
              PreferenceListItem(
                title: Center(
                  child: Text(
                    '删除',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                accessoryView: Container(),
                onTap: () async {
                  await sharedLocalDb.privateOcrEngine(_identifier).delete();
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
