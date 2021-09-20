import 'package:flutter/material.dart';
import 'package:little_notes/common/common.dart';
import 'package:little_notes/models/index.dart';
import 'package:little_notes/widgets/label_value.dart';

class CountFields extends StatelessWidget {
  final Map<String, double> monthCounts;
  final BookModelFocusEnum type;

  const CountFields({Key? key, required this.monthCounts, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelValue(
          label: '账本月',
          value: removeDecimalZeroFormat(monthCounts["month"]!),
          unit: '月',
        ),
        if (type == BookModelFocusEnum.Budget)
          LabelValue(
            label: '日预算',
            value: removeDecimalZeroFormat(monthCounts["dayBudget"]!),
            unit: '元',
          ),
        LabelValue(
          label: '月收入',
          value: removeDecimalZeroFormat(monthCounts["monthIn"]!),
          unit: '元',
        ),
        LabelValue(
          label: '月支出',
          value: removeDecimalZeroFormat(monthCounts["monthOut"]!),
          unit: '元',
        ),
      ],
    );
  }
}
