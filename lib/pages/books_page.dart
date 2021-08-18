import 'package:flutter/material.dart';
import 'package:little_notes/dao/book_dao.dart';
import 'package:little_notes/models/book_model.dart';
import 'package:little_notes/pages/add_book_page.dart';
import 'package:little_notes/style/style_vars.dart';
import 'package:little_notes/widgets/node_book.dart';
import 'package:little_notes/widgets/tips_node.dart';

/* 账本列表，此页面在抽屉内显示 */
class BooksPage extends StatefulWidget {
  const BooksPage({Key? key}) : super(key: key);

  @override
  _BooksPageState createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  BookDao bookDao = BookDao();

  List<BookModel> list = [];

  List<MaterialColor> colors = [Colors.blue, Colors.cyan, StyleVars.theme];

  @override
  void initState() {
    super.initState();
    getList();
  }

  void getList() async {
    var _list = await bookDao.queryList();
    print(_list);
    setState(() {
      list = _list;
    });
  }

  String getBookDesc(BookModel book) {
    if (book.focus == BookModelFocusEnum.Balance.value) return '余额: ${book.balance}';
    return '预算: ${book.budget}';
  }

  List<NoteBook> buildBookList() {
    var bookList = list
        .map((item) => NoteBook(
              label: item.name,
              desc: getBookDesc(item),
              icon: item.icon,
              color: Color(int.parse(item.color)),
            ))
        .toList();

    return [
      ...bookList,
      NoteBook(
        isAddButton: true,
        onTap: () {
          Navigator.pushNamed(context, AddBookPage.pathName)
              .then((value) => getList());
        },
      ),
    ];
  }

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
            children: buildBookList(),
          ),
        ),
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade300))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {},
                label: Text('删除'),
                icon: Icon(Icons.delete_forever_rounded),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.red),
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
                    foregroundColor: MaterialStateProperty.all(Colors.teal),
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
