// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stockgraph_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockGraphModel _$StockGraphModelFromJson(Map<String, dynamic> json) =>
    StockGraphModel()
      ..itemType = json['itemType'] as String?
      ..closeStock = json['closeStock'] as num?;

Map<String, dynamic> _$StockGraphModelToJson(StockGraphModel instance) =>
    <String, dynamic>{
      'itemType': instance.itemType,
      'closeStock': instance.closeStock,
    };
