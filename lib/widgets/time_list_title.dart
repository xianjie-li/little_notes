import 'dart:math';

import 'package:flutter/material.dart';
import 'package:little_notes/style/style_vars.dart';

/* 时间线标题 */
class TimeListTitle extends StatelessWidget {
  final String title;
  final String? trailing;

  const TimeListTitle({Key? key, required this.title, this.trailing})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      EdgeInsets.symmetric(vertical: 4, horizontal: StyleVars.paddingSM),
      margin: EdgeInsets.symmetric(
          vertical: StyleVars.paddingSM, horizontal: StyleVars.padding),
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.all(Radius.circular(StyleVars.radius))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(color: StyleVars.colorSecond),
          ),
          if (trailing != null)
            Text(
              trailing!,
              style: TextStyle(color: StyleVars.colorSecond),
            ),
        ],
      ),
    );
  }
}

