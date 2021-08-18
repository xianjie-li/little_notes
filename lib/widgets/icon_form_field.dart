import 'package:flutter/material.dart';
import 'package:little_notes/pages/emoji_picker_page.dart';
import 'package:little_notes/style/style_vars.dart';

/// Icon选择器
class IconFormField extends FormField<String> {
  IconFormField({
    Key? key,
    FormFieldSetter<String>? onSaved,
    FormFieldValidator<String>? validator,
    String? initialValue = '',
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

              return GestureDetector(
                onTap: () async {
                  if (!enabled) return;

                  String? icon = await Navigator.pushNamed<dynamic>(field.context, EmojiPickerPage.pathName);

                  if (icon == null) return;

                  field.didChange(icon);
                  if (onChanged != null) onChanged(icon);
                },
                child: InputDecorator(
                  // isFocused: focusNode.hasFocus,
                  isEmpty: isEmpty,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: StyleVars.padding, vertical: isEmpty ? 30 : StyleVars.paddingLG),
                    labelText: '图标',
                    border: OutlineInputBorder(),
                    errorText: field.errorText,
                  ),
                  child: isEmpty
                      ? null
                      : Image.asset(
                    'lib/assets/twemoji/${field.value}.png',
                    alignment: Alignment.centerLeft,
                    height: 30,
                  ),
                ),
              );
            });

  @override
  _IconFormFieldState createState() => _IconFormFieldState();
}

class _IconFormFieldState extends FormFieldState<String> {}
