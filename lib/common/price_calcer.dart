/* 用于记账页的字符金额计算 */
import 'package:flutter/material.dart';

class PriceCalcer extends ValueNotifier<String> {
  PriceCalcer(String value) : super(value);

  static const String addSignal = '+';
  static const String subSignal = '-';

  void inputKey(String keycode) {
    bool isSingle = keycode == PriceCalcer.addSignal || keycode == PriceCalcer.subSignal;

    if (isSingle) {
      bool startWithSingle = value[0] == PriceCalcer.addSignal || value[0] == PriceCalcer.subSignal;
      if (startWithSingle) {
        value = value.substring(1, value.length);
      }
      value = keycode + value;
      return;
    }

    // if (keycode == '+' && value.startsWith(+)) {
    value = value == '0' ? keycode : value + keycode;
  }

  void deleteKey() {
    if (value == '0') return;
    value = value.substring(0, value.length - 1);
  }

  void clear() {
    value = '0';
  }
}
