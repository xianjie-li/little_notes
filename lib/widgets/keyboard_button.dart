import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/* 定制键盘按钮 */
class KeyboardButton extends StatefulWidget {
  final String label;
  final bool bigFont;
  final Color? color;

  const KeyboardButton(this.label, {Key? key, this.bigFont = false, this.color})
      : super(key: key);

  @override
  _KeyboardButtonState createState() => _KeyboardButtonState();
}

class _KeyboardButtonState extends State<KeyboardButton> {
  bool keyDown = false;

  void handleTapFinish() {
    setState(() {
      keyDown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GestureDetector(
      onTapDown: (e) {
        setState(() {
          keyDown = true;
          HapticFeedback.vibrate();
        });
      },
      onTapUp: (e) => handleTapFinish(),
      onTapCancel: handleTapFinish,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(1, keyDown ? 0.5 : 2),
                spreadRadius: keyDown ? 0 : 2),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        child: Align(
          alignment: Alignment(0, -0.5),
          child: Text(
            widget.label,
            style: TextStyle(
                fontSize: widget.bigFont ? 28 : 20, color: widget.color),
          ),
        ),
      ),
    ));
  }
}
