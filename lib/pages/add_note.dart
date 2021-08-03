import 'package:flutter/material.dart';

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
      body: Text('新增'),
    );
  }
}
