import 'package:app_food_mobile/constants.dart';
import 'package:flutter/material.dart';

enum DialogsAction { yes, cancel }

class AlertDialogs {
  static Future<DialogsAction> yesCancelDialog(
      BuildContext context, String title, String body) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.apply(color: kPrimaryColor),
            ),
            content: Text(
              body,
              style: Theme.of(context).textTheme.headline4,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(DialogsAction.yes);
                  },
                  child: Text("Xác nhận")),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(DialogsAction.cancel);
                  },
                  child: Text("Hủy bỏ")),
            ],
          );
        });

    return (action != null) ? action : DialogsAction.cancel;
  }
}
