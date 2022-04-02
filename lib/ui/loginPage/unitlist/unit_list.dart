

import 'package:json_annotation/json_annotation.dart';

part 'unit_list.g.dart';


//flutter pub run build_runner build

@JsonSerializable()
class UnitList{
  String? user_line_id;
  String? userId;
  String? unitcode;
  String? name;
  String? comp_code;


  UnitList();

  factory  UnitList.fromJson(Map<String, dynamic> json) => _$UnitListFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UnitListToJson(this);


}