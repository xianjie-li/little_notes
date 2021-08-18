import 'package:flutter/material.dart';
import 'package:little_notes/common/validators.dart';
import 'package:little_notes/style/style_vars.dart';
import 'package:little_notes/widgets/color_list.dart';
import 'package:little_notes/widgets/color_picker.dart';

class AddTypePage extends StatefulWidget {
  static const pathName = 'add_type';

  const AddTypePage({Key? key}) : super(key: key);

  @override
  _AddTypePageState createState() => _AddTypePageState();
}

class _AddTypePageState extends State<AddTypePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新增、修改分类'),
      ),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(StyleVars.paddingLG),
            child: Column(
              children: [
                InputDecorator(
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
                Divider(
                  color: Colors.transparent,
                ),
                TextFormField(
                  validator: notEmptyStringValidatorGetter(),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: '分类名',
                    hintText: '输入分类名',
                    border: OutlineInputBorder(),
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                TextFormField(
                  validator: notEmptyStringValidatorGetter(),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: '父分类',
                    hintText: '可选，用于生成更细粒度的报表',
                    border: OutlineInputBorder(),
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                InputDecorator(
                  // isEmpty: true,
                  child: ColorPicker(),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                    labelText: '背景色',
                    hintText: '选择分类背景色',
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
