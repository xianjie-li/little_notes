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

    syncDatas();
  }

  /// 更新应用的主要数据
  /// 1. 会同时执行以下操作，更新已选中账本
  /// 2. 获取最近记录列表
  /// 3. 已选择账本时，更新该账本
  /// 2. 如果没有选择账本，选择列表中第一项
  /// 3. 计算统计项
  Future syncDatas() async {
    print('getBooks');
    bookList = await bookDao.queryList();

    // 更新当前账本
    if (bookList.length > 0 && currentBook != null) {
      var nCurrentInd =
          bookList.indexWhere((element) => element.id == currentBook!.id);

      currentBook = nCurrentInd == -1 ? null : bookList[nCurrentInd];
    }

    // 如果未选择账本，则自动选择
    if (bookList.length > 0 && currentBook == null) {
      currentBook = bookList.first;
    }

    await getLastNotes();

    await getMonthCounts();

    notifyListeners();
  }

  /// 新增/编辑 账本
  Future<bool> addOrEditBook(BuildContext context, BookModel book,
      [bool isEdit = false]) async {
    try {
      isEdit ? await bookDao.edit(book) : await bookDao.add(book);

      tips(context, isEdit ? '修改完成!' : '添加完成!', Colors.green);

      syncDatas();

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

        syncDatas();
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

  /// 最近LAST_NOTE_NUM + 1条记录, 额外的一条用于检测是否有超过50条数据
  List<NoteDTO> lastNoteList = [];

  /// 本月记录
  List<NoteDTO> monthNoteList = [];

  /// 本月的统计信息
  Map<String, double> monthCounts = {
    "month": 0, // 账本月
    "balance": 0, // 余额
    "monthBudget": 0, // 月预算
    "dayBudget": 0, // 日预算
    "monthIn": 0, // 月入
    "monthOut": 0, // 月出
  };

  /// 要查询的最近note记录数量
  static const int LAST_NOTE_NUM = 50;

  /// 新增/编辑 记录
  Future<bool> addOrEditNote(BuildContext context, NoteModel note,
      [bool isEdit = false]) async {
    try {
      // 查询关联账本的最新信息
      var book = await bookDao.query(note.bookId) as BookModel;

      if (isEdit) {
        // TODO: 修改逻辑正确性测试
        // 查询关联记录的历史信息
        var oldNote = await noteDao.query(note.id) as NoteModel;
        // 计算两次记录的前后差异值
        var diff = note.diffNumber - oldNote.diffNumber;

        book = book.copyWith(balance: book.balance + diff);
      } else {
        book = book.copyWith(balance: book.balance + note.diffNumber);
      }

      isEdit ? await noteDao.edit(note) : await noteDao.add(note);

      // 更新book记录
      await bookDao.edit(book);
      // 更新账本列表
      await syncDatas();

      tips(context, isEdit ? '已修改!' : '已提交!', Colors.green);

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

    if (currentBook == null) return [];

    lastNoteList = await noteDao.queryList('''
        WHERE
          b.id = ${currentBook!.id}
        ORDER BY createDate DESC
        LIMIT 0, ${AppService.LAST_NOTE_NUM + 1}
      ''');
    print(lastNoteList);
    notifyListeners();
  }

  /// 获取并设置monthNoteList
  Future getMonthCounts() async {
    print('getMonthCounts');

    if (currentBook == null) return monthCounts;

    var now = DateTime.now();
    var start = DateTime(now.year, now.month, 1, 0, 0, 0);
    var end = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
    // 本月剩余的天数
    var remainDay = end.day - now.day;

    monthNoteList = await noteDao.queryList('''
        WHERE
          b.id = ${currentBook!.id}
        AND
          n.createDate >= ${start.millisecondsSinceEpoch}
        AND
          n.createDate <= ${end.millisecondsSinceEpoch}
        ORDER BY createDate DESC
      ''');

    monthCounts['month'] = now.month.toDouble();
    monthCounts['balance'] = currentBook!.balance;
    monthCounts['monthBudget'] = currentBook!.budget;
    monthCounts['dayBudget'] = 0;
    monthCounts['monthIn'] = 0;
    monthCounts['monthOut'] = 0;

    monthNoteList.forEach((noteDTO) {
      var note = noteDTO.note;
      var diffNumber = note.diffNumber;

      // 余额增加不影响预算
      if (diffNumber < 0) {
        monthCounts['monthBudget'] =
            monthCounts['monthBudget']! + note.diffNumber;
        monthCounts['monthOut'] = monthCounts['monthOut']! + diffNumber.abs();
      } else {
        monthCounts['monthIn'] = monthCounts['monthIn']! + diffNumber;
      }
    });

    monthCounts['dayBudget'] = monthCounts['monthBudget']! / remainDay;

    monthCounts = {...monthCounts};

    print(monthCounts);

    notifyListeners();
  }
}
