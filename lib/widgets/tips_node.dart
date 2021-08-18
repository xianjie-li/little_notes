import 'package:flutter/material.dart';
import 'package:little_notes/style/style_vars.dart';

class TipsNode extends StatelessWidget {
  const TipsNode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FractionallySizedBox(
          widthFactor: 0.3,
          child: Image.asset('lib/assets/twemoji/263a.png', fit: BoxFit.cover,),
        ),
        Divider(color: Colors.transparent,),
        Text('暂无数据', style: TextStyle(color: StyleVars.colorSecond),),
      ],
    );
  }
}
