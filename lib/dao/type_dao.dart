import 'package:little_notes/common/db.dart';
import 'package:little_notes/models/type_model.dart';

class TypeDao {
  /// 根据id查询指定项
  Future<TypeModel?> query(int id) async {
    List<Map<String, Object?>> res =
        await DB.db.rawQuery('SELECT * FROM ${DB.TYPE} where id = $id');
    if (res.length == 0) return null;
    var current = res.first;
    return TypeModel.fromJson(current);
  }

  /// 查询列表
  Future<List<TypeModel>> queryList() async {
    List<Map<String, Object?>> res =
        await DB.db.rawQuery('SELECT * FROM ${DB.TYPE}');
    return res.map((e) => TypeModel.fromJson(e)).toList();
  }

  /// 增加
  Future<bool> add(TypeModel type) async {
    int id = await DB.db.rawInsert('''
      INSERT INTO ${DB.TYPE}
      VALUES(
        null,
        ?,
        ?,
        ?,
        ?,
        ?,
        ?
      );
    ''', [
      type.parentId,
      type.icon,
      type.name,
      type.color,
      type.createDate,
      type.updateDate
    ]);

    return id is num;
  }

  /// 修改
  Future<bool> edit(TypeModel type) async {
    int id = await DB.db.rawUpdate('''
      UPDATE 
        ${DB.TYPE}
      SET
        parentId = ?,
        icon = ?,
        name = ?,
        color = ?,
        updateDate = ?
      WHERE
        id = ?
    ''', [
      type.parentId,
      type.icon,
      type.name,
      type.color,
      type.updateDate,
      type.id,
    ]);

    return id is num;
  }

  /// 删除
  Future<int> delete(TypeModel book) async {
    int count = await DB.db.rawDelete('''
      DELETE FROM ${DB.TYPE} WHERE id = ?
    ''', [book.id]);

    return count;
  }

  /// 批量增加类型
  Future addAll(List<TypeModel> types) async {
    var batch = DB.db.batch();

    types.forEach((type) {
      batch.rawInsert('''
        INSERT INTO ${DB.TYPE}
        VALUES(
            null,
            ?,
            ?,
            ?,
            ?,
            ?,
            ?
        );
      ''', [
        type.parentId,
        type.icon,
        type.name,
        type.color,
        type.createDate,
        type.updateDate
      ]);
    });

    await batch.commit();
  }
}
