import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/* 定制键盘按钮 */
class KeyboardButton extends StatefulWidget {
  final String label;
  final bool bigFont;
  final Color? color;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final int? flex;

  const KeyboardButton(this.label,
      {Key? key,
        this.bigFont = false,
        this.color,
        this.onTap,
        this.onLongPress,
        this.flex = 1
      })
      : super(key: key);

  @override
  _KeyboardButtonState createState() => _KeyboardButtonState();
}

class _KeyboardButtonState extends State<KeyboardButton> {
  bool keyDown = false;
  Timer? timer;

  void handleTapFinish() {
    timer = Timer(Duration(milliseconds: 100), () {
      setState(() {
        keyDown = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: widget.flex!,
        child: GestureDetector(
          onTapDown: (e) {
            timer?.cancel();

            HapticFeedback.vibrate();
            setState(() {
              keyDown = true;
            });
          },
          onTapUp: (e) => handleTapFinish(),
          onTapCancel: handleTapFinish,
          onTap: widget.onTap,
          onLongPress: widget.onLongPress,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0.2, keyDown ? 0.5 : 2),
                    spreadRadius: keyDown ? 0 : 2),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(32)),
            ),
            child: Align(
              alignment: Alignment(0, -0.3),
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
