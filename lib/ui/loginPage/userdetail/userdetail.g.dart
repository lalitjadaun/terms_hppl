// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userdetail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetails _$UserDetailsFromJson(Map<String, dynamic> json) => UserDetails()
  ..status = json['status'] as bool?
  ..msg = json['msg'] as String?
  ..model = json['model'] == null
      ? null
      : EmployeesDetails.fromJson(json['model'] as Map<String, dynamic>);

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) =>
    <String, dynamic>{
      'status': instance.status,
      'msg': instance.msg,
      'model': instance.model,
    };
