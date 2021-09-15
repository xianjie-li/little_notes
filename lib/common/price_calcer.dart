/* 用于记账页的字符金额计算 */
import 'package:flutter/material.dart';

class PriceCalcer extends ValueNotifier<String> {
  PriceCalcer(String value) : super(value);

  static const String addSignal = '+';
  static const String subSignal = '-';

  void inputKey(String keycode) {
    bool isSingle =
        keycode == PriceCalcer.addSignal || keycode == PriceCalcer.subSignal;

    if (isSingle) {
      value = value.substring(1, value.length);
      value = keycode + value;
      return;
    }

    if (value.length > 15) return;

    if (keycode == '.') {
      value = value.replaceAll('.', '');
      value = value + '.';
      return;
    }

    if (value == '+0' || value == '-0') {
      var prefix = value[0];
      value = '$prefix$keycode';
      return;
    }

    value = value + keycode;
  }

  void deleteKey() {
    if (value == '+0' || value == '-0') return;
    if (value.length == 2) {
      clear();
      return;
    }
    value = value.substring(0, value.length - 1);
  }

  void clear() {
    var prefix = value[0];
    value = '${prefix}0';
  }
}
