

import 'package:json_annotation/json_annotation.dart';

part 'login_call.g.dart';


//flutter pub run build_runner build

@JsonSerializable()
class LoginCall{
  String? unit_cd;
  String? userId;
  String? userPass;

  LoginCall();

  factory  LoginCall.fromJson(Map<String, dynamic> json) => _$LoginCallFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$LoginCallToJson(this);


}