import 'package:flutter/material.dart';
import 'package:little_notes/common/enums.dart';
import 'package:little_notes/common/price_calcer.dart';
import 'package:little_notes/style/style_vars.dart';
import 'package:little_notes/widgets/circular_image.dart';
import 'package:little_notes/widgets/date_picker_form_field.dart';
import 'package:little_notes/widgets/keyboard.dart';
import 'package:little_notes/widgets_block/type_list.dart';

class AddNotePage extends StatefulWidget {
  static const String pathName = 'add_note';

  const AddNotePage({Key? key}) : super(key: key);

  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final formKey = GlobalKey<FormState>();
  String value = '+0';
  PriceCalcer priceCalcer = PriceCalcer('+0');

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
          actions: [
            PopupMenuButton<String>(
              child: Row(
                children: [
                  Text('账本'),
                  Icon(Icons.arrow_drop_down),
                  Divider(indent: StyleVars.padding,),
                ],
              ),
              initialValue: '账本1',
              onSelected: (String result) {
                print(result);
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem<String>(
                    value: '账本1',
                    child: Text('Working a lot harder'),
                  ),
                  PopupMenuItem<String>(
                    value: '账本2',
                    child: Text('Being a lot smarter'),
                  ),
                  PopupMenuItem<String>(
                    value: '账本3',
                    child: Text('Being a self-starter'),
                  ),
                  PopupMenuItem<String>(
                    value: '账本4',
                    child: Text('Placed in charge of trading charter'),
                  ),
                ];
              },
            )
          ],
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
                          TypeList(),
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
