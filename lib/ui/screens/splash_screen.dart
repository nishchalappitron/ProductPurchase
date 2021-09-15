import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:interview_testing/common/constants/app_utils.dart';
import 'package:interview_testing/common/constants/assets.dart';
import 'package:interview_testing/common/locator/locator.dart';
import 'package:interview_testing/common/router/router.gr.dart';
import 'package:interview_testing/common/service/navigation_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    bool isLoggedIn = await AppUtils().getUserLoggedIn();
    if(isLoggedIn){
      locator<NavigationService>().pushAndRemoveUntil(DashBoardScreenRoute());
    } else{
      locator<NavigationService>().pushAndRemoveUntil(LoginScreenRoute());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Center(
          child: Image.asset(icFirebase, height: 150, width: 150,),
        ),
      ),
    );
  }
}