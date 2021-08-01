import 'package:flutter/material.dart';
import 'package:little_notes/style/style_vars.dart';
import 'package:little_notes/widgets/node_book.dart';
import 'package:little_notes/widgets/time_list_item.dart';
import 'package:little_notes/widgets/time_list_title.dart';
import 'package:little_notes/widgets_block/home_app_bar.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Column(
            children: [
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 2 / 2.3,
                  padding: EdgeInsets.symmetric(
                      vertical: 48, horizontal: StyleVars.paddingLG),
                  children: [
                    NoteBook(
                        label: '我的账本',
                        desc: '预算：736元',
                        icon: '270f',
                        color: StyleVars.theme),
                    NoteBook(
                      label: '我的账本2',
                      desc: '余额：736元',
                      icon: '1f9cb',
                      color: Colors.blue,
                      selected: true,
                    ),
                    NoteBook(
                        label: '我的账本3',
                        desc: '余额：736元',
                        icon: '1f6b5-1f3fb-200d-2640-fe0f',
                        color: Colors.cyan),
                    NoteBook(
                      isAddButton: true,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(color: Colors.grey.shade300))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      label: Text('删除'),
                      icon: Icon(Icons.delete_forever_rounded),
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.red),
                          fixedSize: MaterialStateProperty.all(Size(100, 44))),
                    ),
                    Divider(
                      indent: StyleVars.padding,
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      label: Text('修改'),
                      icon: Icon(Icons.edit),
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all(Colors.teal),
                          overlayColor:
                              MaterialStateProperty.all(Colors.teal.shade200),
                          fixedSize: MaterialStateProperty.all(Size(100, 44))),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        body: CustomScrollView(
          slivers: [
            HomeAppBar(),
            SliverList(
                delegate: SliverChildListDelegate([
              TimeListTitle(
                title: '今天',
                trailing: '收支:  -251',
              ),
              ...List.generate(
                5,
                (index) =>
                    TimeListItem(title: '早餐费用', trailing: '-63', icon: '1f9c1'),
              ),
              TimeListTitle(
                title: '7/12  星期五',
                trailing: '收支:  -251',
              ),
              ...List.generate(
                50,
                (index) => TimeListItem(
                    title: '日用品',
                    subtitle: '毛巾30、纸巾32、牙刷16、沐浴露79、洗面乳30.',
                    trailing: '-23',
                    icon: '1faa5'),
              ),
            ])),
          ],
        ));
  }
}
