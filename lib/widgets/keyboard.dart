import 'package:flutter/material.dart';
import 'package:little_notes/common/price_calcer.dart';
import 'package:little_notes/widgets/keyboard_button.dart';

/* 定制键盘 */
class Keyboard extends StatelessWidget {
  final VoidCallback? onSubmit;
  final VoidCallback? onDelete;
  final VoidCallback? onClear;
  final ValueChanged<String>? onKeyInput;

  const Keyboard(
      {Key? key, this.onSubmit, this.onDelete, this.onKeyInput, this.onClear})
      : super(key: key);

  void handleKeyDown(String keycode) {
    if (onKeyInput != null) onKeyInput!(keycode);
  }

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
          )),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                KeyboardButton(
                  '1',
                  color: Colors.red,
                  onTap: () => handleKeyDown('1'),
                ),
                KeyboardButton(
                  '4',
                  color: Colors.orange,
                  onTap: () => handleKeyDown('4'),
                ),
                KeyboardButton(
                  '7',
                  color: Colors.yellow.shade700,
                  onTap: () => handleKeyDown('7'),
                ),
                KeyboardButton(
                  '·',
                  color: Colors.green,
                  bigFont: true,
                  onTap: () => handleKeyDown('.'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                KeyboardButton(
                  '2',
                  color: Colors.cyan,
                  onTap: () => handleKeyDown('2'),
                ),
                KeyboardButton(
                  '5',
                  color: Colors.blue,
                  onTap: () => handleKeyDown('5'),
                ),
                KeyboardButton(
                  '8',
                  color: Colors.purple,
                  onTap: () => handleKeyDown('8'),
                ),
                KeyboardButton(
                  '0',
                  color: Colors.deepPurple,
                  onTap: () => handleKeyDown('0'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                KeyboardButton(
                  '3',
                  color: Colors.blueAccent,
                  onTap: () => handleKeyDown('3'),
                ),
                KeyboardButton(
                  '6',
                  color: Colors.teal,
                  onTap: () => handleKeyDown('6'),
                ),
                KeyboardButton(
                  '9',
                  color: Colors.lightGreen,
                  onTap: () => handleKeyDown('9'),
                ),
                KeyboardButton(
                  '删除',
                  color: Colors.deepOrange,
                  onTap: onDelete,
                  onLongPress: onClear,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                KeyboardButton(
                  '+',
                  color: Colors.green,
                  onTap: () => handleKeyDown(PriceCalcer.addSignal),
                  bigFont: true,
                ),
                KeyboardButton(
                  '-',
                  color: Colors.red,
                  onTap: () => handleKeyDown(PriceCalcer.subSignal),
                  bigFont: true,
                ),
                KeyboardButton(
                  '提交',
                  color: Colors.pink,
                  onTap: onSubmit,
                  flex: 2,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
