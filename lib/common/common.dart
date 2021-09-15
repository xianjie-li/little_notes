import 'package:little_notes/common/price_calcer.dart';
import 'package:little_notes/models/index.dart';

/// 根据类型获取显示的符号
String getSymbleByDiffType(NoteModelDiffTypeEnum type) {
  if (type == NoteModelDiffTypeEnum.Less) return PriceCalcer.subSignal;
  if (type == NoteModelDiffTypeEnum.Raise) return PriceCalcer.addSignal;
  return "";
}

/// 从指定map中获取所有具有指定前缀字段名的值，去除前缀并组成新的map返回
Map<String, Object?> getPrefixFields(String prefix, Map<String, Object?> map) {
  var keys = map.keys.where((k) => k.startsWith(prefix));

  Map<String, Object?> m = {};

  keys.forEach((k) {
    m[k.replaceFirst(prefix, '')] = map[k];
  });

  return m;
}
