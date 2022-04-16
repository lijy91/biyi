import 'package:biyi/includes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './custom_app_bar_back_button.dart';
import './custom_app_bar_close_button.dart';

export './custom_app_bar_action_item.dart';
export './custom_app_bar_back_button.dart';
export './custom_app_bar_close_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final Widget? title;
  final List<Widget>? actions;

  const CustomAppBar({
    Key? key,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.title,
    this.actions,
  })  : assert(automaticallyImplyLeading != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);

    final bool canPop = parentRoute?.canPop ?? false;
    final bool useCloseButton =
        parentRoute is PageRoute<dynamic> && parentRoute.fullscreenDialog;

    Widget? leading = this.leading;
    if (leading == null && automaticallyImplyLeading) {
      if (canPop) {
        leading = useCloseButton
            ? const CustomAppBarCloseButton()
            : const CustomAppBarBackButton();
      }
    }

    AppBar appBar = AppBar(
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: title,
      actions: actions,
    );
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 16,
          ),
        ],
      ),
      child: appBar,
    );
  }

  @override
  Size get preferredSize {
    return Size.fromHeight(
      kIsAndroid ? kToolbarHeight : kMinInteractiveDimensionCupertino,
    );
  }
}
