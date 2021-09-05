import 'package:flutter/material.dart';
import 'package:little_notes/common/enums.dart';
import 'package:little_notes/models/index.dart';
import 'package:little_notes/pages/type_page.dart';
import 'package:little_notes/service/app_service.dart';
import 'package:little_notes/widgets/circular_image.dart';
import 'package:provider/provider.dart';

/// 分类列表，提供选择功能
class TypeList extends StatefulWidget {
  final ValueChanged<TypeModel>? onChanged;

  const TypeList({
    Key? key,
    this.onChanged,
  }) : super(key: key);

  @override
  _TypeListState createState() => _TypeListState();
}

class _TypeListState extends State<TypeList> {
  late AppService appService;

  @override
  void initState() {
    super.initState();
    appService = context.read<AppService>();
    appService.getTypes();
  }

  List<TypeModel> fmtTypeList(List<TypeModel> list) {
    var cList = [...list];
    var operationType = TypeModel(
      id: 0,
      icon: '1f527',
      name: '管理',
      color: Colors.grey.shade200.value.toString(),
      createDate: 0,
      updateDate: 0,
    );

    cList.insert(0, operationType);
    return cList;
  }

  void selected(TypeModel type) {
    if (widget.onChanged == null) return;
    // 分类管理
    if (type.id == 0) {
      print(type.id);
      Navigator.pushNamed<dynamic>(context, TypePage.pathName, arguments: true)
          .then((value) {
        TypeModel? t = value;
        if (t != null) widget.onChanged!(t);
      });
      return;
    }

    widget.onChanged!(type);
  }

  @override
  Widget build(BuildContext context) {
    var typeList =
        context.select<AppService, List<TypeModel>>((value) => value.typeList);
    var fmtList = fmtTypeList(typeList);

    return SizedBox(
      height: 146,
      child: Scrollbar(
        radius: Radius.circular(2),
        thickness: 2,
        child: GridView.builder(
            itemCount: fmtList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              mainAxisSpacing: 0,
              crossAxisSpacing: 0,
            ),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              var currentType = fmtList[index];
              return GestureDetector(
                onTap: () => selected(currentType),
                child: CircularImage(
                  size: SizeEnum.small,
                  icon: currentType.icon,
                  label: currentType.name,
                  color: Color(int.parse(currentType.color)),
                ),
              );
            }),
      ),
    );
  }
}
