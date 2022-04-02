import 'package:json_annotation/json_annotation.dart';
import '../stockgraph_model/stockgraph_model.dart';
part 'stockgraph_dto.g.dart';

@JsonSerializable()
class StockGraphDto{

   List<StockGraphModel> getstockgraphView= [];

  StockGraphDto();

  factory  StockGraphDto.fromJson(Map<String, dynamic> json) => _$StockGraphDtoFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$StockGraphDtoToJson(this);

}