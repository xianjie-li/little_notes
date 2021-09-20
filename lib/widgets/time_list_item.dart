import 'package:flutter/material.dart';
import 'package:little_notes/style/style_vars.dart';
import 'package:little_notes/widgets/circular_image.dart';

/* 时间线列表项 */
class TimeListItem extends StatelessWidget {
  final String title;
  final String trailing;
  final Color? trailingColor;
  final Color? iconColor;
  final String icon;
  final String? subtitle;

  const TimeListItem({
    Key? key,
    required this.title,
    this.subtitle,
    this.trailingColor = StyleVars.theme,
    this.iconColor = StyleVars.theme,
    required this.trailing,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {},
      leading: CircularImage(
        icon: icon,
        color: iconColor,
      ),
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle!),
      trailing: Text(
        trailing,
        style: TextStyle(
            color: trailingColor,
            fontSize: StyleVars.fsLG,
            fontWeight: FontWeight.w600),
      ),
      // visualDensity: VisualDensity.compact,
      contentPadding:
          EdgeInsets.symmetric(horizontal: StyleVars.padding, vertical: 2),
    );
  }
}
