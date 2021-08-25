import 'package:flutter/material.dart';
import 'package:little_notes/dao/book_dao.dart';
import 'package:little_notes/models/book_model.dart';
import 'package:little_notes/pages/add_book_page.dart';
import 'package:little_notes/service/app_service.dart';
import 'package:little_notes/style/style_vars.dart';
import 'package:little_notes/widgets/node_book.dart';
import 'package:provider/provider.dart';

/* 账本列表，此页面在抽屉内显示 */
class BooksPage extends StatefulWidget {
  const BooksPage({Key? key}) : super(key: key);

  @override
  _BooksPageState createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {
  late BookDao bookDao;
  late AppService appService;

  @override
  void initState() {
    super.initState();
    appService = context.read<AppService>();
    bookDao = appService.bookDao;
  }

  String getBookDesc(BookModel book) {
    if (book.focus == BookModelFocusEnum.Balance.value)
      return '余额: ${book.balance}';
    return '预算: ${book.budget}';
  }

  List<NoteBook> buildBookList(BookModel? currentBook, List<BookModel> list) {
    var bookList = list
        .map((item) => NoteBook(
              label: item.name,
              desc: getBookDesc(item),
              icon: item.icon,
              color: Color(int.parse(item.color)),
              onTap: () => appService.setCurrentBook(item),
              selected: currentBook?.id == item.id,
            ))
        .toList();

    return [
      ...bookList,
      NoteBook(
        isAddButton: true,
        onTap: () {
          Navigator.pushNamed(context, AddBookPage.pathName);
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var currentBook =
        context.select<AppService, BookModel?>((state) => state.currentBook);
    var bookList =
    context.select<AppService, List<BookModel>>((state) => state.bookList);

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
            children: buildBookList(currentBook, bookList),
          ),
        ),
        if (currentBook != null)
          Container(
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () => appService.deleteBook(context, currentBook),
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
                  onPressed: () {
                    Navigator.pushNamed(context, AddBookPage.pathName, arguments: AddBookPage.editFlag);
                  },
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
