import 'dart:math';

import 'package:flutter/material.dart';
import 'package:little_notes/common/common.dart';
import 'package:little_notes/common/date_helper.dart';
import 'package:little_notes/dto/note_dto.dart';
import 'package:little_notes/models/index.dart';
import 'package:little_notes/pages/add_note_page.dart';
import 'package:little_notes/pages/books_page.dart';
import 'package:little_notes/service/app_service.dart';
import 'package:little_notes/style/style_vars.dart';
import 'package:little_notes/widgets/time_list_item.dart';
import 'package:little_notes/widgets/time_list_title.dart';
import 'package:little_notes/widgets/tips.dart';
import 'package:little_notes/widgets_block/home_app_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const pathName = 'home';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AppService appService;

  @override
  void initState() {
    super.initState();
    appService = context.read<AppService>();
    appService.getLastNotes();
  }

  /// 格式化记录列表，添加标题分割和结尾最大条数提示
  List<dynamic> formatNotesList(List<NoteDTO> notes) {
    List<dynamic> list = [];

    DateTime? lastDate;

    var now = DateTime.now();

    notes.forEach((noteDTO) {
      var note = noteDTO.note;

      var ind = notes.indexOf(noteDTO);

      // 等于LAST_NOTE_NUM时，表示总数超过LAST_NOTE_NUM
      if (ind == AppService.LAST_NOTE_NUM) {
        list.add(Padding(
          padding: EdgeInsets.all(StyleVars.padding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('首页最多显示${AppService.LAST_NOTE_NUM}条记录，更多请到'),
              GestureDetector(
                onTap: () {
                  // Navigator.pushNamed(context, routeName)(context);
                  tips(context, "暂未开放喔~", Colors.orange);
                },
                child: Text(' 账单 ', style: TextStyle(color: StyleVars.theme)),
              ),
              Text('页查看'),
            ],
          ),
        ));
        return;
      }

      var d = DateTime.fromMillisecondsSinceEpoch(note.createDate);

      if (lastDate == null || !DateHelper.isSameDay(lastDate!, d)) {
        list.add(TimeListTitle(
          title: DateHelper.isSameDay(now, d)
              ? '今天'
              : '${d.month}/${d.day} 星期${weekdayMap[d.weekday.toString()]}',
          trailing: '收支:  -251',
        ));
      }

      lastDate = d;

      list.add(noteDTO);

      // 最后一条时添加提示
      if (ind == notes.length - 1) {
        list.add(Padding(
          padding: EdgeInsets.all(StyleVars.padding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('没了'),
            ],
          ),
        ));
      }
    });

    return list;
  }

  @override
  Widget build(BuildContext context) {
    var noteList = context
        .select<AppService, List<NoteDTO>>((service) => service.lastNoteList);

    var fNoteList = formatNotesList(noteList);

    return Scaffold(
        drawer: Drawer(
          child: BooksPage(),
        ),
        floatingActionButton: FloatingActionButton(
          child: Transform.rotate(
            angle: pi / 2,
            child: Image.asset(
              'lib/assets/twemoji/270f.png',
              width: 30,
            ),
          ),
          onPressed: () {
            Navigator.pushNamed(context, AddNotePage.pathName);
          },
          backgroundColor: StyleVars.theme,
        ),
        body: CustomScrollView(
          slivers: [
            HomeAppBar(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  var current = fNoteList[index];

                  if (current is Widget) {
                    return current;
                  }

                  var cType = current.type;

                  return TimeListItem(
                      title: cType?.name ?? '无分类',
                      subtitle: current.note.remark,
                      trailing:
                          '${getSymbleByDiffType(current.note.noteModelDiffTypeEnum)} ${current.note.diffNumber}',
                      trailingColor: current.note.noteModelDiffTypeEnum ==
                              NoteModelDiffTypeEnum.Raise
                          ? Colors.green
                          : StyleVars.theme,
                      icon: cType?.icon ?? '1faa5');
                },
                childCount: fNoteList.length,
              ),
            ),
          ],
        ));
  }
}
