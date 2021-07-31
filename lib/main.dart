import 'package:flutter/material.dart';
import 'package:little_notes/pages/home.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        primaryColor: Colors.pink.shade200,
      ),
      home: Home(),
    );
  }
}
