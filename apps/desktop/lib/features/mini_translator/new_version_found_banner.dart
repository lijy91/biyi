import 'package:biyi_app/i18n/strings.g.dart';
import 'package:biyi_app/services/api_client.dart';
import 'package:biyi_app/utils/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:uikit/uikit.dart';
import 'package:url_launcher/url_launcher.dart';

class NewVersionFoundBanner extends StatelessWidget {
  const NewVersionFoundBanner({
    super.key,
    required this.latestVersion,
  });

  final Version latestVersion;

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Container(
      color: themeData.colorScheme.primary,
      width: double.infinity,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(
          left: 0,
          right: 0,
        ),
        padding: const EdgeInsets.only(
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
                text: t.app.home.newversion_banner_text_found_new_version(
                  version: latestVersion.version,
                ),
              ),
              style: themeData.typography.base.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(child: Container()),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: t.app.home.newversion_banner_btn_update,
                    style: const TextStyle(
                      color: Colors.white,
                      height: 1.3,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.white,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        Uri url = Uri.parse(
                          '${sharedEnv.webUrl}/release-notes#${latestVersion.version}',
                        );
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                  ),
                ],
              ),
              style: themeData.typography.base.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
