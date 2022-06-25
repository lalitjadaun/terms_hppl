import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:terms_hppl/ui/drawer/drawer.dart';
import 'package:terms_hppl/ui/graphs/graphs.dart';
import 'package:terms_hppl/ui/homePage/home_page.dart';
import 'package:terms_hppl/ui/homePage/navigation_bar/mynavigation.dart';
import 'package:terms_hppl/ui/loginPage/loginPage.dart';
import 'package:terms_hppl/ui/notification/notification.dart';
import 'package:terms_hppl/ui/profileui/profileui.dart';
import 'package:terms_hppl/ui/purchase%20order/parchase_order.dart';
import 'package:terms_hppl/ui/reports/reports.dart';
import 'package:terms_hppl/ui/routes/my_routes.dart';
import 'package:terms_hppl/ui/viewtabui/viewtabui.dart';
import 'package:terms_hppl/utils/pref.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesManager.init();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      builder: EasyLoading.init(),
      title: 'Flutter Demo',
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          appBarTheme: AppBarTheme(
              elevation: 8.0,
              color: Colors.red.shade800,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light,
                  statusBarBrightness: Brightness.light,
                  systemNavigationBarIconBrightness: Brightness.light))),
      home: const LoginPage(),
      initialRoute: MyRoutes.LoginPage,
      routes: {
        '/LoginPage': (context) => LoginPage(),
        '/HomePage': (context) => HomePage(),
        '/PurchaseOrder': (context) => PurchaseOrder(),
        '/ViewTabUI': (context) => ViewTabUI(),
        '/Drawerui': (context) => Drawerui(),
        '/Reportsui': (context) => Reportsui(),
        '/Notificationui': (context) => Notificationui(),
        '/BarGraphsui': (context) => BarGraphsui(),
        '/MyNavigation': (context) => MyNavigation(),
        '/ProfileUi': (context) => ProfileUi(),
      },
    );
  }
}
