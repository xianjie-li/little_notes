import 'package:flutter/foundation.dart';


@immutable
class TypeModel {

  const TypeModel({
    required this.id,
    this.parentId,
    required this.icon,
    required this.name,
    required this.color,
    required this.createDate,
    required this.updateDate,
  });

  final int id;
  final int? parentId;
  final String icon;
  final String name;
  final String color;
  final int createDate;
  final int updateDate;

  factory TypeModel.fromJson(Map<String,dynamic> json) => TypeModel(
    id: json['id'] as int,
    parentId: json['parentId'] != null ? json['parentId'] as int : null,
    icon: json['icon'] as String,
    name: json['name'] as String,
    color: json['color'] as String,
    createDate: json['createDate'] as int,
    updateDate: json['updateDate'] as int
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'parentId': parentId,
    'icon': icon,
    'name': name,
    'color': color,
    'createDate': createDate,
    'updateDate': updateDate
  };

  TypeModel clone() => TypeModel(
    id: id,
    parentId: parentId,
    icon: icon,
    name: name,
    color: color,
    createDate: createDate,
    updateDate: updateDate
  );


  TypeModel copyWith({
    int? id,
    int? parentId,
    String? icon,
    String? name,
    String? color,
    int? createDate,
    int? updateDate
  }) => TypeModel(
    id: id ?? this.id,
    parentId: parentId ?? this.parentId,
    icon: icon ?? this.icon,
    name: name ?? this.name,
    color: color ?? this.color,
    createDate: createDate ?? this.createDate,
    updateDate: updateDate ?? this.updateDate,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is TypeModel && id == other.id && parentId == other.parentId && icon == other.icon && name == other.name && color == other.color && createDate == other.createDate && updateDate == other.updateDate;

  @override
  int get hashCode => id.hashCode ^ parentId.hashCode ^ icon.hashCode ^ name.hashCode ^ color.hashCode ^ createDate.hashCode ^ updateDate.hashCode;
}
