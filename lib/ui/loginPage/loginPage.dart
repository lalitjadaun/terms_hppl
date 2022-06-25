import 'dart:io';
import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:terms_hppl/ui/loginPage/termsanimation.dart';
import 'package:terms_hppl/ui/loginPage/unitlist/unit_list.dart';
import 'package:terms_hppl/ui/loginPage/unitlist/unitlist_dto/unitlist_dto.dart';
import 'package:terms_hppl/ui/loginPage/userdetail/userdetail.dart';
import '../../Api/http_service.dart';
import '../../utils/Helper.dart';
import '../routes/my_routes.dart';
import 'companyname/company_name.dart';
import 'logincall/login_call.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final boolState = StateProvider<bool>((ref) {
    return false;
  });

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

  List<UnitList> unitlistfinal = [];

  bool isLoading = false;
  late HttpService httpService;
  CompanyName? companyName;
  UserDetails? userDetails;
  late LoginCall loginCall;

  UnitList? unitList;
  UnitListDto? unitListDto;

  TextEditingController userCode = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController unitController = TextEditingController();

  //Company Name
  Future getCompanyName() async {
    EasyLoading.show();
    Response response;
    try {
      response = await httpService.getCompanyName();
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        companyName = CompanyName.fromJson(response.data);
        print(companyName?.image_compnay);
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
          .showSnackBar(const SnackBar(content: Text("User UnAuthorized")));
    }
  }

  //UserDetails
  Future getUserDetails(String userName) async {
    EasyLoading.show();
    Response response;
    try {
      response = await httpService.getUserDetail(userName);
      EasyLoading.dismiss();
      if (response.statusCode == 200) {
        userDetails = UserDetails.fromJson(response.data);
        if (userDetails?.status == true) {
          Helper.setuserId(userDetails?.model?.userId ?? "");

          getUnitList(userDetails?.model?.userId ?? "");
        } else {
          setState(() {
            unitlistfinal = [];
          });
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(userDetails?.msg ?? "User Not Found")));
        }
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
          .showSnackBar(const SnackBar(content: Text("User UnAuthorized")));
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
        unitListDto = UnitListDto.fromJson(response.data);
        setState(() {
          unitlistfinal = unitListDto!.getUniList;
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
          .showSnackBar(const SnackBar(content: Text("User UnAuthorized")));
    }
  }

  //LoginCall
  Future getLoginCall(
      String unit_cd, String userId, String userName, String userPass) async {
    EasyLoading.show();
    Response response;
    try {
      response =
          await httpService.getLoginCall(unit_cd, userId, userName, userPass);
      EasyLoading.dismiss();
      print(response);
      if (response.statusCode == 200) {
        userDetails = UserDetails.fromJson(response.data);
        if (userDetails?.status == true) {
          Helper.setunit_cd(unit_cd);
          Helper.setemp_cd(userDetails?.model?.emp_Id ?? "");
          Navigator.pushNamed(context, MyRoutes.MyNavigation);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(userDetails?.msg ?? "")));
        }
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
          .showSnackBar(const SnackBar(content: Text("User UnAuthorized")));
    }
  }

  @override
  void initState() {
    httpService = HttpService();
    super.initState();
    getCompanyName();
    EasyLoading();
  }

  var selectedValue;

  late String unit_cd = "";
  late String Name = "";

  @override
  Widget build(BuildContext context) {
    final index = unitListDto?.getUniList.length;

    return Scaffold(
        backgroundColor: Colors.white,
        //Bottom Navigation Bar
        bottomNavigationBar: const BottomAppBar(
          elevation: 0.0,
          color: Colors.transparent,
          child: Text(
            "© Mawai infotech LTd. All Rights Reserved",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              _buildTerms(),
              _buildMawaiLogo(""),
              _buildMawaiText(),
              _buildTedxtField()
            ],
          ),
        )));
  }

  _buildTerms() {
    return const TermsAnimation();
  }

  _buildMawaiLogo(String url) {
    return Image.network(
      companyName?.image_compnay ?? "",
      errorBuilder: (BuildContext context, object, StackTrace) {
        return Image.asset(
          'assets/mawailogo.png',
          filterQuality: FilterQuality.high,
          colorBlendMode: BlendMode.difference,
          scale: 5,
        );
      },
      filterQuality: FilterQuality.high,
      colorBlendMode: BlendMode.difference,
      scale: 4,
    );
  }

  _buildMawaiText() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        companyName?.comp_name ?? "",
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  _buildTedxtField() {
    return Column(
      children: [
        //User Code
        OpacityAnimatedWidget.tween(
          opacityDisabled: 0,
          opacityEnabled: 1,
          duration: const Duration(milliseconds: 1500),
          child: SizedBox(
              child: Container(
            padding: const EdgeInsets.only(left: 40, right: 40, bottom: 10),
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(50.0),
              child: TextFormField(
                controller: userCode,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
                autofocus: false,
                cursorColor: Colors.redAccent.shade700,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: "User Code",
                    contentPadding: const EdgeInsets.all(10),
                    filled: true,
                    suffixIcon: const Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(50.0)),
                    // labelText: "Admin",
                    labelStyle:
                        const TextStyle(color: Colors.purple, fontSize: 20.0)),
              ),
            ),
          )),
        ),

        // OpacityAnimatedWidget.tween(
        //   opacityDisabled: 0,
        //   opacityEnabled: 1,
        //   duration: const Duration(milliseconds: 1500),
        //   child: SizedBox(
        //       child: Container(
        //     padding: const EdgeInsets.only(left: 40, right: 40, bottom: 10),
        //     child: Material(
        //       elevation: 10,
        //       borderRadius: BorderRadius.circular(50.0),
        //       child: GestureDetector(
        //         onTap: () {
        //           if (userCode.text.isNotEmpty) {
        //             getUserDetails(userCode.text.trim());
        //             _showUnitDialogue();
        //             selectedValue;
        //           } else {
        //             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //                 content: Text("Please Enter User Name")));
        //           }
        //         },
        //         child: TextFormField(
        //           onTap: () {
        //             if (userCode.text.isNotEmpty) {
        //               getUserDetails(userCode.text.trim());
        //               _showUnitDialogue();
        //               selectedValue;
        //               print(selectedValue);
        //             } else {
        //               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //                   content: Text("Please Enter User Name")));
        //             }
        //           },
        //           style: const TextStyle(
        //               color: Colors.black,
        //               fontSize: 15,
        //               fontWeight: FontWeight.w500),
        //           autofocus: false,
        //           readOnly: true,
        //           cursorColor: Colors.redAccent.shade700,
        //           decoration: InputDecoration(
        //               fillColor: Colors.white,
        //               hintText: unitListDto?.getUniList[0].unitcode,
        //               contentPadding: const EdgeInsets.all(10),
        //               filled: true,
        //               suffixIcon: const Icon(
        //                 Icons.lock,
        //                 color: Colors.black,
        //               ),
        //               focusedBorder: OutlineInputBorder(
        //                 borderSide: BorderSide(color: Colors.grey.shade400),
        //                 borderRadius: BorderRadius.circular(50.0),
        //               ),
        //               enabledBorder: OutlineInputBorder(
        //                   borderSide: BorderSide(color: Colors.grey.shade400),
        //                   borderRadius: BorderRadius.circular(50.0)),
        //               // labelText: "Admin",
        //               labelStyle:
        //                   const TextStyle(color: Colors.black, fontSize: 20.0)),
        //           onChanged: (value) {
        //             setState(() {
        //               selectedValue = value;
        //               int? position =
        //                   unitListDto?.getUniList.indexOf(selectedValue);
        //               unit_cd = unitListDto?.getUniList
        //                       .elementAt(position!)
        //                       .unitcode ??
        //                   "";
        //               Name =
        //                   unitListDto?.getUniList.elementAt(position!).name ??
        //                       "";
        //               // print(pincodeModelDto?.pincode_list);
        //             });
        //           },
        //         ),
        //       ),
        //     ),
        //   )),
        // ),

        //Unit list DropDown
        OpacityAnimatedWidget.tween(
          child: SizedBox(
            child: Container(
              height: 58,
              padding: const EdgeInsets.only(left: 40, right: 40, bottom: 10),
              child: GestureDetector(
                  onTap: () {
                    if (userCode.text.isNotEmpty) {
                      getUserDetails(userCode.text.trim());
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Please Enter User Name")));
                    }
                  },
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(60),
                    child: DropdownButtonFormField(
                        alignment: Alignment.center,
                        elevation: 10,
                        onTap: () {},
                        value: selectedValue,
                        validator: (selectedValue) => selectedValue == null
                            ? 'Please select your unit code'
                            : null,
                        decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.all(10),
                            border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade400),
                                borderRadius: BorderRadius.circular(30.0)),
                            labelStyle: const TextStyle(
                                color: Colors.purple, fontSize: 20.0)),
                        hint: const Text(
                          "Unit ",
                          style: TextStyle(color: Colors.grey),
                        ),
                        isExpanded: true,
                        items: unitListDto?.getUniList
                            .map((value) => DropdownMenuItem(
                                  value: value,
                                  child: Text(value.name.toString()),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value;
                            int? position =
                                unitListDto?.getUniList.indexOf(selectedValue);
                            unit_cd = unitListDto?.getUniList
                                    .elementAt(position!)
                                    .unitcode ??
                                "";
                            Name = unitListDto?.getUniList
                                    .elementAt(position!)
                                    .name ??
                                "";
                            // print(pincodeModelDto?.pincode_list);
                          });
                        }),
                  )),
            ),
          ),
        ),

        OpacityAnimatedWidget.tween(
          opacityDisabled: 0,
          opacityEnabled: 1,
          duration: const Duration(milliseconds: 1500),
          child: SizedBox(
              child: Container(
            height: 98,
            padding: const EdgeInsets.only(left: 40, right: 40, bottom: 50),
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(50),
              child: TextFormField(
                controller: password,
                //onTap: getUserDetails,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
                autofocus: false,
                obscureText: true,
                cursorColor: Colors.redAccent.shade700,
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintText: "Password",
                    contentPadding: const EdgeInsets.all(10),
                    filled: true,
                    suffixIcon: const Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(50.0)),
                    // labelText: "Admin",
                    labelStyle:
                        const TextStyle(color: Colors.black, fontSize: 20.0)),
              ),
            ),
          )),
        ),

        //SignIn  button
        OpacityAnimatedWidget.tween(
          opacityDisabled: 0,
          opacityEnabled: 1,
          duration: const Duration(milliseconds: 1500),
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.4,
            height: MediaQuery.of(context).size.height / 12,
            //padding: EdgeInsets.all(60),
            child: ElevatedButton(
              onPressed: () {
                Helper.setuserName(userCode.text.trim());
                Helper.setunitName(Name);
                getLoginCall(unit_cd, Helper.getuserId(), userCode.text.trim(),
                    password.text.toString().toUpperCase());
                // if(userDetails?.model?.userPass== password.text.toString().trim()){

                //Navigator.pushNamed(context, MyRoutes.MyNavigation);
                //}
                // else{ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please Check Your Credentials")));}
              },
              child: const Text(
                "Sign In",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Colors.red.shade800,
                  elevation: 15.0,
                  //side: BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))),
            ),
          ),
        ),
      ],
    );
  }

  Future<bool> _showUnitDialogue() async {
    final index = unitListDto?.getUniList.length;
    return await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: SizedBox(
                  width: 100,
                  height: 100,
                  child: ListView.builder(
                      itemCount: index,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pop(context, true);

                          },
                          child: Card(
                            elevation: 10,
                            child: Text(
                              unitListDto?.getUniList
                                      .elementAt(index)
                                      .unitcode ??
                                  "",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              );
            }) ??
        false;
  }
}
