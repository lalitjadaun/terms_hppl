import 'package:flutter/material.dart';

import '../../utils/Helper.dart';

class ProfileUi extends StatelessWidget {
  const ProfileUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        backgroundColor: Colors.grey.shade100,
        body: Column(
          children: [
            ClipPath(
              clipper: MyCustomClipper(),
              child: Container(
                height: 400,
                color: Colors.red.shade800,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      alignment: Alignment.topCenter,
                      padding: const EdgeInsets.only(top: 40),
                      child: const CircleAvatar(
                        radius: 60,
                        backgroundImage:
                            AssetImage('assets/images/profile.png'),
                      ),
                    ),
                    Text(
                      Helper.getunitName(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    Text(
                      Helper.getuserName(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    Text(
                      Helper.getemp_cd(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    //Text("A-164 A, Sector-62, Noi",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.white),),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height / 2);
    path.cubicTo(size.width / 4, 3 * (size.height / 2), 3 * (size.width / 6),
        size.height / 2, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}
