import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import '../../Api/http_service.dart';
import '../../utils/Helper.dart';
import '../homePage/pending_documents/pendingdocuments_model/pendingdocuments_dto/pendingdocuments_dto.dart';
import '../homePage/pending_documents/pendingdocuments_model/pendingdocuments_model.dart';
import '../loginPage/unitlist/unit_list.dart';
import '../loginPage/unitlist/unitlist_dto/unitlist_dto.dart';
import '../routes/my_routes.dart';
import '../viewtabui/approvemodel/approve_model.dart';

class PurchaseOrder extends StatefulWidget {
  const PurchaseOrder({Key? key}) : super(key: key);

  @override
  _PurchaseOrderState createState() => _PurchaseOrderState();
}

class _PurchaseOrderState extends State<PurchaseOrder> {

  final boolState = StateProvider<bool>((ref) {
    return false;
  });

  bool isLoading = false;
  late HttpService httpService;
  late PendingListDto pendingListDto= new PendingListDto();
  late PendingListModel pendingListModel;
  late ApprovalModel approvalModel;

  UnitList? unitList;
  UnitListDto? unitListDto;
  List<UnitList>unitlistfinal= [];

  var selectedValue;

  late String unit_cd= "";

  List<PendingListModel> items= [];

  TextEditingController remarks= TextEditingController();

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

