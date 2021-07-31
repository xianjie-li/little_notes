import 'package:flutter/foundation.dart';


@immutable
class Note {

  const Note({
    required this.id,
    required this.categoryId,
    required this.noteBookId,
    required this.money,
    required this.type,
    required this.createDate,
    this.remark,
  });

  final int id;
  final int categoryId;
  final int noteBookId;
  final int money;
  NoteTypeEnum get noteTypeEnum => _noteTypeEnumValues.map[type]!;
  final String type;
  final String createDate;
  final String? remark;

  factory Note.fromJson(Map<String,dynamic> json) => Note(
    id: json['id'] as int,
    categoryId: json['categoryId'] as int,
    noteBookId: json['noteBookId'] as int,
    money: json['money'] as int,
    type: json['type'] as String,
    createDate: json['create_date'] as String,
    remark: json['remark'] != null ? json['remark'] as String : null
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'categoryId': categoryId,
    'noteBookId': noteBookId,
    'money': money,
    'type': type,
    'create_date': createDate,
    'remark': remark
  };

  Note clone() => Note(
    id: id,
    categoryId: categoryId,
    noteBookId: noteBookId,
    money: money,
    type: type,
    createDate: createDate,
    remark: remark
  );


  Note copyWith({
    int? id,
    int? categoryId,
    int? noteBookId,
    int? money,
    String? type,
    String? createDate,
    String? remark
  }) => Note(
    id: id ?? this.id,
    categoryId: categoryId ?? this.categoryId,
    noteBookId: noteBookId ?? this.noteBookId,
    money: money ?? this.money,
    type: type ?? this.type,
    createDate: createDate ?? this.createDate,
    remark: remark ?? this.remark,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Note && id == other.id && categoryId == other.categoryId && noteBookId == other.noteBookId && money == other.money && type == other.type && createDate == other.createDate && remark == other.remark;

  @override
  int get hashCode => id.hashCode ^ categoryId.hashCode ^ noteBookId.hashCode ^ money.hashCode ^ type.hashCode ^ createDate.hashCode ^ remark.hashCode;
}

enum NoteTypeEnum { Decrease, Increase }

extension NoteTypeEnumEx on NoteTypeEnum{
  String? get value => _noteTypeEnumValues.reverse[this];
}

final _noteTypeEnumValues = _NoteTypeEnumConverter({
  'decrease': NoteTypeEnum.Decrease,
  'increase': NoteTypeEnum.Increase,
});


class _NoteTypeEnumConverter<String, O> {
  final Map<String, O> map;
  Map<O, String>? reverseMap;

  _NoteTypeEnumConverter(this.map);

  Map<O, String> get reverse => reverseMap ??= map.map((k, v) => MapEntry(v, k));
}

