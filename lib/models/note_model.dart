import 'package:flutter/foundation.dart';


@immutable
class NoteModel {

  const NoteModel({
    required this.id,
    required this.bookId,
    this.typeId,
    required this.diffNumber,
    required this.remark,
    required this.createDate,
    required this.updateDate,
  });

  final int id;
  final int bookId;
  final int? typeId;
  final double diffNumber;
  final String remark;
  final int createDate;
  final int updateDate;

  factory NoteModel.fromJson(Map<String,dynamic> json) => NoteModel(
    id: json['id'] as int,
    bookId: json['bookId'] as int,
    typeId: json['typeId'] != null ? json['typeId'] as int : null,
    diffNumber: json['diffNumber'] as double,
    remark: json['remark'] as String,
    createDate: json['createDate'] as int,
    updateDate: json['updateDate'] as int
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'bookId': bookId,
    'typeId': typeId,
    'diffNumber': diffNumber,
    'remark': remark,
    'createDate': createDate,
    'updateDate': updateDate
  };

  NoteModel clone() => NoteModel(
    id: id,
    bookId: bookId,
    typeId: typeId,
    diffNumber: diffNumber,
    remark: remark,
    createDate: createDate,
    updateDate: updateDate
  );


  NoteModel copyWith({
    int? id,
    int? bookId,
    int? typeId,
    double? diffNumber,
    String? remark,
    int? createDate,
    int? updateDate
  }) => NoteModel(
    id: id ?? this.id,
    bookId: bookId ?? this.bookId,
    typeId: typeId ?? this.typeId,
    diffNumber: diffNumber ?? this.diffNumber,
    remark: remark ?? this.remark,
    createDate: createDate ?? this.createDate,
    updateDate: updateDate ?? this.updateDate,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is NoteModel && id == other.id && bookId == other.bookId && typeId == other.typeId && diffNumber == other.diffNumber && remark == other.remark && createDate == other.createDate && updateDate == other.updateDate;

  @override
  int get hashCode => id.hashCode ^ bookId.hashCode ^ typeId.hashCode ^ diffNumber.hashCode ^ remark.hashCode ^ createDate.hashCode ^ updateDate.hashCode;
}
