import 'package:flutter/material.dart';
import 'package:little_notes/pages/add_type_page.dart';
import 'package:little_notes/style/style_vars.dart';
import 'package:little_notes/widgets/circular_image.dart';

class TypePage extends StatefulWidget {
  static const pathName = 'type';

  const TypePage({Key? key}) : super(key: key);

  @override
  _TypePageState createState() => _TypePageState();
}

class _TypePageState extends State<TypePage> {
  void handleAction() async {
    var actionType = await showDialog(
        context: context,
        builder: (_) {
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 1);
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
          ...List.generate(
              200,
              (index) => Center(
                    child: GestureDetector(
                      onTap: handleAction,
                      child: CircularImage(
                        icon: '1f6b5-1f3fb-200d-2640-fe0f',
                        label: '分类$index',
                        selected: index == 4,
                      ),
                    ),
                  ))
        ],
      ),
    );
  }
}
