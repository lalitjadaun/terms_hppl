import 'package:json_annotation/json_annotation.dart';
import '../employeedetails/employees_details.dart';

part 'userdetail.g.dart';

//flutter pub run build_runner build

@JsonSerializable()
class UserDetails {
  bool? status;
  String? msg;
  EmployeesDetails? model;
  // List<EmployeesDetails> getuserDetails =[];

  UserDetails();

  factory UserDetails.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);
}
