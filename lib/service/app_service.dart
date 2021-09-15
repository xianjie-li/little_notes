import 'package:flutter/material.dart';
import 'package:little_notes/dao/book_dao.dart';
import 'package:little_notes/dao/note_dao.dart';
import 'package:little_notes/dao/type_dao.dart';
import 'package:little_notes/dto/note_dto.dart';
import 'package:little_notes/models/book_model.dart';
import 'package:little_notes/models/index.dart';
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

  /**
   * ################################
   * 账本
   * ################################
   * */

  ///
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
  Future<bool> addOrEditBook(BuildContext context, BookModel book,
      [bool isEdit = false]) async {
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

  /**
   * ################################
   * 分类
   * ################################
   * */

  ///
  TypeDao typeDao = TypeDao();

  /// 分类列表
  List<TypeModel> typeList = [];

  /// 获取分类列表
  Future getTypes() async {
    print('getTypes');
    var list = await typeDao.queryList();
    typeList = list;
    print(typeList);
    notifyListeners();
  }

  /// 新增/编辑 分类
  Future<bool> addOrEditType(BuildContext context, TypeModel type,
      [bool isEdit = false]) async {
    try {
      isEdit ? await typeDao.edit(type) : await typeDao.add(type);

      tips(context, isEdit ? '修改完成!' : '添加完成!', Colors.green);

      getTypes();

      return true;
    } on DatabaseException catch (err) {
      if (err.isUniqueConstraintError()) {
        tips(context, '该分类已存在', Colors.red);
      } else {
        tips(context, '写入数据失败, code: ${err.getResultCode()}', Colors.red);
      }
    } catch (err) {
      tips(context, '操作异常', Colors.red);
    }

    return false;
  }

  /// 删除指定类型
  Future deleteType(BuildContext context, TypeModel type) async {
    var confirm = await confirmTips(
        context,
        ConfirmTip(
            title: Text('确认删除类型 “${type.name}” 吗?, 删除后无法恢复并且关联的账单会变无分类账单😈。')));

    if (!(confirm is bool) || !confirm) return;

    try {
      var count = await typeDao.delete(type);

      if (count == 0) {
        tips(context, '没有找到该分类', Colors.orange);
      }

      if (count > 0) {
        tips(context, '删除完成', Colors.green);

        getTypes();
      }
    } on DatabaseException catch (err) {
      tips(context, '数据操作失败, code: ${err.getResultCode()}', Colors.red);
    } catch (err) {
      tips(context, '操作异常', Colors.red);
    }
  }

  ///
  NoteDao noteDao = NoteDao();

  /// 最近50条记录
  List<NoteDTO> lastNoteList = [];

  /// 新增/编辑 记录
  Future<bool> addOrEditNote(BuildContext context, NoteModel note,
      [bool isEdit = false]) async {
    try {
      isEdit ? await noteDao.edit(note) : await noteDao.add(note);

      tips(context, isEdit ? '已修改!' : '已提交!', Colors.green);

      // getTypes();

      return true;
    } on DatabaseException catch (err) {
      tips(context, '写入数据失败, code: ${err.getResultCode()}', Colors.red);
    } catch (err) {
      tips(context, '操作异常', Colors.red);
    }

    return false;
  }

  /// 获取并设置 lastNoteList
  Future getLastNotes() async {
    print('getLastNotes');
    var list = await noteDao.queryList('''
        ORDER BY createDate DESC
        LIMIT 0, 50
      ''');
    lastNoteList = list;
    print(lastNoteList);
    notifyListeners();
  }
}
