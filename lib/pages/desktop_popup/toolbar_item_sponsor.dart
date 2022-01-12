import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../includes.dart';

class ToolbarItemSponsor extends StatefulWidget {
  @override
  _ToolbarItemSponsorState createState() => _ToolbarItemSponsorState();
}

class _ToolbarItemSponsorState extends State<ToolbarItemSponsor> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 22,
      margin: EdgeInsets.only(
        right: 10,
      ),
      child: CustomButton(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: EdgeInsets.only(left: 6, right: 6),
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(2),
        child: Row(
          children: [
            Icon(
              IcoMoonIcons.heart,
              size: 14,
              color: Colors.red,
            ),
            SizedBox(width: 4),
            Text(
              'page_home.btn_sponsor'.tr(),
              style: TextStyle(
                fontSize: 11,
                color: Colors.red,
              ),
            ),
          ],
        ),
        onPressed: () async {
          String url = '${sharedEnv.webUrl}/sponsor';
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
      ),
    );
  }
}
