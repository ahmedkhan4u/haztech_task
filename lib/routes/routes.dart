import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:haztech_task/views/home_screen.dart';
import 'package:haztech_task/views/login_screen.dart';

class Routes {
  static String _initialRoute = "/";
  static String homeScreen = "/HomeScreen";
  static String signUp = "/signUp";
  static String logIn = "/logIn";

  static String getInitRoute() => _initialRoute;
  static List<GetPage> appRoutes = [
    GetPage(name: _initialRoute, page: () =>
    FirebaseAuth.instance.currentUser == null? LoginScreen() :
    HomeScreen()
    )
  ];
}
