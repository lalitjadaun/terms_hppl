// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unitlist_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UnitListDto _$UnitListDtoFromJson(Map<String, dynamic> json) => UnitListDto()
  ..getUniList = (json['getUniList'] as List<dynamic>)
      .map((e) => UnitList.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$UnitListDtoToJson(UnitListDto instance) =>
    <String, dynamic>{
      'getUniList': instance.getUniList,
    };
