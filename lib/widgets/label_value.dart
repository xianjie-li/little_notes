import 'package:flutter/material.dart';
import 'package:little_notes/style/style_vars.dart';

/* 简单的键值展示组件 */
class LabelValue extends StatelessWidget {
  // 名称
  final String label;

  // 数值内容
  final String value;

  // 单位
  final String unit;

  const LabelValue({
    Key? key,
    required this.label,
    required this.value,
    this.unit = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: RichText(
        text: TextSpan(
            style: TextStyle(fontSize: 14, height: 1.6, color: StyleVars.colorSecond),
            children: [
              TextSpan(text: '$label: '),
              TextSpan(
                  text: value,
                  style: TextStyle(
                    fontSize: StyleVars.fsLG,
                    fontWeight: FontWeight.w600,
                    color: StyleVars.colorTitle,
                  )),
              if (unit.isNotEmpty) TextSpan(text: unit),
            ]),
      ),
    );
  }
}
