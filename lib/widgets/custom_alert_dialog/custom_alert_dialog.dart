import 'package:flutter/material.dart';

import '../../includes.dart';

const kDialogActionTypePrimary = 'primary';
const kDialogActionTypeSecondary = 'secondary';
const kDialogActionTypeSuccess = 'success';
const kDialogActionTypeDanger = 'danger';

class CustomDialogAction extends StatelessWidget {
  String? type;
  final bool processing;
  final Widget child;
  final VoidCallback? onPressed;

  CustomDialogAction({
    Key? key,
    this.type,
    this.processing = false,
    required this.child,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      child: CustomButton.filled(
        borderRadius: const BorderRadius.all(Radius.circular(2.0)),
        padding: EdgeInsets.zero,
        processing: processing,
        child: child,
        onPressed: onPressed,
      ),
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  final Widget? title;
  final Widget? content;
  final List<Widget>? actions;

  const CustomAlertDialog({
    Key? key,
    this.title,
    this.content,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: DefaultTextStyle(
        style: Theme.of(context).textTheme.bodyText2!,
        child: Container(
          constraints: const BoxConstraints(
            minHeight: 100,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).dialogBackgroundColor,
            borderRadius: BorderRadius.circular(2),
          ),
          margin: const EdgeInsets.only(left: 40, right: 40),
          padding: const EdgeInsets.only(top: 20, bottom: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 16,
                      ),
                  child: title ?? Container(),
                ),
              ),
              if (content != null)
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: 18,
                    bottom: 30,
                  ),
                  child: content,
                ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: <Widget>[
                    for (var i = 0; i < (actions ?? []).length; i++)
                      Builder(
                        builder: (_) {
                          CustomDialogAction action =
                              actions![i] as CustomDialogAction;
                          if (action.type == null && i == actions!.length - 1) {
                            action.type = kDialogActionTypePrimary;
                          }
                          return Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: action,
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
