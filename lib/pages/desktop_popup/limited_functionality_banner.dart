import 'package:bot_toast/bot_toast.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:screen_capturer/screen_capturer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../includes.dart';

class _AllowAccessListItem extends StatelessWidget {
  final String title;
  final bool allowed;
  final VoidCallback? onTappedTryAllow;
  final VoidCallback? onTappedGoSettings;

  const _AllowAccessListItem({
    Key? key,
    required this.title,
    required this.allowed,
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
              text: 'page_home.limited_banner_btn_allow'.tr(),
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: Colors.white,
              ),
              recognizer: TapGestureRecognizer()..onTap = onTappedTryAllow,
            ),
          if (onTappedTryAllow != null) TextSpan(text: ' / '),
          if (onTappedGoSettings != null)
            TextSpan(
              text: 'page_home.limited_banner_btn_go_settings'.tr(),
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
          .bodyText2!
          .copyWith(color: Colors.white, fontSize: 13),
    );
  }
}

class LimitedFunctionalityBanner extends StatelessWidget {
  final bool isAllowedScreenCaptureAccess;
  final bool isAllowedScreenSelectionAccess;
  final VoidCallback onTappedRecheckIsAllowedAllAccess;

  const LimitedFunctionalityBanner({
    Key? key,
    required this.isAllowedScreenCaptureAccess,
    required this.isAllowedScreenSelectionAccess,
    required this.onTappedRecheckIsAllowedAllAccess,
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
                text: 'page_home.limited_banner_title'.tr(),
              ),
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
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
                      title:
                          'page_home.limited_banner_text_screen_capture'.tr(),
                      allowed: isAllowedScreenCaptureAccess,
                      onTappedTryAllow: () {
                        ScreenCapturer.instance.requestAccess();
                        BotToast.showText(
                          text: 'page_home.limited_banner_msg_allow_access_tip'
                              .tr(),
                          align: Alignment.center,
                          duration: Duration(seconds: 5),
                        );
                      },
                      onTappedGoSettings: () {
                        ScreenCapturer.instance.requestAccess(
                          onlyOpenPrefPane: true,
                        );
                      },
                    ),
                  if (kIsMacOS)
                    _AllowAccessListItem(
                      title:
                          'page_home.limited_banner_text_screen_selection'.tr(),
                      allowed: isAllowedScreenSelectionAccess,
                      onTappedTryAllow: () {
                        screenTextExtractor.requestAccess();
                        BotToast.showText(
                          text: 'page_home.limited_banner_msg_allow_access_tip'
                              .tr(),
                          align: Alignment.center,
                          duration: Duration(seconds: 5),
                        );
                      },
                      onTappedGoSettings: () {
                        screenTextExtractor.requestAccess(
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
                    message: 'page_home.limited_banner_tip_help'.tr(),
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      child: Icon(
                        FluentIcons.question_circle_20_regular,
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
                        text: 'page_home.limited_banner_btn_check_again'.tr(),
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
                      .bodyText2!
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
