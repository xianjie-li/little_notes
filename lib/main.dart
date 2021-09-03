import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:little_notes/common/builtin_type.dart';
import 'package:little_notes/common/date_helper.dart';
import 'package:little_notes/dao/setting_dao.dart';
import 'package:little_notes/models/index.dart';
import 'package:little_notes/pages/home_page.dart';
import 'package:little_notes/routes/routes.dart';
import 'package:little_notes/common/db.dart';
import 'package:little_notes/service/app_service.dart';
import 'package:little_notes/style/style_vars.dart';
import 'package:provider/provider.dart';

void main() async {
  await DB().open();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AppService()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp() {
    init();
  }

  /// 这里进行一些初始化操作
  void init() async {
    var settingDao = SettingDao();
    var setting = await settingDao.query();

    if (setting == null) {
      await settingDao.init();
    }

    var now = DateHelper.getSinceEpoch();

    var gg = builtInType
        .map<TypeModel>((e) => TypeModel(
        id: 0,
        icon: e['icon'] as String,
        name: e['name'] as String,
        color: (e['color'] as Color).value.toString(),
        createDate: now,
        updateDate: now))
        .toList();

    print(gg);

    // DB.db.execute('delete from setting');
    print(setting);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: StyleVars.theme,
      ),
      initialRoute: HomePage.pathName,
      routes: routesMap,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('zh', 'CH'),
        Locale('en', 'US'),
      ],
    );
  }
}
