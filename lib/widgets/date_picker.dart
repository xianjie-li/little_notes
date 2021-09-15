import 'package:flutter/material.dart';
import 'package:little_notes/common/date_helper.dart';

typedef BuilderFn = Widget Function(String value);

class DatePicker extends StatefulWidget {
  final String? value;
  final ValueChanged<String> onChanged;

  const DatePicker({
    Key? key,
    required this.onChanged,
    this.value,
  }) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  late TextEditingController textEditingController;
  bool isToday = true;

  @override
  void initState() {
    super.initState();

    textEditingController = TextEditingController(
      text: widget.value ?? DateHelper.getDateTimeString(DateTime.now()),
    );
  }

  @override
  void didUpdateWidget(covariant DatePicker oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value != widget.value) {
      isToday = DateHelper.isSameDay(DateTime.now(), pDate);
      textEditingController.text =
          widget.value ?? DateHelper.getDateTimeString(pDate);
    }
  }

  /// 根据当前value解析到的时间，默认为当前时间
  DateTime get pDate {
    if (widget.value == null) return DateTime.now();
    return DateTime.parse(widget.value!);
  }

  @override
  Widget build(BuildContext context) {
    var v = widget.value ?? "";

    return GestureDetector(
      onTap: () async {
        var date = pDate;

        var selectDate = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(date.year - 1),
          lastDate: date,
        );

        if (selectDate == null) return;

        var selectTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: date.hour, minute: date.minute));

        if (selectTime != null) {
          selectDate = DateTime(selectDate.year, selectDate.month,
              selectDate.day, selectTime.hour, selectTime.minute);
        }

        widget.onChanged(DateHelper.getDateTimeString(selectDate));
      },
      child: Text("$v ${isToday ? '(今天)' : ''}"),
    );
  }
}
