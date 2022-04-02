// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stockgraph_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockGraphDto _$StockGraphDtoFromJson(Map<String, dynamic> json) =>
    StockGraphDto()
      ..getstockgraphView = (json['getstockgraphView'] as List<dynamic>)
          .map((e) => StockGraphModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$StockGraphDtoToJson(StockGraphDto instance) =>
    <String, dynamic>{
      'getstockgraphView': instance.getstockgraphView,
    };
