import 'package:flutter/material.dart';
import 'package:little_notes/widgets/circular_image.dart';

/* 分类列表 */
class CateList extends StatelessWidget {
  const CateList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 168,
      child: Scrollbar(
        radius: Radius.circular(2),
        thickness: 2,
        child: Column(
          children: [
            Expanded(
                child: GridView.count(
              crossAxisCount: 2,
              scrollDirection: Axis.horizontal,
              childAspectRatio: 1,
              mainAxisSpacing: 0,
              crossAxisSpacing: 6,
              children: List.generate(
                  30,
                  (index) => Center(
                        child: CircularImage(
                          icon: '1f6b5-1f3fb-200d-2640-fe0f',
                          label: '分类$index',
                          selected: index == 4,
                        ),
                      )),
            )),
            Divider(
              color: Colors.transparent,
              height: 6,
            ),
          ],
        ),
      ),
    );
  }
}
