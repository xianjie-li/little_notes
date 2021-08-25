import 'package:flutter/material.dart';
import 'package:little_notes/service/app_service.dart';
import 'package:little_notes/style/style_vars.dart';
import 'package:provider/provider.dart';

class HomeTitleButton extends StatelessWidget {
  const HomeTitleButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Consumer<AppService>(builder: (_, appService, __) {
      var book = appService.currentBook;

      return InkWell(
        onTap: Scaffold.of(context).openDrawer,
        child: Row(
          children: [
            if (book?.icon != null)
              Image.asset(
                'lib/assets/twemoji/${book!.icon}.png',
                width: 20,
              ),
            Divider(
              indent: 4,
            ),
            Text(
              book?.name ?? '-',
              style: TextStyle(color: StyleVars.colorTitle),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: StyleVars.colorTitle,
            ),
          ],
        ),
      );
    });
  }
}
