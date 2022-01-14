import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../includes.dart';

class NewVersionFoundBanner extends StatelessWidget {
  final Version latestVersion;

  const NewVersionFoundBanner({
    Key key,
    this.latestVersion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: 'page_home.newversion_banner_text_found_new_version'
                    .tr(args: [latestVersion?.version ?? '']),
              ),
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            Expanded(child: Container()),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'page_home.newversion_banner_btn_update'.tr(),
                    style: TextStyle(
                      color: Colors.white,
                      height: 1.3,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        String url =
                            '${sharedEnv.webUrl}/release-notes#${latestVersion.version}';
                        if (await canLaunch(url)) {
                          await launch(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                  ),
                ],
              ),
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
