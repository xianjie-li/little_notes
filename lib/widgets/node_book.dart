import 'package:flutter/material.dart';
import 'package:little_notes/style/style_vars.dart';

/* 账本列表中的一个账本项 */
class NoteBook extends StatelessWidget {
  final String label;
  final String desc;
  final String icon;
  final Color color;
  // 显示添加按钮
  final bool? isAddButton;
  final bool? selected;
  final GestureTapCallback? onTap;

  const NoteBook({
    Key? key,
    this.label = '',
    this.desc = '',
    this.icon = '1f9c1',
    this.color = Colors.white,
    this.isAddButton = false,
    this.selected = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Card(
          color: color,
          elevation: 2,
          child: InkWell(
            onTap: onTap,
            child: buildMain(),
          ),
        ),
        if (selected!) Positioned(
          right: 8,
          top: -1,
          child: Icon(Icons.bookmark_outlined, color: Colors.pink.shade400,),
        )
      ],
    );
  }

  Widget buildMain() {
    if (isAddButton!) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, size: 42, color: StyleVars.colorSecond,),
            Text('新建账本', style: TextStyle(fontSize: StyleVars.fs),)
          ],
        ),
      );
    }

    return Padding(
      child: DefaultTextStyle(
        style: TextStyle(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis, ),
            Text(desc, style: TextStyle(color: Colors.white70),),
            Spacer(),
            Align(
              child: Image.asset('lib/assets/twemoji/$icon.png', width: 80),
              alignment: Alignment(2.3, 0),
            ),
          ],
        ),
      ),
      padding: EdgeInsets.only(top: StyleVars.padding, left: StyleVars.padding, right: StyleVars.padding),
    );
  }
}
