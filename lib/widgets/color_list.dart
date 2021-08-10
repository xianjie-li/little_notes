import 'package:flutter/material.dart';

/* 渲染material colors列表并提供选中回调 */
class ColorList extends StatefulWidget {
  const ColorList({Key? key}) : super(key: key);

  @override
  _ColorListState createState() => _ColorListState();
}

class _ColorListState extends State<ColorList> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: GridView.builder(
        itemCount: Colors.primaries.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
        ),
        itemBuilder: (ctx, ind) {
          var currentColor = Colors.primaries[ind];

          return Material(
            child: InkWell(
              onTap: () {},
              child: Ink(
                color: currentColor,
              ),
            ),
          );
        },
      ),
    );
  }
}
