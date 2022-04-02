// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viewtab_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViewTabModel _$ViewTabModelFromJson(Map<String, dynamic> json) => ViewTabModel()
  ..doc_type = json['doc_type'] as String?
  ..doc_number = json['doc_number'] as String?
  ..doc_amd_no = json['doc_amd_no'] as int?
  ..item_code = json['item_code'] as String?
  ..item_desc = json['item_desc'] as String?
  ..uom = json['uom'] as String?
  ..doc_qty = json['doc_qty'] as String?
  ..price = json['price'] as String?
  ..discount = json['discount'] as String?
  ..tax_rate = json['tax_rate'] as String?
  ..unit_code = json['unit_code'] as String?;

Map<String, dynamic> _$ViewTabModelToJson(ViewTabModel instance) =>
    <String, dynamic>{
      'doc_type': instance.doc_type,
      'doc_number': instance.doc_number,
      'doc_amd_no': instance.doc_amd_no,
      'item_code': instance.item_code,
      'item_desc': instance.item_desc,
      'uom': instance.uom,
      'doc_qty': instance.doc_qty,
      'price': instance.price,
      'discount': instance.discount,
      'tax_rate': instance.tax_rate,
      'unit_code': instance.unit_code,
    };
