import 'package:flutter/material.dart';
import 'package:little_notes/widgets/color_picker.dart';

/// Color选择器
class ColorFormField extends FormField<String> {
  ColorFormField({
    Key? key,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    String? initialValue,
    AutovalidateMode? autovalidateMode,
    bool? enabled = true,
    ValueChanged<String>? onChanged,
  }) : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidateMode: autovalidateMode,
            enabled: enabled!,
            builder: (FormFieldState<String> field) {
              var isEmpty = field.value == null || field.value!.isEmpty;

              return InputDecorator(
                isEmpty: isEmpty,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                  labelText: '颜色',
                  hintText: '选择颜色',
                  border: OutlineInputBorder(),
                ),
                child: ColorPicker(
                  color: field.value,
                  onChange: field.didChange,
                ),
              );
            });

  @override
  _ColorFormFieldState createState() => _ColorFormFieldState();
}

class _ColorFormFieldState extends FormFieldState<String> {}
