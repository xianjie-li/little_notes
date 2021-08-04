import 'package:flutter/material.dart';
import 'package:little_notes/widgets/keyboard_button.dart';

/* 定制键盘 */
class Keyboard extends StatelessWidget {
  const Keyboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, -1),
            )
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          )
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                KeyboardButton('1', color: Colors.red,),
                KeyboardButton('4', color: Colors.orange,),
                KeyboardButton('7', color: Colors.yellow.shade700,),
                KeyboardButton('·', color: Colors.green, bigFont: true,),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                KeyboardButton('2', color: Colors.cyan,),
                KeyboardButton('5', color: Colors.blue,),
                KeyboardButton('8', color: Colors.purple,),
                KeyboardButton('0', color: Colors.deepPurple,),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                KeyboardButton('3', color: Colors.blueAccent,),
                KeyboardButton('6', color: Colors.teal,),
                KeyboardButton('9', color: Colors.lightGreen,),
                KeyboardButton('=', color: Colors.blue, bigFont: true,),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                KeyboardButton('删除', color: Colors.deepOrange,),
                KeyboardButton('+', color: Colors.green, bigFont: true,),
                KeyboardButton('-', color: Colors.red, bigFont: true,),
                KeyboardButton('提交', color: Colors.pink,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
