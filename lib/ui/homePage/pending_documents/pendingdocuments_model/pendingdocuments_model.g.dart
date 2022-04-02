// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pendingdocuments_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendingListModel _$PendingListModelFromJson(Map<String, dynamic> json) =>
    PendingListModel(
      json['po_no'] as String?,
      json['name'] as String?,
    )
      ..doc_type = json['doc_type'] as String?
      ..doc_name = json['doc_name'] as String?
      ..unit_cd = json['unit_cd'] as String?
      ..amd_no = json['amd_no'] as int?
      ..po_dt = json['po_dt'] as String?
      ..po_value = (json['po_value'] as num?)?.toDouble()
      ..po_status = json['po_status'] as String?
      ..emp_cd = json['emp_cd'] as String?
      ..auth_level = json['auth_level'] as String?
      ..amt_fr = (json['amt_fr'] as num?)?.toDouble()
      ..amt_to = (json['amt_to'] as num?)?.toDouble()
      ..poNumber = json['poNumber'] as String?
      ..soNumber = json['soNumber'] as String?
      ..indNumber = json['indNumber'] as String?
      ..imgUrl = json['imgUrl'] as String?
      ..remarks = json['remarks'] as String?
      ..pay_terms = json['pay_terms'] as String?;

Map<String, dynamic> _$PendingListModelToJson(PendingListModel instance) =>
    <String, dynamic>{
      'doc_type': instance.doc_type,
      'doc_name': instance.doc_name,
      'unit_cd': instance.unit_cd,
      'po_no': instance.po_no,
      'amd_no': instance.amd_no,
      'po_dt': instance.po_dt,
      'name': instance.name,
      'po_value': instance.po_value,
      'po_status': instance.po_status,
      'emp_cd': instance.emp_cd,
      'auth_level': instance.auth_level,
      'amt_fr': instance.amt_fr,
      'amt_to': instance.amt_to,
      'poNumber': instance.poNumber,
      'soNumber': instance.soNumber,
      'indNumber': instance.indNumber,
      'imgUrl': instance.imgUrl,
      'remarks': instance.remarks,
      'pay_terms': instance.pay_terms,
    };
