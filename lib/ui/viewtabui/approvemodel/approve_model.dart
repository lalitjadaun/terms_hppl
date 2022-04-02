import 'package:json_annotation/json_annotation.dart';

part 'approve_model.g.dart';

//flutter pub run build_runner build

@JsonSerializable()
class ApprovalModel{

  late int? amdNO;
  late String? appDt;
  late String? appStage;
  late String? area;
  late String? comp_code;
  late String? doc_type;
  late String? poNo;
  late String? remark;
  late String? unit_code;


  ApprovalModel();

  factory  ApprovalModel.fromJson(Map<String, dynamic> json) => _$ApprovalModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ApprovalModelToJson(this);
}