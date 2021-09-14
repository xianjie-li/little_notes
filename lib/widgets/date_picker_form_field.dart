import 'package:flutter/material.dart';
import 'package:little_notes/common/date_helper.dart';

typedef BuilderFn = Widget Function(String value);

class DatePickerFormField extends StatefulWidget {
  final String? value;
  final ValueChanged<String>? onChanged;

  const DatePickerFormField({
    Key? key,
    this.onChanged,
    this.value,
  }) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePickerFormField> {
  late TextEditingController textEditingController;
  bool isToday = true;

  @override
  void initState() {
    super.initState();

    if (widget.onChanged != null)
      widget.onChanged!(DateHelper.getDateTimeString(DateTime.now()));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      onSaved: (val) {
        print('1: $val');
      },
      onTap: () async {
        DateTime now = DateTime.now();

        var date = await showDatePicker(
          context: context,
          initialDate: now,
          firstDate: DateTime(now.year - 1),
          lastDate: now,
        );

        if (date == null) return;

        var time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: now.hour, minute: now.minute));

        if (time != null) {
          date =
              DateTime(date.year, date.month, date.day, time.hour, time.minute);
        }

        setState(() {
          isToday = DateHelper.isSameDay(now, date!);
          textEditingController.text = DateHelper.getDateTimeString(date);
        });
      },
      readOnly: true,
      decoration: InputDecoration(
          labelText: '时间',
          hintText: '输入时间',
          border: OutlineInputBorder(),
          suffixText: isToday ? '今天' : null),
    );
  }
}
