import 'package:little_notes/common/db.dart';
import 'package:little_notes/models/type_model.dart';

class TypeDao {

  Future<List<TypeModel>> queryList() async {
    List<Map<String, Object?>> res = await DB.db.rawQuery('SELECT * FROM ${DB.TYPE}');
    return res.map((e) => TypeModel.fromJson(e)).toList();
  }

  /// 增加类型
  Future<bool> add(TypeModel type) async {
    int id = await DB.db.rawInsert('''
      INSERT INTO ${DB.TYPE}
      VALUES(
        null,
        null,
        ?,
        ?,
        ?,
        ?,
        ?
      );
    ''', [type.icon, type.name, type.color, type.createDate, type.updateDate]);

    return id is num;
  }

  /// 批量增加类型
  Future addAll(List<TypeModel> types) async {
    var batch = DB.db.batch();

    types.forEach((type) {
      batch.rawInsert('''
      INSERT INTO ${DB.TYPE}
      VALUES(
          null,
          null,
          ?,
          ?,
          ?,
          ?,
          ?
        );
      ''', [type.icon, type.name, type.color, type.createDate, type.updateDate]);
    });

    await batch.commit();
  }
}
