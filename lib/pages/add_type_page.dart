import 'package:flutter/material.dart';
import 'package:little_notes/common/date_helper.dart';
import 'package:little_notes/common/validators.dart';
import 'package:little_notes/models/index.dart';
import 'package:little_notes/service/app_service.dart';
import 'package:little_notes/style/style_vars.dart';
import 'package:little_notes/widgets/color_form_field.dart';
import 'package:little_notes/widgets/icon_form_field.dart';
import 'package:little_notes/widgets/type_form_field.dart';
import 'package:provider/provider.dart';

class AddTypePage extends StatefulWidget {
  static const pathName = 'add_type';
  final int? id;

  const AddTypePage({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  _AddTypePageState createState() => _AddTypePageState();
}

class _AddTypePageState extends State<AddTypePage> {
  final _formKey = GlobalKey<FormState>();
  late AppService appService;
  TypeModel? editType;
  TypeModel? parentType;

  final Map<String, dynamic> formValue = {
    'id': 0,
  };

  @override
  void initState() {
    super.initState();

    appService = context.read<AppService>();

    setEditData();
  }

  void setEditData() async {
    if (widget.id != null) {
      var value = await appService.typeDao.query(widget.id!);

      setState(() {
        editType = value;
      });

      if (value!.parentId != null) {
        var pType = await appService.typeDao.query(value.parentId!);
        setState(() {
          parentType = pType;
        });
      }
    }
  }

  void submit() async {
    late TypeModel eType;
    bool success = false;

    formValue['updateDate'] = DateHelper.getSinceEpoch();

    if (editType == null) {
      formValue['createDate'] = formValue['updateDate'];

      eType = TypeModel.fromJson(formValue);

      success = await appService.addOrEditType(context, eType);
    } else {
      var fv = Map.of(formValue);

      eType = TypeModel.fromJson({
        ...editType!.toJson(),
        ...fv,
        "id": widget.id!,
      });

      print(eType.parentId);

      success = await appService.addOrEditType(context, eType, true);
    }

    if (success) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = widget.id != null;
    bool pass = true;

    if (isEdit) pass = editType != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? '修改分类' : '新增分类'),
      ),
      body: SingleChildScrollView(
        child: pass
            ? Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(StyleVars.paddingLG),
                  child: Column(
                    children: [
                      IconFormField(
                        validator: notEmptyStringValidatorGetter(),
                        initialValue: editType?.icon,
                        onSaved: (val) {
                          formValue['icon'] = val;
                        },
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
                        initialValue: editType?.name,
                        onSaved: (val) {
                          formValue['name'] = val;
                        },
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      ColorFormField(
                        validator: notEmptyStringValidatorGetter(),
                        initialValue: editType?.color,
                        onSaved: (val) {
                          formValue['color'] = val;
                        },
                      ),
                      Divider(
                        color: Colors.transparent,
                      ),
                      TypeFormField(
                        labelText: '父分类',
                        hintText: '可选，用于生成更细粒度的报表',
                        initialValue: parentType,
                        onSaved: (val) {
                          formValue['parentId'] = val?.id;
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
                                    if (!(_formKey.currentState?.validate() ??
                                        true)) return;
                                    _formKey.currentState?.save();
                                    submit();
                                  },
                                  child: Text('提交')))
                        ],
                      )
                    ],
                  ),
                ),
              )
            : null,
      ),
    );
  }
}
