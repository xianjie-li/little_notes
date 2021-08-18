import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart';

class EmojiPickerPage extends StatefulWidget {
  static const pathName = 'emoji_picker_page';

  const EmojiPickerPage({Key? key}) : super(key: key);

  @override
  _EmojiPickerPageState createState() => _EmojiPickerPageState();
}

class _EmojiPickerPageState extends State<EmojiPickerPage> {
  List<String> emojis = [];

  @override
  void initState() {
    super.initState();

    rootBundle.loadString('AssetManifest.json').then((value) {
      Map<String, dynamic> files = jsonDecode(value);
      List<String> _emojis = files.keys
          .where((element) => element.startsWith('lib/assets/twemoji/'))
          .toList();

      setState(() {
        emojis = _emojis;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('选择图标'),
      ),
      body: GridView.builder(
        itemCount: emojis.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 6,
        ),
        itemBuilder: (_, index) => InkWell(
          onTap: () {
            Navigator.pop(context, basenameWithoutExtension(emojis[index]));
          },
          child: Container(
            padding: EdgeInsets.all(16),
            child: Image.asset(emojis[index]),
          ),
        ),
      ),
    );
  }
}
