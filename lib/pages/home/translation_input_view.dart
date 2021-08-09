import 'dart:convert';
import 'dart:ui';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:screen_text_extractor/screen_text_extractor.dart';

import '../../../includes.dart';

class TranslationInputView extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  final ExtractedData extractedData;

  final String translationMode;
  final ValueChanged<String> onTranslationModeChanged;
  final String inputSetting;

  final VoidCallback onClickExtractTextFromScreenCapture;
  final VoidCallback onClickExtractTextFromClipboard;

  final VoidCallback onButtonTappedClear;
  final VoidCallback onButtonTappedTrans;

  const TranslationInputView({
    Key key,
    this.focusNode,
    this.controller,
    this.onChanged,
    this.extractedData,
    this.translationMode,
    this.onTranslationModeChanged,
    this.inputSetting,
    this.onClickExtractTextFromScreenCapture,
    this.onClickExtractTextFromClipboard,
    this.onButtonTappedClear,
    this.onButtonTappedTrans,
  }) : super(key: key);

  Widget _buildTextGetters(BuildContext context) {
    return Row(
      children: [
        Tooltip(
          message:
              '当前翻译模式：${this.translationMode == kTranslationModeAuto ? '自动' : '手动'}',
          child: SizedBox(
            width: 30,
            height: 26,
            child: CustomButton(
              padding: EdgeInsets.zero,
              child: Container(
                width: 30,
                height: 26,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(
                      IcoMoonIcons.bullseye,
                      size: 16,
                      color: this.translationMode == kTranslationModeAuto
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).iconTheme.color,
                    ),
                    if (this.translationMode == kTranslationModeAuto)
                      Positioned(
                        bottom: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(2),
                          ),
                          padding: EdgeInsets.only(
                            left: 2,
                            right: 2,
                            top: 1.4,
                            bottom: 1.4,
                          ),
                          child: Text(
                            'AUTO',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 5.4,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              onPressed: () {
                String newTranslationMode =
                    translationMode == kTranslationModeAuto
                        ? kTranslationModeManual
                        : kTranslationModeAuto;

                UserPreference userPreference =
                    sharedLocalDb.preference(kPrefTranslationMode).get();
                if (userPreference != null) {
                  sharedLocalDb.preference(kPrefTranslationMode).update(
                        value: newTranslationMode,
                      );
                } else {
                  sharedLocalDb.preferences.create(
                    key: kPrefTranslationMode,
                    value: newTranslationMode,
                  );
                }
                sharedLocalDb.write();
                this.onTranslationModeChanged(newTranslationMode);
              },
            ),
          ),
        ),
        SizedBox(
          height: 20,
          child: VerticalDivider(
            width: 8,
          ),
        ),
        Tooltip(
          message: '截取屏幕区域',
          child: SizedBox(
            width: 30,
            height: 26,
            child: CustomButton(
              padding: EdgeInsets.zero,
              child: Icon(
                IcoMoonIcons.crop,
                size: 17,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: onClickExtractTextFromScreenCapture,
            ),
          ),
        ),
        Tooltip(
          message: '翻译剪切板内容',
          child: SizedBox(
            width: 30,
            height: 26,
            child: CustomButton(
              padding: EdgeInsets.zero,
              child: Icon(
                IcoMoonIcons.clipboard,
                size: 16,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: onClickExtractTextFromClipboard,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 56,
          height: 24,
          child: CustomButton.outlined(
            padding: EdgeInsets.zero,
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(2),
            child: Text(
              '清空',
              style: TextStyle(fontSize: 12),
            ),
            onPressed: this.onButtonTappedClear,
          ),
        ),
        SizedBox(width: 10),
        SizedBox(
          width: 56,
          height: 24,
          child: CustomButton.filled(
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.circular(2),
            child: Text(
              '翻译',
              style: TextStyle(fontSize: 12),
            ),
            onPressed: this.onButtonTappedTrans,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isTextDetecting =
        (extractedData?.base64Image != null && extractedData?.text == null);

    return Container(
      margin: EdgeInsets.only(
        left: 12,
        right: 12,
        top: 0,
        bottom: 12,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(2),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              offset: Offset(0.0, 1.0),
              blurRadius: 3.0,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              child: Stack(
                children: [
                  CupertinoTextField(
                    focusNode: focusNode,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                    ),
                    selectionHeightStyle: BoxHeightStyle.max,
                    controller: this.controller,
                    padding: EdgeInsets.only(
                      left: 12,
                      right: 12,
                      top: 14,
                      bottom: 12,
                    ),
                    style:
                        CupertinoTheme.of(context).textTheme.textStyle.copyWith(
                              fontSize: 14,
                              height: 1.2,
                            ),
                    placeholder: '在此输入要翻译的单词或文字',
                    maxLines:
                        inputSetting == kInputSettingSubmitWithEnter ? 1 : 6,
                    minLines: 1,
                    onChanged: this.onChanged,
                    onSubmitted: (newValue) {
                      onButtonTappedTrans();
                    },
                  ),
                  if (isTextDetecting)
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.only(left: 12, right: 12),
                        color: Theme.of(context).canvasColor,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                SpinKitDoubleBounce(
                                  color:
                                      Theme.of(context).textTheme.caption.color,
                                  size: 18.0,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  '正在提取文字...',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .color,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            Expanded(child: Container()),
                            if (extractedData?.imagePath != null)
                              Container(
                                width: 20,
                                height: 20,
                                child: CustomButton(
                                  padding: EdgeInsets.zero,
                                  child: Tooltip(
                                    message: '查看正在识别的图片',
                                    child: Icon(
                                      IcoMoonIcons.image,
                                      size: 16,
                                      color: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .color,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      FadeInPageRoute(
                                        builder: (context) => ImageViewerPage(
                                          [extractedData.imagePath],
                                          initialIndex: 0,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Divider(
              height: 0,
              indent: 12,
              endIndent: 12,
            ),
            Container(
              padding: EdgeInsets.only(
                left: 6,
                right: 12,
                top: 8,
                bottom: 8,
              ),
              child: Row(
                children: [
                  _buildTextGetters(context),
                  Expanded(child: Container()),
                  _buildActionButtons(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
