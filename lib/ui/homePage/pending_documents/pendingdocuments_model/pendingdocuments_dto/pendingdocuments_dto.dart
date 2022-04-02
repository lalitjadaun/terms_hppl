import 'package:json_annotation/json_annotation.dart';

import '../pendingdocuments_model.dart';


part 'pendingdocuments_dto.g.dart';


@JsonSerializable()
class PendingListDto{

  late List<PendingListModel> getAllCategory= [];

  PendingListDto();

  factory  PendingListDto.fromJson(Map<String, dynamic> json) => _$PendingListDtoFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PendingListDtoToJson(this);

}