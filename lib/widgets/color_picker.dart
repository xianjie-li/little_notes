import 'package:flutter/material.dart';
import 'package:little_notes/style/style_vars.dart';
import 'package:little_notes/widgets/color_list.dart';

class ColorPicker extends StatefulWidget {
  const ColorPicker({Key? key}) : super(key: key);

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
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
                  Text('选择一个颜色', style: TextStyle(fontSize: StyleVars.fsLG),),
                  Divider(color: Colors.transparent, height: StyleVars.padding,),
                  Expanded(child: ColorList()),
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
        child: Text('           '),
      ),
    );
  }
}
