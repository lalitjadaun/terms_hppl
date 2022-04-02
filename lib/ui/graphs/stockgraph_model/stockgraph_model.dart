
import 'package:json_annotation/json_annotation.dart';

part 'stockgraph_model.g.dart';


//flutter pub run build_runner build

@JsonSerializable()
class StockGraphModel{
  String? itemType;
  num? closeStock;

  StockGraphModel();


  factory  StockGraphModel.fromJson(Map<String, dynamic> json) => _$StockGraphModelFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$StockGraphModelToJson(this);


}