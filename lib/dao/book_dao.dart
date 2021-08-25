import 'package:little_notes/common/db.dart';
import 'package:little_notes/models/book_model.dart';

class BookDao {
  final String tableName = 'book';

  void query(int id) async {
    List<Map<String, Object?>> res = await DB.db.rawQuery('SELECT * FROM $tableName where id = $id');
    print(res);
  }

  Future<List<BookModel>> queryList() async {
    List<Map<String, Object?>> res = await DB.db.rawQuery('SELECT * FROM $tableName');
    return res.map((e) => BookModel.fromJson(e)).toList();
  }

  Future<bool> add(BookModel book) async {
    int id = await DB.db.rawInsert('''
      INSERT INTO $tableName
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

  Future<bool> edit(BookModel book) async {
    int id = await DB.db.rawUpdate('''
      UPDATE 
        $tableName
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

  Future<int> delete(BookModel book) async {
    int count = await DB.db.rawDelete('''
      DELETE FROM $tableName WHERE id = ?
    ''', [book.id]);

    return count;
  }
}