  Future getCategoryListDetails(int amd_no,String doc_type, String emp_cd, String unit_cd ) async{
    EasyLoading.show();
    Response response;
    try {
      response = await httpService.getCategoryListDetails(amd_no, doc_type, emp_cd, unit_cd);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        pendingListDto = PendingListDto.fromJson(response.data);
        EasyLoading.dismiss();
        if (pendingListDto.getAllCategory.isNotEmpty) {
          setState(() {
            items.clear();
            items.addAll(pendingListDto.getAllCategory);
            //itemCount = pendingListDto.getAllCategory.length;
          });
          print(response);
        } else {
          return Future.error(
            "Error while fetching.",
            StackTrace.fromString("${response.statusCode}"),
          );
        }
      }
    }
      on SocketException {
        return Future.error('No Internet connection 😑');
      }
      on FormatException {
        return Future.error('Bad response format 👎');
      }
      on Exception catch (e) {
        EasyLoading.dismiss();
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("GET CATEGORY LIST CALL FAILED")));
    }
  }

  //Approve and revert
  Future getApproveandRevert(int amdNO, String appDt, String appStage,
      String area, String comp_code, String doc_type, String poNo, String remark, String unit_code
      ) async {
    EasyLoading.show();
    Response response;
    try {
      response = await httpService.getApproveandRevert(amdNO, appDt, appStage,
          area, comp_code, doc_type, poNo, remark, unit_code);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        approvalModel = ApprovalModel.fromJson(response.data);
        print(response);
        getCategoryListDetails( Helper.getamd_no(), Helper.getdoc_type(),
            Helper.getemp_cd(), Helper.getunit_cd());
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
          .showSnackBar(const SnackBar(content: Text("APPROVE/ REVERT CALL FAILED")));
    }
  }

  //SearchList

  void filterSearchResults(String query){
    List<PendingListModel> dummySearchList = <PendingListModel>[];
    dummySearchList.addAll(pendingListDto.getAllCategory);
    if(query.isNotEmpty){
      List<PendingListModel> dummyListData= <PendingListModel>[];
      dummySearchList.forEach((items) {
        if(items.po_no.toString().toLowerCase().contains(query.toLowerCase()) ||
            items.name.toString().toLowerCase().contains(query.toLowerCase())
        ){
          //ummySearchList.add(item);
          dummyListData.add(items);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      }
      );
      return;
    }else{
      setState(() {
        items.clear();
        items.addAll(pendingListDto.getAllCategory);
      });
    }
  }


  //Unit List
  Future getUnitList(String userId) async {
    EasyLoading.show();
    Response response;
    try {
      response = await httpService.getUnitList(userId);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        unitListDto= UnitListDto.fromJson(response.data);
        setState(() {
          unitlistfinal= unitListDto!.getUniList ;
        });
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
          .showSnackBar(const SnackBar(content: Text("UNIT LIST CALL FAILED")));
    }
  }

  @override
  void initState() {
    httpService = HttpService();
    getUnitList(Helper.getuserName());
   getCategoryListDetails( Helper.getamd_no(), Helper.getdoc_type(),
       Helper.getemp_cd(), Helper.getunit_cd());
    EasyLoading();
    super.initState();
  }

  final String formatted = DateFormat('dd-MMM-yy').format(DateTime.now());

  Future openDialog() => showDialog(

      context: context,
      builder: (context) => Dialog(
          elevation: 8.0,
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: SingleChildScrollView(
            child: Stack(
              clipBehavior: Clip.none, alignment: Alignment.topCenter,
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
                          borderRadius: BorderRadius.circular(8)
                        ),
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child:TextField(
                          maxLines: null,
                          controller: remarks,
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration.collapsed(
                            hintText: "  Enter Your Remark Here",
                          ),
                        )
                      ),
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
                              Navigator.popUntil(context, (Route<dynamic>route){
                                bool shouldPop= false;
                                if(route.settings.name== MyRoutes.PurchaseOrder){
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
                              Navigator.popUntil(context, (Route<dynamic>route){
                                bool shouldPop= false;
                                if(route.settings.name== MyRoutes.PurchaseOrder){
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
  Widget build(BuildContext context) {
    final String formatted = DateFormat('dd-MMM-yy').format(DateTime.now());
    print(formatted);
    return Scaffold(
        appBar: AppBar(
          title:
              Image.asset(
                "assets/terms_white_logo.png",
                scale: 8,
              ),
          automaticallyImplyLeading: false,
          leading:  IconButton(
              onPressed: (){Navigator.pushNamed(context, MyRoutes.MyNavigation);},
              icon: Icon(Icons.arrow_back_ios)),
        ),
        body: WillPopScope(
          onWillPop:()async{
            Navigator.pushNamed(context, MyRoutes.MyNavigation);
            return true;
            },
          child: SafeArea(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(Helper.getdoc_name(),
                    style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),)),
              SizedBox(
                child: Container(
                    height: 70,
                    padding: const EdgeInsets.all(8),
                   // padding: const EdgeInsets.only(left: 40, right: 40, bottom: 10),
                    child:DropdownButtonFormField(
                        alignment: Alignment.center,
                        elevation: 8,
                        onTap: (){},
                        validator:(selectedValue) => selectedValue== null? 'Please select your UNITCODE': null,
                        value: selectedValue,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            focusColor: Colors.black,
                            filled: true,
                            contentPadding:  const EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.black,style: BorderStyle.solid,width: 2),
                                borderRadius: BorderRadius.circular(10.0)),
                            labelStyle: const TextStyle(color: Colors.purple, fontSize: 20.0)
                        ),
                        hint: Text(Helper.getunitName(),style: TextStyle(color: Colors.grey),),
                        isExpanded: true,
                        items: unitlistfinal.map((value) => DropdownMenuItem(
                          value: value,
                          child: Text(value.name.toString()),
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                            int? position = unitListDto?.getUniList
                                .indexOf(selectedValue);
                            unit_cd = unitListDto?.getUniList
                                .elementAt(position!)
                                .unitcode ??
                                "";
                            Helper.setunit_cd(unit_cd);//getUnitList(Helper.getuserName());
                          });
                          getCategoryListDetails( Helper.getamd_no(), Helper.getdoc_type(),
                              Helper.getemp_cd(), Helper.getunit_cd());
                        }
                    )
                ),
              ),
              Container(
                height: 70,
                color: Colors.white,
                padding: const EdgeInsets.all(8),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search..",
                      enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.black,style: BorderStyle.solid,width: 2),
                          borderRadius: BorderRadius.circular(10.0)),
                    focusedBorder:  OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  onChanged: (value){
                    filterSearchResults(value);
                    print('value:' + value);
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount:items.length ,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            // mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.yellow,
                                        minimumSize: const Size(80, 45),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                                      ),
                                      child: Row(
                                        children: [
                                          const Text(
                                            "View  ",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                          Image.asset("assets/images/right-arrow-2.png",scale: 20,)
                                        ],
                                      ),
                                      onPressed: () {
                                        Helper.setamd_no(pendingListDto.getAllCategory.elementAt(index).amd_no!);
                                        Helper.setdoc_number(pendingListDto.getAllCategory.elementAt(index).po_no ??"");
                                        Helper.setdoc_name(pendingListDto.getAllCategory.elementAt(index).doc_name ??"");
                                        Helper.setappDt(pendingListDto.getAllCategory.elementAt(index).po_dt ??"");
                                        Helper.setappStage(pendingListDto.getAllCategory.elementAt(index).po_status ??"");
                                        Navigator.pushNamed(context, MyRoutes.ViewTabUI);
                                      },
                                    ),
                                  ),

                                  Padding(padding: const EdgeInsets.all(8),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: const Color(0xffB09EFF),
                                        minimumSize: const Size(80, 45),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
                                    ),
                                    child: const Text(
                                      "Approve/ Revert",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                    onPressed: () {
                                      Helper.setamd_no(pendingListDto.getAllCategory.elementAt(index).amd_no!);
                                      Helper.setdoc_number(pendingListDto.getAllCategory.elementAt(index).po_no ??"");
                                      Helper.setdoc_name(pendingListDto.getAllCategory.elementAt(index).doc_name ??"");
                                      Helper.setappDt(pendingListDto.getAllCategory.elementAt(index).po_dt ??"");
                                      Helper.setappStage(pendingListDto.getAllCategory.elementAt(index).po_status ??"");
                                     openDialog();
                                    },
                                  ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                height: 1.0,
                                color: Colors.black,
                              ),
                              Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, top: 8, bottom: 0),
                                    child: Text(
                                      "Date                         :      ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, top: 8, bottom: 0),
                                    child: Text(
                                      items.elementAt(index).po_dt ??"",
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, top: 8, bottom: 0),
                                    child: Text(
                                      "DOC Name              :       ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, top: 8, bottom: 0),
                                    child: Text(
                                      items.elementAt(index).doc_name ??"",
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, top: 8, bottom: 0),
                                    child: Text(
                                      "Number                  :       ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, top: 8, bottom: 0),
                                    child: Text(
                                      items.elementAt(index).po_no ??"",
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        left: 20, top: 8, bottom: 0),
                                    child: Text(
                                      "Stage                       :       ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 10, top: 8, bottom: 0),
                                    child: Text(
                                      items.elementAt(index).po_status ??"",
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Container(

                                    padding: const EdgeInsets.only(
                                        left: 20, top: 8, bottom: 0),
                                    child: const Text(
                                      "Supplier Name     :       ",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 4,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Container(
                                    width: 140,
                                    padding: const EdgeInsets.only(
                                        right: 10, top: 8, bottom: 30),
                                    child:  Text(
                                      items.elementAt(index).name ??"",
                                      maxLines: 12,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                  )
                                ],
                              ),
                              // Row(
                              //   //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //   crossAxisAlignment: CrossAxisAlignment.start,
                              //   children: [
                              //     const Padding(
                              //       padding: EdgeInsets.only(
                              //           left: 20, top: 10, bottom: 10, right: 10),
                              //       child: Text(
                              //         "Remarks                 :",
                              //         style: TextStyle(
                              //             fontSize: 16,
                              //             fontWeight: FontWeight.bold),
                              //       ),
                              //     ),
                              //     Container(
                              //       width: 180,
                              //       padding: const EdgeInsets.only(
                              //           left: 20, top: 10, bottom: 10),
                              //       child: const Text(
                              //         "PO Variable Rate Variation 143129, INR @ 1 = 43129 Rs./- Material:- Hydraulic Vane Pump For Power Pack Yukeen, Maximum  Rate :- 36550 & Qty:- 1",
                              //         maxLines: 10,
                              //         overflow: TextOverflow.ellipsis,
                              //         style: TextStyle(fontSize: 15),
                              //       ),
                              //     )
                              //   ],
                              // ),
                              Container(
                                padding: const EdgeInsets.all(15),
                                decoration:
                                BoxDecoration(
                                    color:    Colors.red.shade800,
                                    borderRadius: const BorderRadius.only(
                                        bottomRight: Radius.circular(15),
                                        bottomLeft: Radius.circular(15))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children:  [
                                    const Text(
                                      "Amount",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      items.elementAt(index).po_value.toString() ,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 18),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          )),
        ));
  }
}

