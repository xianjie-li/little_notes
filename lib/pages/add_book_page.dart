import 'dart:math';

import 'package:flutter/material.dart';
import 'package:little_notes/common/date_helper.dart';
import 'package:little_notes/common/validators.dart';
import 'package:little_notes/dao/book_dao.dart';
import 'package:little_notes/models/book_model.dart';
import 'package:little_notes/service/app_service.dart';
import 'package:little_notes/style/style_vars.dart';
import 'package:little_notes/widgets/color_form_field.dart';
import 'package:little_notes/widgets/icon_form_field.dart';
import 'package:little_notes/widgets/radio_form_field.dart';
import 'package:provider/provider.dart';

class AddBookPage extends StatefulWidget {
  static const pathName = 'add_book';
  static const editFlag = 'edit_flag';

  AddBookPage({Key? key}) : super(key: key);

  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();
  late AppService appService;

  final Map<String, dynamic> formValue = {
    'id': 0,
    'balance': 0,
    'budget': 0,
  };

  @override
  void initState() {
    super.initState();
    appService = context.read<AppService>();
  }

  /// 提交账本
  void submit(BookModel? currentBook) async {
    late BookModel eBook;

    formValue['updateDate'] = DateHelper.getSinceEpoch();

    if (currentBook == null) {
      formValue['createDate'] = formValue['updateDate'];

      eBook = BookModel.fromJson(formValue);

      await appService.addOrEditBook(context, eBook);
    } else {
      var fv = Map.of(formValue);
      // 更新时需要去掉这些项
      fv.remove('id');
      fv.remove('createDate');
      fv.remove('balance');

      eBook = BookModel.fromJson({
        ...currentBook.toJson(),
        ...fv,
      });

      await appService.addOrEditBook(context, eBook, true);
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = ModalRoute.of(context)!.settings.arguments == AddBookPage.editFlag;
    var currentBook = isEdit ? context.select<AppService, BookModel?>((value) => value.currentBook) : null;

    return Scaffold(
      appBar: AppBar(
        title: Text(currentBook != null ? '账本修改' : '新增账本'),
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
                  initialValue: currentBook?.icon,
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
                  initialValue: currentBook?.focus,
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
                  initialValue: currentBook?.name,
                  onSaved: (val) {
                    formValue['name'] = val;
                  },
                ),
                if (currentBook == null) Divider(
                  color: Colors.transparent,
                ),
                if (currentBook == null) TextFormField(
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
                  initialValue: currentBook?.balance.toString(),
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
                  initialValue: currentBook?.budget.toString(),
                  onSaved: (val) {
                    formValue['budget'] = double.parse(val!);
                  },
                ),
                Divider(
                  color: Colors.transparent,
                ),
                ColorFormField(
                  validator: notEmptyStringValidatorGetter(),
                  initialValue: currentBook?.color,
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
                              submit(currentBook);
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
