import 'package:flutter/material.dart';
import 'package:little_notes/models/index.dart';
import 'package:little_notes/pages/emoji_picker_page.dart';
import 'package:little_notes/pages/type_page.dart';
import 'package:little_notes/style/style_vars.dart';

/// 分类选择器
class TypeFormField extends FormField<TypeModel> {
  TypeFormField({
    Key? key,
    FormFieldSetter<TypeModel>? onSaved,
    FormFieldValidator<TypeModel>? validator,
    TypeModel? initialValue,
    AutovalidateMode? autovalidateMode,
    bool? enabled = true,
    ValueChanged<TypeModel>? onChanged,
    String? labelText = '分类',
    String? hintText,
  }) : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidateMode: autovalidateMode,
            enabled: enabled!,
            builder: (FormFieldState<TypeModel> field) {
              var isEmpty = field.value == null;

              return GestureDetector(
                onTap: () async {
                  if (!enabled) return;

                  TypeModel? type = await Navigator.pushNamed<dynamic>(
                      field.context, TypePage.pathName,
                      arguments: true);

                  if (type == null) return;

                  field.didChange(type);
                  if (onChanged != null) onChanged(type);
                },
                child: InputDecorator(
                  // isFocused: focusNode.hasFocus,
                  isEmpty: isEmpty,
                  decoration: InputDecoration(
                    labelText: labelText,
                    border: OutlineInputBorder(),
                    errorText: field.errorText,
                    hintText: hintText,
                  ),
                  child: isEmpty ? null : Container(
                    child: Text(field.value!.name),
                  ),
                ),
              );
            });

  @override
  _TypeFormFieldState createState() => _TypeFormFieldState();
}

class _TypeFormFieldState extends FormFieldState<TypeModel> {}
