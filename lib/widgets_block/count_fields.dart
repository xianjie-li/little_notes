
import 'package:flutter/material.dart';
import 'package:little_notes/widgets/label_value.dart';

class CountFields extends StatelessWidget {
  const CountFields({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelValue(
          label: '月预算',
          value: '864',
          unit: '元',
        ),
        LabelValue(
          label: '日预算',
          value: '30',
          unit: '元',
        ),
        LabelValue(
          label: '月收入',
          value: '150',
          unit: '元',
        ),
        LabelValue(
          label: '月支出',
          value: '274',
          unit: '元',
        ),
      ],
    );
  }
}
