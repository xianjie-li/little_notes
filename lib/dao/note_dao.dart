import 'package:little_notes/common/common.dart';
import 'package:little_notes/common/db.dart';
import 'package:little_notes/dto/note_dto.dart';
import 'package:little_notes/models/index.dart';
import 'package:little_notes/models/type_model.dart';

class NoteDao {
  /// 根据id查询指定项
  Future<NoteModel?> query(int id) async {
    List<Map<String, Object?>> res =
        await DB.db.rawQuery('SELECT * FROM ${DB.NOTE} where id = $id');
    if (res.length == 0) return null;
    var current = res.first;
    return NoteModel.fromJson(current);
  }

  /// 查询列表
  Future<List<NoteDTO>> queryList(
      [String? condition, List<Object?>? arguments]) async {
    List<Map<String, Object?>> res = await DB.db.rawQuery('''
          SELECT
            n.*,
            t.id `t.id`,
            t.parentId `t.parentId`,
            t.icon `t.icon`,
            t.name `t.name`,
            t.color `t.color`,
            t.createDate `t.createDate`,
            t.updateDate `t.updateDate`,
            b.id `b.id`,
            b.focus `b.focus`,
            b.icon `b.icon`,
            b.name `b.name`,
            b.color `b.color`,
            b.balance `b.balance`,
            b.budget `b.budget`,
            b.createDate `b.createDate`,
            b.updateDate `b.updateDate`
          FROM 
            ${DB.NOTE} n,
            ${DB.TYPE} t,
            ${DB.BOOK} b
          WHERE 
            n.typeId = t.id
          AND
            n.bookId = b.id
          ${condition == null ? "" : " $condition"}
        ''', arguments);

    return res.map((r) {
      NoteModel note = NoteModel.fromJson(r);
      TypeModel? type = note.typeId == null
          ? null
          : TypeModel.fromJson(getPrefixFields('t.', r));
      BookModel book = BookModel.fromJson(getPrefixFields('b.', r));

      return NoteDTO(type, book, note);
    }).toList();
  }

  /// 增加
  Future<bool> add(NoteModel note) async {
    int id = await DB.db.rawInsert('''
      INSERT INTO ${DB.NOTE}
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
    ''', [
      note.bookId,
      note.typeId,
      note.diffType,
      note.diffNumber,
      note.remark,
      note.createDate,
      note.updateDate
    ]);

    return id is num;
  }

  /// 修改
  Future<bool> edit(NoteModel note) async {
    int id = await DB.db.rawUpdate('''
      UPDATE 
        ${DB.NOTE}
      SET
        bookId = ?,
        typeId = ?,
        diffType = ?,
        diffNumber = ?,
        remark = ?
        createDate = ?
        updateDate = ?
      WHERE
        id = ?
    ''', [
      note.bookId,
      note.typeId,
      note.diffType,
      note.diffNumber,
      note.remark,
      note.createDate,
      note.updateDate
    ]);

    return id is num;
  }

  /// 删除
  Future<int> delete(NoteModel note) async {
    int count = await DB.db.rawDelete('''
      DELETE FROM ${DB.NOTE} WHERE id = ?
    ''', [note.id]);

    return count;
  }
}
