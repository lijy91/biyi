import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../includes.dart';

class _AllowAccessListItem extends StatelessWidget {
  final String title;
  final bool allowed;
  final VoidCallback onTappedTryAllow;
  final VoidCallback onTappedGoSettings;

  const _AllowAccessListItem({
    Key key,
    this.title,
    this.allowed,
    this.onTappedTryAllow,
    this.onTappedGoSettings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: allowed ? '✅' : '❌',
        children: [
          TextSpan(text: '  '),
          TextSpan(text: '$title'),
          TextSpan(text: '      '),
          if (onTappedTryAllow != null)
            TextSpan(
              text: '授权',
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: Colors.white,
              ),
              recognizer: TapGestureRecognizer()..onTap = onTappedTryAllow,
            ),
          if (onTappedTryAllow != null) TextSpan(text: ' / '),
          if (onTappedGoSettings != null)
            TextSpan(
              text: '前往设置',
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: Colors.white,
              ),
              recognizer: TapGestureRecognizer()..onTap = onTappedGoSettings,
            ),
        ],
      ),
      style: Theme.of(context)
          .textTheme
          .bodyText2
          .copyWith(color: Colors.white, fontSize: 13),
    );
  }
}

class LimitedFunctionalityBanner extends StatelessWidget {
  final bool isAllowedScreenCaptureAccess;
  final bool isAllowedScreenSelectionAccess;
  final VoidCallback onTappedRecheckIsAllowedAllAccess;

  const LimitedFunctionalityBanner({
    Key key,
    this.isAllowedScreenCaptureAccess,
    this.isAllowedScreenSelectionAccess,
    this.onTappedRecheckIsAllowedAllAccess,
  }) : super(key: key);

  bool get _isAllowedAllAccess =>
      isAllowedScreenCaptureAccess && isAllowedScreenSelectionAccess;

  @override
  Widget build(BuildContext context) {
    if (_isAllowedAllAccess) return Container();

    return Container(
      color: Colors.orange,
      width: double.infinity,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          left: 0,
          right: 0,
        ),
        padding: EdgeInsets.only(
          top: 12,
          bottom: 12,
          left: 18,
          right: 18,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: '当前功能受限，请根据以下提示进行检查及设置。',
              ),
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Container(
              padding: EdgeInsets.only(top: 6, bottom: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (kIsMacOS)
                    _AllowAccessListItem(
                      title: '授予屏幕录制权限',
                      allowed: isAllowedScreenCaptureAccess,
                      onTappedTryAllow: () {
                        screenTextExtractor.requestScreenCaptureAccess();
                        BotToast.showText(
                          text: '点击「授权」后如无任何响应，请点击「前往设置」进行手动设置。',
                          align: Alignment.center,
                          duration: Duration(seconds: 5),
                        );
                      },
                      onTappedGoSettings: () {
                        screenTextExtractor.requestScreenCaptureAccess(
                          onlyOpenPrefPane: true,
                        );
                      },
                    ),
                  if (kIsMacOS)
                    _AllowAccessListItem(
                      title: '授予辅助功能权限',
                      allowed: isAllowedScreenSelectionAccess,
                      onTappedTryAllow: () {
                        screenTextExtractor.requestScreenSelectionAccess();
                        BotToast.showText(
                          text: '点击「授权」后如无任何响应，请点击「前往设置」进行手动设置。',
                          align: Alignment.center,
                          duration: Duration(seconds: 5),
                        );
                      },
                      onTappedGoSettings: () {
                        screenTextExtractor.requestScreenSelectionAccess(
                          onlyOpenPrefPane: true,
                        );
                      },
                    ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 18,
                  height: 18,
                  child: Tooltip(
                    message: '查看帮助文档',
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Icon(
                        CupertinoIcons.question_circle,
                        color: Colors.white,
                        size: 18,
                      ),
                      onPressed: () async {
                        String url = '${sharedEnv.webUrl}/docs';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '重新检查',
                        style: TextStyle(
                          color: Colors.white,
                          height: 1.3,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = onTappedRecheckIsAllowedAllAccess,
                      ),
                    ],
                  ),
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      .copyWith(color: Colors.white, fontSize: 14),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
