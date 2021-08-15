import 'package:flutter/material.dart';
import 'package:little_notes/pages/add_book_page.dart';
import 'package:little_notes/pages/add_note_page.dart';
import 'package:little_notes/pages/add_type_page.dart';
import 'package:little_notes/pages/emoji_picker_page.dart';
import 'package:little_notes/pages/home_page.dart';
import 'package:little_notes/pages/type_page.dart';

final Map<String, WidgetBuilder> routesMap = {
  HomePage.pathName: (context) => HomePage(),
  AddBookPage.pathName: (context) => AddBookPage(),
  AddNotePage.pathName: (context) => AddNotePage(),
  TypePage.pathName: (context) => TypePage(),
  AddTypePage.pathName: (context) => AddTypePage(),
  EmojiPickerPage.pathName: (context) => EmojiPickerPage(),
};
