import 'package:flutter/material.dart';
import 'package:little_notes/dao/book_dao.dart';
import 'package:little_notes/models/book_model.dart';
import 'package:little_notes/widgets/tips.dart';
import 'package:sqflite/sqflite.dart';

// 组件就是控制器，负责组织和拼装service来执行一组业务操作, 组件负责收集传递给service的参数和处理其返回以及触发sercice
// service管理和操作多个dao存储，同时也负责存储其对应模块的应用状态
// 当对dao进行单次操作时，可以直接在组件层进行操作
// dao为数据存储层，对底层数据进行实际操作
class AppService extends ChangeNotifier {
  AppService() {
    // 初始化时查出当前笔记列表
    getBooks();
  }

  BookDao bookDao = BookDao();

  /// 账本列表
  List<BookModel> bookList = [];

  /// 当前账本
  BookModel? currentBook;

  /// 设置当前账本
  void setCurrentBook(BookModel book) {
    currentBook = book;
    notifyListeners();
  }

  /// 获取账本列表
  Future getBooks() async {
    print('getBooks');
    var list = await bookDao.queryList();
    bookList = list;
    notifyListeners();
  }

  /// 新增/编辑 账本
  Future<bool> addOrEditBook(BuildContext context, BookModel book, [bool isEdit = false]) async {
    try {
      isEdit ? await bookDao.edit(book) : await bookDao.add(book);

      tips(context, isEdit ? '修改完成!' : '添加完成!', Colors.green);

      getBooks();

      return true;
    } on DatabaseException catch (err) {
      if (err.isUniqueConstraintError()) {
        tips(context, '该账本已存在', Colors.red);
      } else {
        tips(context, '写入数据失败, code: ${err.getResultCode()}', Colors.red);
      }
    } catch (err) {
      tips(context, '操作异常', Colors.red);
    }

    return false;
  }

  /// 删除指定账本
  Future deleteBook(BuildContext context, BookModel book) async {
    var confirm = await confirmTips(context,
        ConfirmTip(title: Text('确认删除账本 “${book.name}” 吗?, 账本删除后无法恢复😈。')));

    if (!(confirm is bool) || !confirm) return;

    try {
      var count = await bookDao.delete(book);

      if (count == 0) {
        tips(context, '没有找到该账本', Colors.orange);
      }

      if (count > 0) {
        tips(context, '删除完成', Colors.green);

        // 如果删除账本被选中，清空选中状态
        if (currentBook != null && currentBook!.id == book.id) {
          currentBook = null;
        }

        getBooks();
      }
    } on DatabaseException catch (err) {
      tips(context, '数据操作失败, code: ${err.getResultCode()}', Colors.red);
    } catch (err) {
      tips(context, '操作异常', Colors.red);
    }
  }
}
