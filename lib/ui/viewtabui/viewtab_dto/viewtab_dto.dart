import 'package:json_annotation/json_annotation.dart';

import '../viewtab_model/viewtab_model.dart';


part 'viewtab_dto.g.dart';


@JsonSerializable()
class ViewTabDto{

  late List<ViewTabModel> getDtlLisrt;

  ViewTabDto();

  factory  ViewTabDto.fromJson(Map<String, dynamic> json) => _$ViewTabDtoFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ViewTabDtoToJson(this);

}