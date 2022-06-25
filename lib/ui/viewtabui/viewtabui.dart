import 'dart:io';
import 'package:animated_widgets/animated_widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:terms_hppl/ui/viewtabui/viewtab_dto/viewtab_dto.dart';
import 'package:terms_hppl/ui/viewtabui/viewtab_model/viewtab_model.dart';
import '../../Api/http_service.dart';
import '../../utils/Helper.dart';
import '../routes/my_routes.dart';
import 'approvemodel/approve_model.dart';

class ViewTabUI extends StatefulWidget {
  const ViewTabUI({Key? key}) : super(key: key);

  @override
  _ViewTabUIState createState() => _ViewTabUIState();
}

class _ViewTabUIState extends State<ViewTabUI> {
  final boolState = StateProvider<bool>((ref) {
    return false;
  });

  bool isLoading = false;
  late HttpService httpService;
  late ViewTabDto viewTabDto;
  late ViewTabModel viewTabModel;
  late ApprovalModel approvalModel;

  int itemCount = 0;

  void configLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.yellow
      ..backgroundColor = Colors.green
      ..indicatorColor = Colors.yellow
      ..textColor = Colors.yellow
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true;
    // ..customAnimation = CustomAnimation();
  }

  TextEditingController remarks = TextEditingController();

  //View Tab Details
  Future getViewTabDetails(int doc_amd_no, String doc_number) async {
    EasyLoading.show();
    Response response;
    try {
      response = await httpService.getViewTabDetails(doc_amd_no, doc_number);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        viewTabDto = ViewTabDto.fromJson(response.data);
        setState(() {
          itemCount = viewTabDto.getDtlLisrt.length;
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
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("View Tab CALL FAILED")));
    }
  }

  //Approve and revert
  Future getApproveandRevert(
      int amdNO,
      String appDt,
      String appStage,
      String area,
      String comp_code,
      String doc_type,
      String poNo,
      String remark,
      String unit_code) async {
    EasyLoading.show();
    Response response;
    try {
      response = await httpService.getApproveandRevert(amdNO, appDt, appStage,
          area, comp_code, doc_type, poNo, remark, unit_code);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        approvalModel = ApprovalModel.fromJson(response.data);

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
      EasyLoading.dismiss();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Approve CALL FAILED")));
    }
  }

  final String formatted = DateFormat('dd-MMM-yy').format(DateTime.now());

  late String unit_cd = "";

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => Dialog(
          elevation: 8.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: SingleChildScrollView(
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  height: 200,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      Container(
                          width: 200,
                          height: 100,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: TextField(
                            maxLines: null,
                            controller: remarks,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration.collapsed(
                              hintText: "  Enter Your Remark Here",
                            ),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              getApproveandRevert(
                                Helper.getamd_no(),
                                formatted,
                                Helper.getappStage(),
                                Helper.getuserName(),
                                "",
                                Helper.getdoc_type(),
                                Helper.getdoc_number(),
                                remarks.text.toString(),
                                Helper.getunit_cd(),
                              );
                              Navigator.popUntil(context,
                                  (Route<dynamic> route) {
                                bool shouldPop = false;
                                if (route.settings.name ==
                                    MyRoutes.PurchaseOrder) {
                                  shouldPop = true;
                                }
                                return shouldPop;
                              });
                            },
                            child: const Text(
                              "Approve",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.lightGreen,
                                minimumSize: const Size(40, 30),
                                elevation: 8.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0))),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              getApproveandRevert(
                                Helper.getamd_no(),
                                //"22-Mar-22",
                                formatted,
                                Helper.getappStage(),
                                Helper.getuserName(),
                                "",
                                Helper.getdoc_type(),
                                Helper.getdoc_number(),
                                remarks.text.toString(),
                                Helper.getunit_cd(),
                              );
                              Navigator.popUntil(context,
                                  (Route<dynamic> route) {
                                bool shouldPop = false;
                                if (route.settings.name ==
                                    MyRoutes.PurchaseOrder) {
                                  shouldPop = true;
                                }
                                return shouldPop;
                              });
                            },
                            child: const Text(
                              "Revert",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            style: ElevatedButton.styleFrom(
                                primary: Colors.redAccent,
                                minimumSize: const Size(50, 30),
                                elevation: 8.0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0))),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                    top: -50,
                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      child: Image.asset(
                        "assets/terms_white_logo.png",
                        scale: 8,
                      ),
                      radius: 40,
                    ))
              ],
            ),
          )));

  @override
  void initState() {
    httpService = HttpService();
    super.initState();
    getViewTabDetails(Helper.getamd_no(), Helper.getdoc_number());
    EasyLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Image.asset(
          "assets/terms_white_logo.png",
          alignment: Alignment.center,
          scale: 8,
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Helper.getdoc_name(),
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(Helper.getdoc_number(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ),
          Expanded(
              child: SafeArea(
            child: ListView.builder(
                itemCount: itemCount,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OpacityAnimatedWidget.tween(
                      opacityDisabled: 0,
                      opacityEnabled: 1,
                      duration: const Duration(milliseconds: 1200),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    Helper.getdoc_name(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    viewTabDto.getDtlLisrt
                                            .elementAt(index)
                                            .item_code ??
                                        "",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 1,
                              color: Colors.black,
                              width: MediaQuery.of(context).size.width,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Product Name            :    ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  SizedBox(
                                      width: 120,
                                      child: Text(
                                        viewTabDto.getDtlLisrt
                                                .elementAt(index)
                                                .item_desc ??
                                            "",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 10,
                                        style: const TextStyle(fontSize: 16),
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Quantity                        :    ",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                    viewTabDto.getDtlLisrt
                                            .elementAt(index)
                                            .doc_qty ??
                                        "",
                                    style: const TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10)),
                                  color: Colors.red.shade800),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Rate",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                  Text(
                                    viewTabDto.getDtlLisrt
                                            .elementAt(index)
                                            .price ??
                                        "",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: openDialog,
              child: Container(
                width: 400,
                height: 60,
                decoration: BoxDecoration(
                    color: const Color(0xffB09EFF),
                    borderRadius: BorderRadius.circular(30)),
                child: const Center(
                    child: Text(
                  "APPROVE / REVERT",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ),
          )
        ],
      )),
    );
  }
}
