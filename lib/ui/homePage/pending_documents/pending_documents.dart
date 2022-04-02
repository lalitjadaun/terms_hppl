import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:terms_hppl/ui/homePage/pending_documents/pendingdocuments_model/pendingdocuments_dto/pendingdocuments_dto.dart';
import 'package:terms_hppl/ui/homePage/pending_documents/pendingdocuments_model/pendingdocuments_model.dart';
import '../../../Api/http_service.dart';
import '../../../utils/Helper.dart';
import '../../routes/my_routes.dart';

class PendingDocuments extends StatefulWidget {
  const PendingDocuments({Key? key}) : super(key: key);

  @override
  _PendingDocumentsState createState() => _PendingDocumentsState();
}

class _PendingDocumentsState extends State<PendingDocuments>
    with WidgetsBindingObserver {
  final boolState = StateProvider<bool>((ref) {
    return false;
  });

  bool isLoading = false;
  late HttpService httpService;
  late PendingListDto pendingListDto;
  late PendingListModel pendingListModel;

  late int itemCount = 0;

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

  Future getCategoryList(String emp_cd, String unitcode) async {
    EasyLoading.show();
    Response response;
    try {
      response = await httpService.getCategoryList(emp_cd, unitcode);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        Helper.getunit_cd();
        Helper.getemp_cd();
        pendingListDto = PendingListDto.fromJson(response.data);
        setState(() {
          itemCount = pendingListDto.getAllCategory.length;
          EasyLoading.dismiss();
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
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Category List Call Failed")));
    }
  }

  @override
  void initState() {
    httpService = HttpService();
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    getCategoryList(Helper.getemp_cd(), Helper.getunit_cd());
    EasyLoading();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: MediaQuery.of(context).size.width,
      child: GridView.builder(
        itemCount: itemCount,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 20,
          crossAxisSpacing: 10,
          crossAxisCount: 3,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Helper.setamd_no(
                  pendingListDto.getAllCategory.elementAt(index).amd_no!);
              Helper.setdoc_type(
                  pendingListDto.getAllCategory.elementAt(index).doc_type ??
                      "");
              Helper.setemp_cd(
                  pendingListDto.getAllCategory.elementAt(index).emp_cd ?? "");
              Helper.setunit_cd(
                  pendingListDto.getAllCategory.elementAt(index).unit_cd ?? "");
              Helper.setdoc_name(
                  pendingListDto.getAllCategory.elementAt(index).doc_name ??
                      "");
              Navigator.pushNamed(
                context,
                MyRoutes.PurchaseOrder,
              );
            },
            child: Card(
              elevation: 10.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: SizedBox(
                      child: Image.network(
                        pendingListDto.getAllCategory.elementAt(index).imgUrl ??
                            "",
                        errorBuilder:
                            (BuildContext context, object, StackTrace) {
                          return Image.asset(
                            'assets/images/approval.png',
                            filterQuality: FilterQuality.high,
                            colorBlendMode: BlendMode.difference,
                            scale: 18,
                          );
                        },
                        scale: 13,
                        alignment: Alignment.topCenter,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      pendingListDto.getAllCategory.elementAt(index).doc_name ??
                          "",
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 2,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          letterSpacing: 1),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      pendingListDto.getAllCategory.elementAt(index).poNumber ??
                          "",
                      style: const TextStyle(
                          fontSize: 13,
                          color: Colors.red,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
