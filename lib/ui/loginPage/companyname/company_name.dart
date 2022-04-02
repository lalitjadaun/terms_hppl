

import 'package:json_annotation/json_annotation.dart';

part 'company_name.g.dart';


//flutter pub run build_runner build

@JsonSerializable()
class CompanyName{
  String? comp_code;
  String? comp_name;
  String? image_compnay;

  CompanyName();

  factory  CompanyName.fromJson(Map<String, dynamic> json) => _$CompanyNameFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CompanyNameToJson(this);


}