// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employees_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeesDetails _$EmployeesDetailsFromJson(Map<String, dynamic> json) =>
    EmployeesDetails()
      ..emp_Id = json['emp_Id'] as String?
      ..userId = json['userId'] as String?
      ..userName = json['userName'] as String?
      ..userPass = json['userPass'] as String?
      ..userFname = json['userFname'] as String?
      ..unit_cd = json['unit_cd'] as String?;

Map<String, dynamic> _$EmployeesDetailsToJson(EmployeesDetails instance) =>
    <String, dynamic>{
      'emp_Id': instance.emp_Id,
      'userId': instance.userId,
      'userName': instance.userName,
      'userPass': instance.userPass,
      'userFname': instance.userFname,
      'unit_cd': instance.unit_cd,
    };
