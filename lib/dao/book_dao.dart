import 'package:little_notes/common/db.dart';
import 'package:little_notes/models/book_model.dart';

class BookDao {
  /// 根据id查询指定项
  Future<BookModel?> query(int id) async {
    List<Map<String, Object?>> res =
        await DB.db.rawQuery('SELECT * FROM ${DB.BOOK} where id = $id');
    if (res.length == 0) return null;
    var current = res.first;
    return BookModel.fromJson(current);
  }

  /// 查询列表
  Future<List<BookModel>> queryList() async {
    List<Map<String, Object?>> res =
        await DB.db.rawQuery('SELECT * FROM ${DB.BOOK}');
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
    ''', [
      book.focus,
      book.icon,
      book.name,
      book.balance,
      book.budget,
      book.color,
      book.createDate,
      book.updateDate
    ]);

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
        balance = ?,
        budget = ?,
        color = ?,
        updateDate = ?
      WHERE
        id = ?
    ''', [
      book.focus,
      book.icon,
      book.name,
      book.balance,
      book.budget,
      book.color,
      book.updateDate,
      book.id,
    ]);

    return id is num;
  }

  /// 删除
  Future<int> delete(BookModel book) async {
    int count = await DB.db.rawDelete('''
      DELETE FROM ${DB.BOOK} WHERE id = ?
    ''', [book.id]);

    return count;
  }
}
