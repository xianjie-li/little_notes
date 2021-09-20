import 'package:little_notes/common/price_calcer.dart';
import 'package:little_notes/models/index.dart';

/// 用于映射一周每天的文本
Map<String, String> weekdayMap = {
  "0": "日",
  "1": "一",
  "2": "二",
  "3": "三",
  "4": "四",
  "5": "五",
  "6": "六",
};

/// 从指定map中获取所有具有指定前缀字段名的值，去除前缀并组成新的map返回
Map<String, Object?> getPrefixFields(String prefix, Map<String, Object?> map) {
  var keys = map.keys.where((k) => k.startsWith(prefix));

  Map<String, Object?> m = {};

  keys.forEach((k) {
    m[k.replaceFirst(prefix, '')] = map[k];
  });

  return m;
}

/// 移除浮点值不必要的尾随0
String removeDecimalZeroFormat(double n) {
  return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
}
