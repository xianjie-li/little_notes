import 'package:flutter/foundation.dart';


@immutable
class SettingModel {

  const SettingModel({
    this.currentBookId,
  });

  final int? currentBookId;

  factory SettingModel.fromJson(Map<String,dynamic> json) => SettingModel(
    currentBookId: json['currentBookId'] != null ? json['currentBookId'] as int : null
  );
  
  Map<String, dynamic> toJson() => {
    'currentBookId': currentBookId
  };

  SettingModel clone() => SettingModel(
    currentBookId: currentBookId
  );


  SettingModel copyWith({
    int? currentBookId
  }) => SettingModel(
    currentBookId: currentBookId ?? this.currentBookId,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is SettingModel && currentBookId == other.currentBookId;

  @override
  int get hashCode => currentBookId.hashCode;
}
