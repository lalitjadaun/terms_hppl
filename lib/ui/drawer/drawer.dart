import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../loginPage/loginPage.dart';



class Drawerui extends StatefulWidget {
  const Drawerui({Key? key}) : super(key: key);

  @override
  _DraweruiState createState() => _DraweruiState();
}

class _DraweruiState extends State<Drawerui> with SingleTickerProviderStateMixin {

  late AnimationController controller;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    controller =  AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    slideAnimation = Tween<Offset>(begin: Offset(0.0, -4.0), end: Offset.zero)
        .animate(CurvedAnimation(parent: controller, curve: Curves.decelerate));
    controller.addListener(() {
      setState(() {});
    });
    controller.forward();
    super.initState();
    // Add code after super
  }


  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: Drawer(
        elevation: 10,
        child:Column(

          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                    image: AssetImage('assets/images/background.ico')
                )
              ),
              currentAccountPicture: CircleAvatar(
                radius: 40,
                foregroundImage: AssetImage('assets/images/profile.png'),
              ),
                accountName: Text("Mawai InfoTech Ltd.",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                accountEmail: Text("abc",style: TextStyle(fontSize: 15))),

            Expanded(
              child: ListView.builder(
                itemCount: 0,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){},
                    hoverColor: Colors.orange,
                    splashColor: Colors.lightBlue.shade800,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Image.asset(
                              "assets/images/bar-graph.png",
                              scale: 16,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              "Home",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
            ),
            
            SafeArea(
              bottom: true,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.of(context)
                        .pushAndRemoveUntil(
                      CupertinoPageRoute(
                          builder: (context) => LoginPage()
                      ),
                          (_) => false,
                    );
                  },
                  child: const Text("Logout",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold ),),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red.shade800,
                    elevation: 8,
                    fixedSize: const Size(250, 50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(60), bottomLeft: Radius.circular(60))
                    )
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
