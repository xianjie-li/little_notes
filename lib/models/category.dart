import 'package:flutter/foundation.dart';


@immutable
class Category {

  const Category({
    required this.id,
    required this.parent,
    required this.name,
    required this.icon,
  });

  final int id;
  final int parent;
  final String name;
  final String icon;

  factory Category.fromJson(Map<String,dynamic> json) => Category(
    id: json['id'] as int,
    parent: json['parent'] as int,
    name: json['name'] as String,
    icon: json['icon'] as String
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'parent': parent,
    'name': name,
    'icon': icon
  };

  Category clone() => Category(
    id: id,
    parent: parent,
    name: name,
    icon: icon
  );


  Category copyWith({
    int? id,
    int? parent,
    String? name,
    String? icon
  }) => Category(
    id: id ?? this.id,
    parent: parent ?? this.parent,
    name: name ?? this.name,
    icon: icon ?? this.icon,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Category && id == other.id && parent == other.parent && name == other.name && icon == other.icon;

  @override
  int get hashCode => id.hashCode ^ parent.hashCode ^ name.hashCode ^ icon.hashCode;
}
