import 'package:flutter/material.dart';
import 'package:little_notes/style/style_vars.dart';

class HomeTitleButton extends StatelessWidget {
  const HomeTitleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: Scaffold.of(context).openDrawer,
      child: Row(
        children: [
          Image.asset(
            'lib/assets/1f4d8.png',
            width: 20,
          ),
          Divider(
            indent: 4,
          ),
          Text(
            '呵呵哒',
            style: TextStyle(color: StyleVars.colorTitle),
          ),
          Icon(
            Icons.arrow_drop_down,
            color: StyleVars.colorTitle,
          ),
        ],
      ),
    );
  }
}
