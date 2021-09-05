import 'package:flutter/material.dart';
import 'package:little_notes/models/index.dart';
import 'package:little_notes/pages/add_type_page.dart';
import 'package:little_notes/service/app_service.dart';
import 'package:little_notes/style/style_vars.dart';
import 'package:little_notes/widgets/circular_image.dart';
import 'package:provider/provider.dart';

class TypePage extends StatefulWidget {
  static const pathName = 'type';

  /// 开启选择模式，选择后通过路由回传
  final bool isSelect;

  const TypePage({
    Key? key,
    isSelect,
  })  : this.isSelect = isSelect ?? false,
        super(key: key);

  @override
  _TypePageState createState() => _TypePageState();
}

class _TypePageState extends State<TypePage> {
  late AppService appService;

  @override
  void initState() {
    super.initState();

    appService = context.read<AppService>();
    appService.getTypes();
  }

  void handleAction(TypeModel type) async {
    await showDialog(
        context: context,
        builder: (_) {
          return SimpleDialog(
            contentPadding: EdgeInsets.all(StyleVars.padding),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AddTypePage.pathName,
                      arguments: type.id);
                },
                child: Text('修改'),
                padding: EdgeInsets.all(StyleVars.padding),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                  appService.deleteType(context, type);
                },
                child: Text('删除', style: TextStyle(color: Colors.red)),
                padding: EdgeInsets.all(StyleVars.padding),
              ),
            ],
          );
        });
  }

  void check(TypeModel type) {
    if (widget.isSelect) Navigator.pop(context, type);
  }

  @override
  Widget build(BuildContext context) {
    var typeList =
        context.select<AppService, List<TypeModel>>((state) => state.typeList);

    return Scaffold(
      appBar: AppBar(
        title: Text('分类管理'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AddTypePage.pathName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: GridView.builder(
          itemCount: typeList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: 1,
            mainAxisSpacing: 0,
            crossAxisSpacing: 6,
          ),
          padding: EdgeInsets.symmetric(
              vertical: StyleVars.padding, horizontal: StyleVars.paddingSM),
          itemBuilder: (context, index) {
            var currentType = typeList[index];
            return Center(
              child: GestureDetector(
                onTap: () => check(currentType),
                onLongPress: () => handleAction(currentType),
                child: CircularImage(
                  icon: currentType.icon,
                  label: currentType.name,
                  color: Color(int.parse(currentType.color)),
                ),
              ),
            );
          }),
    );
  }
}
