import 'package:flutter/material.dart';
import 'package:little_notes/style/style_vars.dart';

/* 时间线列表项 */
class TimeListItem extends StatelessWidget {
  final String title;
  final String trailing;
  final String icon;
  final String? subtitle;

  const TimeListItem({
    Key? key,
    required this.title,
    this.subtitle,
    required this.trailing,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: () {},
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.pink.shade100,
            borderRadius: BorderRadius.all(Radius.circular(50))
        ),
        child: Center(
          child: Image.asset('lib/assets/twemoji/$icon.png', width: 28,),
        ),
      ),
      title: Text(title),
      subtitle: subtitle == null ? null : Text(subtitle!),
      trailing: Text(trailing, style: TextStyle(color: StyleVars.themeFontColor, fontSize: StyleVars.fsLG, fontWeight: FontWeight.w600),),
      // visualDensity: VisualDensity.compact,
      contentPadding: EdgeInsets.symmetric(horizontal: StyleVars.padding, vertical: 2),
    );
  }
}
