import 'package:flutter/material.dart';
import 'package:little_notes/common/date_helper.dart';
import 'package:little_notes/models/index.dart';
import 'package:little_notes/pages/type_page.dart';
import 'package:little_notes/widgets/date_picker.dart';

/// 分类选择器
class DatePickerFormField extends FormField<String> {
  DatePickerFormField({
    Key? key,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    String? initialValue,
    AutovalidateMode? autovalidateMode,
    bool? enabled = true,
    ValueChanged<TypeModel>? onChanged,
    String? labelText = '选择日期',
    String? hintText,
  }) : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            initialValue:
                initialValue ?? DateHelper.getDateTimeString(DateTime.now()),
            autovalidateMode: autovalidateMode,
            enabled: enabled!,
            builder: (FormFieldState<String> field) {
              // var isEmpty = field.value == null;

              return InputDecorator(
                // isEmpty: isEmpty,
                decoration: InputDecoration(
                  labelText: labelText,
                  border: OutlineInputBorder(),
                  errorText: field.errorText,
                  hintText: hintText,
                ),
                child: DatePicker(
                  onChanged: field.didChange,
                  value: field.value,
                ),
              );
            });

  @override
  _DatePickerFormFieldState createState() => _DatePickerFormFieldState();
}

class _DatePickerFormFieldState extends FormFieldState<String> {}
