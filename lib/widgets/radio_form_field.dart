import 'package:flutter/material.dart';
import 'package:little_notes/style/style_vars.dart';

class RadioFormFieldOption {
  String label;
  String value;

  RadioFormFieldOption(this.label, this.value);
}

/// 单选
class RadioFormField extends FormField<String> {
  RadioFormField({
    Key? key,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    String? initialValue = '',
    AutovalidateMode? autovalidateMode,
    bool? enabled = true,
    ValueChanged<String>? onChanged,
    required String label,
    required List<RadioFormFieldOption> options,
  }) : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidateMode: autovalidateMode,
            enabled: enabled!,
            builder: (FormFieldState<String> field) {
              return InputDecorator(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(StyleVars.padding),
                    labelText: label,
                    border: OutlineInputBorder(),
                    errorText: field.errorText,
                  ),
                  child: Row(
                    children: options.fold<List<Widget>>([], (prev, item) {
                      prev.addAll([
                        Radio(
                          value: item.value,
                          groupValue: field.value,
                          onChanged: field.didChange,
                          visualDensity: VisualDensity.compact,
                        ),
                        Text(item.label),
                      ]);
                      return prev;
                    }).toList(),
                  ));
            });

  @override
  _IconFormFieldState createState() => _IconFormFieldState();
}

class _IconFormFieldState extends FormFieldState<String> {}
