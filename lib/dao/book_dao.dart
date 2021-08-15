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
        ?
      );
    ''', [book.focus, book.icon, book.name, book.balance, book.budget, book.createDate, book.updateDate]);

    return id is num;
  }
}