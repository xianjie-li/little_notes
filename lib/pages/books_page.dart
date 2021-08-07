import 'package:flutter/material.dart';
import 'package:little_notes/pages/add_book_page.dart';
import 'package:little_notes/style/style_vars.dart';
import 'package:little_notes/widgets/node_book.dart';

/* 账本列表，此页面在抽屉内显示 */
class BooksPage extends StatefulWidget {
  const BooksPage({Key? key}) : super(key: key);

  @override
  _BooksPageState createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                onTap: () {
                  Navigator.pushNamed(context, AddBookPage.pathName);
                },
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
    );
  }
}
