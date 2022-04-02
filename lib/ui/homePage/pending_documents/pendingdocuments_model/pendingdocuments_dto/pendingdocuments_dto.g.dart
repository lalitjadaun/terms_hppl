// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pendingdocuments_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PendingListDto _$PendingListDtoFromJson(Map<String, dynamic> json) =>
    PendingListDto()
      ..getAllCategory = (json['getAllCategory'] as List<dynamic>)
          .map((e) => PendingListModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$PendingListDtoToJson(PendingListDto instance) =>
    <String, dynamic>{
      'getAllCategory': instance.getAllCategory,
    };
