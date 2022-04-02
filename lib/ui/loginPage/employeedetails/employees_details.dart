

import 'package:json_annotation/json_annotation.dart';

part 'employees_details.g.dart';


//flutter pub run build_runner build

@JsonSerializable()
class EmployeesDetails{
  String? emp_Id;
  String? userId;
  String? userName;
  String? userPass;
  String? userFname;
  String? unit_cd;

  EmployeesDetails();

  factory  EmployeesDetails.fromJson(Map<String, dynamic> json) => _$EmployeesDetailsFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$EmployeesDetailsToJson(this);


}