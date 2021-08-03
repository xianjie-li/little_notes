import 'package:flutter/material.dart';
import 'package:little_notes/common/enums.dart';
import 'package:little_notes/common/validators.dart';
import 'package:little_notes/style/style_vars.dart';
import 'package:little_notes/widgets/circular_image.dart';

class AddNote extends StatefulWidget {
  static const String pathname = 'add_note';

  const AddNote({Key? key}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('记一笔'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: StyleVars.paddingLG, right: StyleVars.paddingLG, top: StyleVars.paddingLG + 4, bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircularImage(
                    icon: '1f3e6',
                    size: SizeEnum.large,
                  ),
                  Text(
                    '-1512',
                    style: TextStyle(
                      color: StyleVars.theme,
                      fontSize: StyleVars.fsXL,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            Divider(),
            SizedBox(
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
            ),
            Divider(),
            Divider(
              height: StyleVars.padding,
              color: Colors.transparent,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: '时间',
                      hintText: '输入时间',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Divider(
                    color: Colors.transparent,
                  ),
                  TextFormField(
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: '备注',
                      hintText: '输入备注',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
