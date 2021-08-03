import 'package:flutter/material.dart';
import 'package:little_notes/pages/add_book.dart';
import 'package:little_notes/pages/add_note.dart';
import 'package:little_notes/pages/home.dart';

final Map<String, WidgetBuilder> routesMap = {
  Home.pathName: (context) => Home(),
  AddBook.pathName: (context) => AddBook(),
  AddNote.pathname: (context) => AddNote(),
};
