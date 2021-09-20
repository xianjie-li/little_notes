import 'package:flutter/material.dart';
import 'package:little_notes/service/app_service.dart';
import 'package:little_notes/style/style_vars.dart';
import 'package:provider/provider.dart';

import 'home_banner.dart';
import 'home_title_button.dart';

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  _HomeAppBarState createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SliverAppBar appBar = SliverAppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          HomeTitleButton(),
          Spacer(),
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: StyleVars.color,
            ))
      ],
      flexibleSpace: HomeBanner(),
      pinned: true,
      expandedHeight: 180,
      backgroundColor: StyleVars.theme,
    );

    print(appBar.toolbarHeight);

    return appBar;
  }
}
