import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:morphosis_flutter_demo/constants/assets.dart';
import 'package:morphosis_flutter_demo/constants/colors.dart';
import 'package:morphosis_flutter_demo/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        brightness: Brightness.dark,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Image.asset(
                  //   Assets.appLogo,
                  //   width: 150,
                  // ),
                  Lottie.asset(Assets.splash_icon),
                  SizedBox(
                    height: 48,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: SpinKitThreeBounce(
                color: Colors.white,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  startTimer() {
    var _duration = Duration(milliseconds: 2000);
    return Timer(_duration, navigate);
  }

  navigate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Navigator.of(context).pushReplacementNamed(Routes.home);
    // if (preferences.getBool(Preferences.is_logged_in) ?? false) {
    //
    // } else {
    //   Navigator.of(context).pushReplacementNamed(Routes.login);
    // }
  }
}
