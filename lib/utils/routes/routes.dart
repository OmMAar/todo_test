import 'package:morphosis_flutter_demo/ui/home/page/home.dart';
import 'package:morphosis_flutter_demo/ui/screens/index.dart';
import 'package:morphosis_flutter_demo/ui/screens/task.dart';
import 'package:morphosis_flutter_demo/ui/splash/splash.dart';
import 'package:flutter/material.dart';

class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  // static const String login = '/login';

  static const String home = '/home';
  static const String index = '/index';
  static const String task = '/task';
  static const String tasks = '/tasks';


  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    // login: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => HomePage(),

    index: (BuildContext context) => IndexPage(),
    task: (BuildContext context) => TaskPage(),

  };
}



