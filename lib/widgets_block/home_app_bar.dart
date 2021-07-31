import 'package:flutter/material.dart';
import 'package:little_notes/style/style_vars.dart';

import 'home_banner.dart';
import 'home_title_button.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
  }
}
