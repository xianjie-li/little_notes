import 'package:little_notes/models/index.dart';
import 'package:little_notes/models/note_model.dart';
import 'package:flutter/foundation.dart';

@immutable
class NoteDTO {
  final TypeModel? type;
  final BookModel book;
  final NoteModel note;

  NoteDTO(this.type, this.book, this.note);
}
