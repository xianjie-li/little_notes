import 'package:flutter/material.dart';
import 'package:little_notes/common/validators.dart';
import 'package:little_notes/pages/emoji_picker_page.dart';
import 'package:little_notes/style/style_vars.dart';

class AddBookPage extends StatefulWidget {
  static const pathName = 'add_book';

  AddBookPage({Key? key}) : super(key: key);

  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新增账本/账本修改'),
      ),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(StyleVars.paddingLG),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, EmojiPickerPage.pathName);
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: '图标',
                      border: OutlineInputBorder(),
                    ),
                    child: Image.asset(
                      'lib/assets/twemoji/1f3c5.png',
                      alignment: Alignment.centerLeft,
                      height: 30,
                    ),
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                InputDecorator(
                  decoration: InputDecoration(
                      labelText: '侧重内容',
                      helperText: '控制要在页面中着重显示的内容',
                      helperMaxLines: 2,
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: StyleVars.padding,
                          vertical: StyleVars.paddingLG)),
                  child: Row(
                    children: [
                      Radio(
                        value: '1',
                        groupValue: '1',
                        onChanged: (value) {},
                        visualDensity: VisualDensity.compact,
                      ),
                      Text('预算'),
                      Radio(
                        value: '2',
                        groupValue: '1',
                        onChanged: (value) {},
                        visualDensity: VisualDensity.compact,
                      ),
                      Text('余额'),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                TextFormField(
                  validator: notEmptyStringValidatorGetter(),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: '账本名',
                    hintText: '输入账本名称',
                    border: OutlineInputBorder(),
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                TextFormField(
                  validator: combineValidator([
                    notEmptyStringValidatorGetter(),
                    isNumberValidatorGetter(),
                  ]),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: '初始余额',
                    hintText: '输入账本初始余额',
                    border: OutlineInputBorder(),
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                  height: 32,
                ),
                Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(
                                  Size.fromHeight(50)),
                            ),
                            onPressed: () {
                              print(_formKey.currentState?.validate());
                            },
                            child: Text('提交')))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
