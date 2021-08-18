import 'package:flutter/material.dart';
import 'package:little_notes/style/style_vars.dart';
import 'package:little_notes/widgets/color_list.dart';

class ColorPicker extends StatefulWidget {
  final String? color;
  final ValueChanged<String>? onChange;

  const ColorPicker({
    Key? key,
    this.color,
    this.onChange
  }) : super(key: key);

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  Color? get viewColor {
    return widget.color == null ? null : Color(int.parse(widget.color!));
  }

  void showPicker() {
    showDialog(
        context: context,
        builder: (_) {
          return Dialog(
            child: Container(
              height: 300,
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    '选择一个颜色',
                    style: TextStyle(fontSize: StyleVars.fsLG),
                  ),
                  Divider(
                    color: Colors.transparent,
                    height: StyleVars.padding,
                  ),
                  Expanded(child: ColorList(
                    onSelect: (_color) {
                      Navigator.pop(context);
                      if (widget.onChange != null) widget.onChange!(_color);
                    },
                  )),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: showPicker,
      child: Container(
        color: viewColor,
        height: 20,
        child: Text(' '),
      ),
    );
  }
}
