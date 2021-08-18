import 'package:flutter/material.dart';

void tips(BuildContext context, String msg, Color? color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(msg),
    behavior: SnackBarBehavior.floating,
    backgroundColor: color,
  ));
}
