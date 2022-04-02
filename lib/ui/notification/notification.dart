import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Notificationui extends StatefulWidget {
  const Notificationui({Key? key}) : super(key: key);

  @override
  _NotificationuiState createState() => _NotificationuiState();
}

class _NotificationuiState extends State<Notificationui> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Center(
          child: Image.asset(
            "assets/terms_white_logo.png",
            scale: 8,
          ),
        ),
        automaticallyImplyLeading: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
                itemCount: 2,
                shrinkWrap: true,
                itemBuilder: (context, index){
              return Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child: Image.asset("assets/images/bar-graph.png",scale: 15,),
                        ),
                        Container(
                          //padding: EdgeInsets.only(left: 150),
                          child: Text("Notification",style: TextStyle(
                            fontWeight: FontWeight.bold,fontSize: 18
                          ),),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          child: Image.asset("assets/images/new.png",scale: 10,),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text("Users can swipe down on the status bar to open the notification drawer, where they can view more details and take actions with the notification.",
                     style: TextStyle(
                       fontSize: 15
                     ),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )

                  ],
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
