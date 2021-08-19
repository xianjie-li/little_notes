import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// 快捷进行提示
void tips(BuildContext context, String msg, Color? color) {
  Fluttertoast.showToast(
      msg: msg,
      backgroundColor: color,
      gravity: ToastGravity.BOTTOM,
  );
}

class ConfirmTip {
  Text title;
  Text confirmText;
  Text cancelText;

  ConfirmTip({
    this.title = const Text('确认要进行此操作吗?'),
    this.confirmText = const Text('确认'),
    this.cancelText = const Text('取消'),
  });
}

/// 快捷的进行询问操作
Future<bool?> confirmTips(BuildContext context, ConfirmTip confirmTip) {
  return showDialog<bool?>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: confirmTip.title,
          actions: [
            TextButton(
              child: confirmTip.cancelText,
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: confirmTip.confirmText,
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.red),
                  textStyle: MaterialStateProperty.all(
                      TextStyle(fontWeight: FontWeight.bold))),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      });
}
