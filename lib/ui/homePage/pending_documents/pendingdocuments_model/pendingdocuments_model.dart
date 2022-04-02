import 'package:json_annotation/json_annotation.dart';

part 'pendingdocuments_model.g.dart';

//flutter pub run build_runner build

@JsonSerializable()
class PendingListModel{

  late String? doc_type;
  late String? doc_name;
  late String? unit_cd;
  late String? po_no;
  late int? amd_no;
  late String? po_dt;
  late String? name;
  late double? po_value;
  late String? po_status;
  late String? emp_cd;
  late String? auth_level;
  late double? amt_fr;
  late double? amt_to;
  late String? poNumber;
  late String? soNumber;
  late String? indNumber;
  late String? imgUrl;
  late String? remarks;
  late String? pay_terms;


  PendingListModel(this.po_no,this.name);

  factory  PendingListModel.fromJson(Map<String, dynamic> json) => _$PendingListModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PendingListModelToJson(this);
}