import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:slide_drawer/slide_drawer.dart';


import '../../drawer/drawer.dart';
import '../../loginPage/loginPage.dart';
import '../../profileui/profileui.dart';
import '../../reports/reports.dart';
import '../../routes/my_routes.dart';
import '../home_page.dart';

class MyNavigation extends StatefulWidget {
  const MyNavigation({Key? key}) : super(key: key);

  @override
  _MyNavigationState createState() => _MyNavigationState();
}

class _MyNavigationState extends State<MyNavigation> {

  int pageIndex= 0;
  late PageController pageController;

  var Items= [
    Image.asset('assets/images/home.png', scale: 15,),
    Image.asset('assets/images/profile.png',scale: 15,),
    //Image.asset('assets/images/bar-graph.png',scale: 15,)
  ];

  List<Widget> tabPages=[
    HomePage(),
    ProfileUi(),
    //Reportsui(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = PageController(initialPage: pageIndex);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int page){
    setState(() {
      this.pageIndex = page;
    });
  }

  void onTabTapped(int index){
    this.pageController.jumpToPage(index);
    //this.pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.linear);
  }

  final double xOffset= 230;



  @override
  Widget build(BuildContext context) {

    return  WillPopScope(
      onWillPop: ()async{
        return showExitPopup();
      },
      child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          appBar: AppBar(
            title: Center(
              child: Image.asset(
                "assets/terms_white_logo.png",
                scale: 8,
              ),
            ),
            automaticallyImplyLeading: true,
          ),
          drawer: Drawerui(),
          bottomNavigationBar: Container(
            //height: 90,
            color: Colors.red.shade800,
            child:
            CurvedNavigationBar(
              backgroundColor: Colors.transparent,
              items: Items,
              index: pageIndex,
              onTap: onTabTapped,),
          ),
        body:
        PageView(
          children: tabPages,
          onPageChanged: onPageChanged,
          scrollBehavior: const ScrollBehavior(
            androidOverscrollIndicator: AndroidOverscrollIndicator.glow
          ),
          controller: pageController,
        ),
      ),
    );
  }

  Future<bool> showExitPopup()async{
    return await showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Confirm"),
            content: Text("Do you want to exit the App"),
            actions: [
              ElevatedButton(onPressed:(){
               // SystemNavigator.pop();
                //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context)=> LoginPage()), (route) => false);
                Navigator.of(context).pop(false);
              }, child: Text("No")),
              ElevatedButton(
                  onPressed: (){
                    //exit(0);
                   // SystemNavigator.pop();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context)=> LoginPage()), (route) => false);
                    //Navigator.of(context).pop(true);
                  }
                  , child: Text("Yes"))
            ],
          );
        }
    ) ?? false;
  }

}


