
import 'package:json_annotation/json_annotation.dart';

import '../unit_list.dart';


part 'unitlist_dto.g.dart';


@JsonSerializable()
class UnitListDto{

  late List<UnitList> getUniList;

  UnitListDto();

  factory  UnitListDto.fromJson(Map<String, dynamic> json) => _$UnitListDtoFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UnitListDtoToJson(this);

}