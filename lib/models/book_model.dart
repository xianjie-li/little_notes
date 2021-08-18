import 'package:flutter/foundation.dart';


@immutable
class BookModel {

  const BookModel({
    required this.id,
    required this.focus,
    required this.icon,
    required this.name,
    required this.color,
    required this.balance,
    required this.budget,
    required this.createDate,
    required this.updateDate,
  });

  final int id;
  BookModelFocusEnum get bookModelFocusEnum => _bookModelFocusEnumValues.map[focus]!;
  final String focus;
  final String icon;
  final String name;
  final String color;
  final double balance;
  final double budget;
  final int createDate;
  final int updateDate;

  factory BookModel.fromJson(Map<String,dynamic> json) => BookModel(
    id: json['id'] as int,
    focus: json['focus'] as String,
    icon: json['icon'] as String,
    name: json['name'] as String,
    color: json['color'] as String,
    balance: json['balance'] as double,
    budget: json['budget'] as double,
    createDate: json['createDate'] as int,
    updateDate: json['updateDate'] as int
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'focus': focus,
    'icon': icon,
    'name': name,
    'color': color,
    'balance': balance,
    'budget': budget,
    'createDate': createDate,
    'updateDate': updateDate
  };

  BookModel clone() => BookModel(
    id: id,
    focus: focus,
    icon: icon,
    name: name,
    color: color,
    balance: balance,
    budget: budget,
    createDate: createDate,
    updateDate: updateDate
  );


  BookModel copyWith({
    int? id,
    String? focus,
    String? icon,
    String? name,
    String? color,
    double? balance,
    double? budget,
    int? createDate,
    int? updateDate
  }) => BookModel(
    id: id ?? this.id,
    focus: focus ?? this.focus,
    icon: icon ?? this.icon,
    name: name ?? this.name,
    color: color ?? this.color,
    balance: balance ?? this.balance,
    budget: budget ?? this.budget,
    createDate: createDate ?? this.createDate,
    updateDate: updateDate ?? this.updateDate,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is BookModel && id == other.id && focus == other.focus && icon == other.icon && name == other.name && color == other.color && balance == other.balance && budget == other.budget && createDate == other.createDate && updateDate == other.updateDate;

  @override
  int get hashCode => id.hashCode ^ focus.hashCode ^ icon.hashCode ^ name.hashCode ^ color.hashCode ^ balance.hashCode ^ budget.hashCode ^ createDate.hashCode ^ updateDate.hashCode;
}

enum BookModelFocusEnum { Budget, Balance }

extension BookModelFocusEnumEx on BookModelFocusEnum{
  String? get value => _bookModelFocusEnumValues.reverse[this];
}

final _bookModelFocusEnumValues = _BookModelFocusEnumConverter({
  'budget': BookModelFocusEnum.Budget,
  'balance': BookModelFocusEnum.Balance,
});


class _BookModelFocusEnumConverter<String, O> {
  final Map<String, O> map;
  Map<O, String>? reverseMap;

  _BookModelFocusEnumConverter(this.map);

  Map<O, String> get reverse => reverseMap ??= map.map((k, v) => MapEntry(v, k));
}

