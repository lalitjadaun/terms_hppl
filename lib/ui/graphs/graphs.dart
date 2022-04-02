import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:terms_hppl/ui/graphs/stockgraph_dto/stockgraph_dto.dart';
import 'package:terms_hppl/ui/graphs/stockgraph_model/stockgraph_model.dart';


import '../../Api/http_service.dart';


class BarGraphsui extends StatefulWidget {
  const BarGraphsui({Key? key}) : super(key: key);

  @override
  _BarGraphsuiState createState() => _BarGraphsuiState();
}

class _BarGraphsuiState extends State<BarGraphsui> {

  bool isLoading = false;
  late HttpService httpService;
  late StockGraphDto stockGraphDto = StockGraphDto();
  late StockGraphModel stockGraphModel;

  Future getStockGraphView() async {
    Response response;
    try {
      response = await httpService.getStockGraphView();
      if (response.statusCode == 200) {
        setState(() {
          stockGraphModel = StockGraphModel.fromJson(response.data);
        });
        print(response);
      } else {
        return Future.error(
          "Error while fetching.",
          StackTrace.fromString("${response.statusCode}"),
        );
      }
    } on SocketException {
      return Future.error('No Internet connection 😑');
    } on FormatException {
      return Future.error('Bad response format 👎');
    } on Exception catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("STOCK GRAPH CALL FAILED")));
    }
  }


  @override
  void initState() {
    httpService = HttpService();
    getStockGraphView();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:
          Image.asset(
            "assets/terms_white_logo.png",
            scale: 8,
          ),
        ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          //height: 400,
          child: SfCartesianChart(
            legend: Legend(isVisible: true),
            title: ChartTitle(text: 'Stock Data'),
            series: <ChartSeries>[
              ColumnSeries<StockGraphModel, dynamic>(
                enableTooltip: true,
                legendItemText: 'StockData',
                  selectionBehavior: SelectionBehavior(
                    enable: true,
                    toggleSelection: true
                  ),
                  //ointColorMapper: (StockData stock,_)=> stock.color,
                  dataSource: stockGraphDto.getstockgraphView,
                  xValueMapper: (StockGraphModel stock,_)=> stockGraphModel.closeStock,
                  yValueMapper: (StockGraphModel stock,_)=> int.parse(stockGraphModel.itemType.toString())),

            ],
          )
        ),
      ),
    );
  }
}
