import 'package:little_notes/common/db.dart';
import 'package:little_notes/models/book_model.dart';

class BookDao {
  /// 查询列表
  Future<List<BookModel>> queryList() async {
    List<Map<String, Object?>> res = await DB.db.rawQuery('SELECT * FROM ${DB.BOOK}');
    return res.map((e) => BookModel.fromJson(e)).toList();
  }

  /// 增加
  Future<bool> add(BookModel book) async {
    int id = await DB.db.rawInsert('''
      INSERT INTO ${DB.BOOK}
      VALUES(
        null,
        ?,
        ?,
        ?,
        ?,
        ?,
        ?,
        ?,
        ?
      );
    ''', [book.focus, book.icon, book.name, book.balance, book.budget, book.color, book.createDate, book.updateDate]);

    return id is num;
  }

  /// 修改
  Future<bool> edit(BookModel book) async {
    int id = await DB.db.rawUpdate('''
      UPDATE 
        ${DB.BOOK}
      SET
        focus = ?,
        icon = ?,
        name = ?,
        budget = ?,
        color = ?,
        updateDate = ?
      WHERE
        id = ?
    ''', [
      book.focus, book.icon, book.name, book.budget, book.color, book.updateDate,
      book.id,
    ]);

    return id is num;
  }

  /// 批量增加类型
  Future<int> delete(BookModel book) async {
    int count = await DB.db.rawDelete('''
      DELETE FROM ${DB.BOOK} WHERE id = ?
    ''', [book.id]);

    return count;
  }
}
