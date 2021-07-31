import 'package:flutter/foundation.dart';


@immutable
class NoteBook {

  const NoteBook({
    required this.id,
    required this.budget,
    required this.name,
    required this.cover,
  });

  final int id;
  final int budget;
  final String name;
  final String cover;

  factory NoteBook.fromJson(Map<String,dynamic> json) => NoteBook(
    id: json['id'] as int,
    budget: json['budget'] as int,
    name: json['name'] as String,
    cover: json['cover'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'budget': budget,
    'name': name,
    'cover': cover
  };

  NoteBook clone() => NoteBook(
    id: id,
    budget: budget,
    name: name,
    cover: cover
  );


  NoteBook copyWith({
    int? id,
    int? budget,
    String? name,
    String? cover
  }) => NoteBook(
    id: id ?? this.id,
    budget: budget ?? this.budget,
    name: name ?? this.name,
    cover: cover ?? this.cover,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is NoteBook && id == other.id && budget == other.budget && name == other.name && cover == other.cover;

  @override
  int get hashCode => id.hashCode ^ budget.hashCode ^ name.hashCode ^ cover.hashCode;
}
