import 'package:flutter/material.dart';
import 'package:little_notes/common/date_helper.dart';
import 'package:little_notes/common/validators.dart';
import 'package:little_notes/dao/book_dao.dart';
import 'package:little_notes/models/book_model.dart';
import 'package:little_notes/style/style_vars.dart';
import 'package:little_notes/widgets/color_form_field.dart';
import 'package:little_notes/widgets/icon_form_field.dart';
import 'package:little_notes/widgets/radio_form_field.dart';
import 'package:little_notes/widgets/tips.dart';
import 'package:sqflite/sqflite.dart';

class AddBookPage extends StatefulWidget {
  static const pathName = 'add_book';

  AddBookPage({Key? key}) : super(key: key);

  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> formValue = {
    'id': 0,
    'balance': 0,
    'budget': 0,
    'createDate': DateHelper.getSinceEpoch(),
    'updateDate': DateHelper.getSinceEpoch(),
  };

  /// 提交账本
  void submit() async {
    var book = BookModel.fromJson(formValue);

    try {
      await BookDao().add(book);

      tips(context, '添加完成!', Colors.green);

      Navigator.pop(context);

    } on DatabaseException catch (err) {
      if (err.isUniqueConstraintError()) {
        tips(context, '该账本已存在', Colors.red);
      } else {
        tips(context, '写入数据失败, code: ${err.getResultCode()}', Colors.red);
      }
    } catch (err) {
      tips(context, '操作异常', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('新增账本/账本修改'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: EdgeInsets.all(StyleVars.paddingLG),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconFormField(
                  validator: notEmptyStringValidatorGetter(),
                  onSaved: (val) {
                    formValue['icon'] = val;
                  },
                ),
                Divider(
                  color: Colors.transparent,
                ),
                RadioFormField(
                  label: '账本侧重内容',
                  options: [
                    RadioFormFieldOption(
                        '预算', BookModelFocusEnum.Budget.value!),
                    RadioFormFieldOption(
                        '余额', BookModelFocusEnum.Balance.value!),
                  ],
                  validator: notEmptyStringValidatorGetter(),
                  onSaved: (val) {
                    formValue['focus'] = val;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8),
                  child: Text(
                    '账本要侧重显示的内容',
                    style: TextStyle(color: StyleVars.colorSecond),
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
                  onSaved: (val) {
                    formValue['name'] = val;
                  },
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
                  onSaved: (val) {
                    formValue['balance'] = double.parse(val!);
                  },
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
                    labelText: '每月预算',
                    hintText: '输入账本每月预算',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (val) {
                    formValue['budget'] = double.parse(val!);
                  },
                ),
                Divider(
                  color: Colors.transparent,
                ),
                ColorFormField(
                  validator: notEmptyStringValidatorGetter(),
                  onSaved: (val) {
                    formValue['color'] = val;
                  },
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
                              if (!(_formKey.currentState?.validate() ?? true))
                                return;
                              _formKey.currentState?.save();
                              submit();
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
