import 'package:flutter/material.dart';
import 'package:little_notes/style/style_vars.dart';

/* 图标入口按钮 */
class EntryIconBtn extends StatelessWidget {
  final String icon;
  final String text;

  const EntryIconBtn({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Stack(
        children: [
          Image.asset(icon, width: 42),
          Positioned(
            right: 2,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 0, horizontal: 2),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius:
                    BorderRadius.all(Radius.circular(StyleVars.radiusSM)),
                border: Border.all(color: StyleVars.theme.shade300)
              ),
              child: Text(text, style: TextStyle(height: 1.3, fontSize: 10),),
            ))
        ],
      ),
    );
  }
}
