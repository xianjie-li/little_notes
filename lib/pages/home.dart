import 'package:flutter/material.dart';
import 'package:little_notes/pages/books.dart';
import 'package:little_notes/style/style_vars.dart';
import 'package:little_notes/widgets/node_book.dart';
import 'package:little_notes/widgets/time_list_item.dart';
import 'package:little_notes/widgets/time_list_title.dart';
import 'package:little_notes/widgets_block/home_app_bar.dart';

class Home extends StatefulWidget {
  static const pathName = 'home';

  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: Books(),
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
