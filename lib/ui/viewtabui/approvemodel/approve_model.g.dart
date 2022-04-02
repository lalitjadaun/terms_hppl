// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approve_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApprovalModel _$ApprovalModelFromJson(Map<String, dynamic> json) =>
    ApprovalModel()
      ..amdNO = json['amdNO'] as int?
      ..appDt = json['appDt'] as String?
      ..appStage = json['appStage'] as String?
      ..area = json['area'] as String?
      ..comp_code = json['comp_code'] as String?
      ..doc_type = json['doc_type'] as String?
      ..poNo = json['poNo'] as String?
      ..remark = json['remark'] as String?
      ..unit_code = json['unit_code'] as String?;

Map<String, dynamic> _$ApprovalModelToJson(ApprovalModel instance) =>
    <String, dynamic>{
      'amdNO': instance.amdNO,
      'appDt': instance.appDt,
      'appStage': instance.appStage,
      'area': instance.area,
      'comp_code': instance.comp_code,
      'doc_type': instance.doc_type,
      'poNo': instance.poNo,
      'remark': instance.remark,
      'unit_code': instance.unit_code,
    };
