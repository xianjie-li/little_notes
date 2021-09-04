
import 'package:flutter/material.dart';
import 'package:little_notes/common/builtin_type.dart';
import 'package:little_notes/common/date_helper.dart';
import 'package:little_notes/dao/setting_dao.dart';
import 'package:little_notes/dao/type_dao.dart';
import 'package:little_notes/models/index.dart';

/// 执行初始化操作
Future init() async {
  var settingDao = SettingDao();
  var setting = await settingDao.query();

  // 无设置项时，表示第一次初始化好
  if (setting == null) {
    await settingDao.init();

    var now = DateHelper.getSinceEpoch();
    var typeDao = TypeDao();

    var types = builtInType
        .map<TypeModel>((e) => TypeModel(
        id: 0,
        icon: e['icon'] as String,
        name: e['name'] as String,
        color: (e['color'] as Color).value.toString(),
        createDate: now,
        updateDate: now))
        .toList();

    typeDao.addAll(types);
  }




}
