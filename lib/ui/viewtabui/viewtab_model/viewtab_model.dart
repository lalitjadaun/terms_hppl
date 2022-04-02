import 'package:json_annotation/json_annotation.dart';

part 'viewtab_model.g.dart';

//flutter pub run build_runner build

@JsonSerializable()
class ViewTabModel{

  late String? doc_type;
  late String? doc_number;
  late int? doc_amd_no;
  late String? item_code;
  late String? item_desc;
  late String? uom;
  late String? doc_qty;
  late String? price;
  late String? discount;
  late String? tax_rate;
  late String? unit_code;

  ViewTabModel();

  factory  ViewTabModel.fromJson(Map<String, dynamic> json) => _$ViewTabModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$ViewTabModelToJson(this);
}