import 'package:flutter/material.dart';
import 'package:little_notes/style/style_vars.dart';

class EmptyNode extends StatelessWidget {
  final Text text;
  final ElevatedButton? button;
  final double? space;

  const EmptyNode({Key? key, required this.text, this.button, this.space = 50})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          height: space,
          color: Colors.transparent,
        ),
        Image.asset(
          "lib/assets/twemoji/1f5f3.png",
          width: 90,
          fit: BoxFit.cover,
        ),
        Divider(
          color: Colors.transparent,
          height: StyleVars.paddingSM,
        ),
        text,
        Divider(
          color: Colors.transparent,
        ),
        if (button != null) button!,
      ],
    );
  }
}
