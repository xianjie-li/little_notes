import 'package:flutter/material.dart';
import 'package:little_notes/common/date_helper.dart';

typedef BuilderFn = Widget Function(String value);

class DatePickerFormField extends StatefulWidget {
  const DatePickerFormField({
    Key? key,
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
    textEditingController = TextEditingController(
      text: DateHelper.getDateTimeString(DateTime.now()),
    );
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

        var dateTime = await showDatePicker(
          context: context,
          initialDate: now,
          firstDate: DateTime(now.year - 1),
          lastDate: now,
        );

        if (dateTime == null) return;

        setState(() {
          isToday = DateHelper.isSameDay(now, dateTime);
          textEditingController.text = DateHelper.getDateTimeString(dateTime);
        });
      },
      readOnly: true,
      decoration: InputDecoration(
        labelText: '时间',
        hintText: '输入时间',
        border: OutlineInputBorder(),
        suffixText: isToday ? '今天' : null
      ),
    );
  }
}
