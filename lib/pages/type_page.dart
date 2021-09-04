import 'package:flutter/material.dart';
import 'package:little_notes/models/index.dart';
import 'package:little_notes/pages/add_type_page.dart';
import 'package:little_notes/service/app_service.dart';
import 'package:little_notes/style/style_vars.dart';
import 'package:little_notes/widgets/circular_image.dart';
import 'package:provider/provider.dart';

class TypePage extends StatefulWidget {
  static const pathName = 'type';

  const TypePage({Key? key}) : super(key: key);

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
    var actionType = await showDialog(
        context: context,
        builder: (_) {
          return SimpleDialog(
            contentPadding: EdgeInsets.all(StyleVars.padding),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 1);
                },
                child: Text('选择'),
                padding: EdgeInsets.all(StyleVars.padding),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 1);
                  Navigator.pushNamed(context, AddTypePage.pathName,
                      arguments: type.id);
                },
                child: Text('修改'),
                padding: EdgeInsets.all(StyleVars.padding),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 2);
                },
                child: Text('删除', style: TextStyle(color: Colors.red)),
                padding: EdgeInsets.all(StyleVars.padding),
              ),
            ],
          );
        });

    print(actionType);
  }

  @override
  Widget build(BuildContext context) {
    var bookList =
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
      body: GridView.count(
        padding: EdgeInsets.symmetric(
            vertical: StyleVars.padding, horizontal: StyleVars.paddingSM),
        crossAxisCount: 5,
        childAspectRatio: 1,
        mainAxisSpacing: 0,
        crossAxisSpacing: 6,
        children: [
          ...List.generate(bookList.length, (index) {
            var currentType = bookList[index];
            return Center(
              child: GestureDetector(
                onTap: () => handleAction(currentType),
                child: CircularImage(
                  icon: currentType.icon,
                  label: currentType.name,
                  color: Color(int.parse(currentType.color)),
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
