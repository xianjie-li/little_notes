import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:little_notes/common/init.dart';
import 'package:little_notes/pages/home_page.dart';
import 'package:little_notes/routes/routes.dart';
import 'package:little_notes/common/db.dart';
import 'package:little_notes/service/app_service.dart';
import 'package:little_notes/style/style_vars.dart';
import 'package:provider/provider.dart';

void main() async {
  /* 💥 注意，一定要在 open 之后才能访问 DB.db */
  await DB().open();

  await init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AppService()),
    ],
    child: App(),
  ));
}

class App extends StatelessWidget {
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
