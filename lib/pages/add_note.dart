import 'package:flutter/material.dart';
import 'package:little_notes/common/enums.dart';
import 'package:little_notes/common/price_calcer.dart';
import 'package:little_notes/style/style_vars.dart';
import 'package:little_notes/widgets/circular_image.dart';
import 'package:little_notes/widgets/date_picker_form_field.dart';
import 'package:little_notes/widgets/keyboard.dart';
import 'package:little_notes/widgets_block/cate_list.dart';

class AddNote extends StatefulWidget {
  static const String pathname = 'add_note';

  const AddNote({Key? key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final formKey = GlobalKey<FormState>();
  String value = '0';
  PriceCalcer priceCalcer = PriceCalcer('0');

  bool keyboardShow = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    priceCalcer.addListener(() {
      setState(() {
        value = priceCalcer.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('记一笔'),
        ),
        body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: StyleVars.paddingLG,
                                right: StyleVars.paddingLG,
                                top: StyleVars.paddingLG + 4,
                                bottom: 6),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircularImage(
                                  icon: '1f3e6',
                                  size: SizeEnum.large,
                                ),
                                Text(
                                  value,
                                  style: TextStyle(
                                    color: StyleVars.theme,
                                    fontSize: StyleVars.fsXL,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(),
                          CateList(),
                          Divider(),
                          Divider(
                            height: StyleVars.padding,
                            color: Colors.transparent,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                DatePickerFormField(),
                                Divider(
                                  color: Colors.transparent,
                                ),
                                Focus(
                                  onFocusChange: (isFocus) {
                                    setState(() {
                                      // 解除焦点
                                      keyboardShow = !isFocus;
                                    });
                                  },
                                  child: TextFormField(
                                    onSaved: (val) {
                                      print('2: $val');
                                    },
                                    maxLines: 2,
                                    decoration: InputDecoration(
                                      labelText: '备注',
                                      hintText: '输入备注',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.transparent,
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (keyboardShow)
                    Keyboard(
                        onKeyInput: priceCalcer.inputKey,
                        onCalc: () {
                          print('calc');
                        },
                        onClear: priceCalcer.clear,
                        onDelete: priceCalcer.deleteKey,
                        onSubmit: () {
                          print('submit');
                          formKey.currentState?.save();
                        }),
                ],
              ),
            )));
  }
}
