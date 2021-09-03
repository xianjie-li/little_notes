import 'package:little_notes/common/db.dart';
import 'package:little_notes/models/index.dart';

class SettingDao {
  Future<SettingModel?> query() async {
    List<Map<String, Object?>> res = await DB.db.rawQuery('SELECT currentBookId FROM ${DB.SETTING}');
    SettingModel? setting;

    if (res.isNotEmpty) {
      setting = SettingModel.fromJson(res.first);
    }

    return setting;
  }

  Future edit(String key, Object val) async {
    await DB.db.rawUpdate('''
      UPDATE 
        ${DB.SETTING}
      SET
        ? = ?
    ''', [key, val]);
  }

  Future init() async {
    await DB.db.rawInsert('''
      INSERT INTO
        ${DB.SETTING}
      VALUES(
        null
      )
    ''');
  }
}
