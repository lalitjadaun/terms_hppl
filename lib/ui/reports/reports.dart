import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:flutter/material.dart';

import '../routes/my_routes.dart';

class Reportsui extends StatefulWidget {
  const Reportsui({Key? key}) : super(key: key);

  @override
  _ReportsuiState createState() => _ReportsuiState();
}

class _ReportsuiState extends State<Reportsui> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.grey.shade200,

      // bottomNavigationBar: BottomNavigation(),
      body: SafeArea(
        child: InkWell(
          onTap: (){
            Navigator.pushNamed(context, MyRoutes.BarGraphsui);
            //Navigator.pushNamed(context, MyRoutes.BarChartSample1);
            //stockGraphDto.getstockgraphView[index].closeStock
          },
          child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: 10,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 10,
                    crossAxisCount: 3, ),
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 10.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: SizedBox(
                              child: Image.asset("assets/images/aging.png",scale: 3,alignment: Alignment.topCenter,fit: BoxFit.cover,filterQuality: FilterQuality.high,),
                            ),
                          ),
                          const SizedBox(
                            child: Text("Reports",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              maxLines: 2,
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,fontSize: 16,
                                  letterSpacing: 1
                              ),),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
