import 'package:flutter/material.dart';
import 'package:terms_hppl/ui/homePage/pending_documents/pending_documents.dart';
import '../../utils/Helper.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      //backgroundColor: Colors.grey.shade200,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 10.0,
                margin: const EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:  [
                          Text(
                            Helper.getuserName(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            Helper.getemp_cd(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 10.0, bottom: 10.0),
                      child:  Text(
                       // Helper.getname(),
                        Helper.getunitName(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(5.0),
              child: const Center(
                  child: Text(
                "PENDING DOCUMENT FOR APPROVAL",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    wordSpacing: 1
                ),
              )),
            ),
             Expanded(
              //padding: EdgeInsets.only(top: 20,left: 8,right: 8),
              child: Container(
                padding: const EdgeInsets.all(8),
                  height: 500,
                  child: const PendingDocuments()),
            ),
          ],
        ),
      ),
    );
  }
}

