import 'package:flutter/material.dart';
import 'package:little_notes/common/date_helper.dart';
import 'package:little_notes/common/enums.dart';
import 'package:little_notes/common/price_calcer.dart';
import 'package:little_notes/models/index.dart';
import 'package:little_notes/service/app_service.dart';
import 'package:little_notes/style/style_vars.dart';
import 'package:little_notes/widgets/circular_image.dart';
import 'package:little_notes/widgets/date_picker.dart';
import 'package:little_notes/widgets/date_piker_form_field.dart';
import 'package:little_notes/widgets/keyboard.dart';
import 'package:little_notes/widgets/tips.dart';
import 'package:little_notes/widgets_block/type_list.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatefulWidget {
  static const String pathName = 'add_note';

  const AddNotePage({Key? key}) : super(key: key);

  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  final formKey = GlobalKey<FormState>();
  String value = '-0';
  PriceCalcer priceCalcer = PriceCalcer('-0');
  late AppService appService;

  BookModel? book;
  TypeModel? type;

  bool keyboardShow = true;

  final Map<String, dynamic> formValue = {
    "id": 0,
  };

  @override
  void initState() {
    super.initState();

    appService = context.read<AppService>();

    setState(() {
      book = appService.currentBook;
    });

    priceCalcer.addListener(() {
      setState(() {
        value = priceCalcer.value;
      });
    });
  }

  void submit() async {
    formKey.currentState?.save();
    formValue['bookId'] = book!.id;

    var val = priceCalcer.value;
    var diffNumber = double.parse(val.substring(1));
    var typeStr = val[0];

    var diffType = typeStr == PriceCalcer.subSignal
        ? NoteModelDiffTypeEnum.Less.value
        : NoteModelDiffTypeEnum.Raise.value;

    if (diffNumber == 0) {
      tips(context, '记录金额不能为0', Colors.orange);
      return;
    }

    formValue['diffType'] = diffType;
    formValue['diffNumber'] = diffNumber;

    var noteModel = NoteModel.fromJson(formValue);
    var success = await appService.addOrEditNote(context, noteModel);

    print(formValue);

    if (success) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var books =
        context.select<AppService, List<BookModel>>((value) => value.bookList);

    return Scaffold(
        appBar: AppBar(
          title: Text('记一笔'),
          actions: [
            PopupMenuButton<BookModel>(
              child: Row(
                children: [
                  Text(book?.name ?? ''),
                  Icon(Icons.arrow_drop_down),
                  Divider(
                    indent: StyleVars.padding,
                  ),
                ],
              ),
              initialValue: book,
              onSelected: (BookModel result) {
                setState(() {
                  book = result;
                });
              },
              itemBuilder: (BuildContext context) {
                return books
                    .map((_book) => PopupMenuItem<BookModel>(
                          value: _book,
                          child: Text(_book.name),
                        ))
                    .toList();
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
                                Row(
                                  children: [
                                    CircularImage(
                                      icon: type?.icon ?? '1f5d2',
                                      size: SizeEnum.large,
                                      color: type?.color != null
                                          ? Color(int.parse(type!.color))
                                          : null,
                                    ),
                                    Divider(
                                      indent: 12,
                                    ),
                                    Text(type == null ? '无分类' : type!.name)
                                  ],
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
                          TypeList(
                            onChanged: (_type) {
                              setState(() {
                                type = _type;
                                formValue['typeId'] = _type.id;
                              });
                            },
                          ),
                          Divider(),
                          Divider(
                            height: StyleVars.padding,
                            color: Colors.transparent,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                DatePickerFormField(
                                  onSaved: (val) {
                                    formValue['createDate'] =
                                        DateTime.parse(val!)
                                            .millisecondsSinceEpoch;
                                    formValue['updateDate'] =
                                        formValue['createDate'];
                                  },
                                ),
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
                                      formValue['remark'] = val;
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
                      onSubmit: submit,
                    )
                ],
              ),
            )));
  }
}
