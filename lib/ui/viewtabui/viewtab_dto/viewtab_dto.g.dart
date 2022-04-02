// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viewtab_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ViewTabDto _$ViewTabDtoFromJson(Map<String, dynamic> json) => ViewTabDto()
  ..getDtlLisrt = (json['getDtlLisrt'] as List<dynamic>)
      .map((e) => ViewTabModel.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$ViewTabDtoToJson(ViewTabDto instance) =>
    <String, dynamic>{
      'getDtlLisrt': instance.getDtlLisrt,
    };
