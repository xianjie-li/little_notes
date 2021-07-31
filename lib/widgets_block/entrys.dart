import 'package:flutter/material.dart';
import 'package:little_notes/widgets/entry_icon_botton.dart';

class Entrys extends StatelessWidget {
  const Entrys({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EntryIconBtn(
          icon: 'lib/assets/chart.png',
          text: '报表',
        ),
        Divider(
          height: 8,
        ),
        EntryIconBtn(
          icon: 'lib/assets/note.png',
          text: '账单',
        ),
      ],
    );
  }
}
