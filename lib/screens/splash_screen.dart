import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:home_hub/const/firebase_const.dart';
import 'package:home_hub/screens/dashboard_screen.dart';
import 'package:home_hub/screens/sign_in_screen.dart';
import 'package:home_hub/utils/images.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  //change screen
  changeScreen(){
    Future.delayed(Duration(seconds: 2), () {
      //Get.to(() => SignInScreen());
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.offAll(() => SignInScreen());
        } else {
          Get.offAll(() => DashBoardScreen());
        }
      });
    });
  }

  /*changeScreen() {
    Future.delayed(Duration(seconds: 2), () {
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.offAll(() => SignInScreen());
        } else {
          if (user != null && user.emailVerified) {
            Get.offAll(() => DashBoardScreen());
          } else {
            // If the user is logged in but the email is not verified,
            // show a message and sign them out.
            Fluttertoast.showToast(
              msg: "Please verify your email before logging in.",
              // ... Toast properties ...
            );
            // auth.signOut();
            Get.offAll(() => SignInScreen());
          }
        }
      });
    });
  }*/

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  /*void init() async {
    Timer(
      Duration(seconds: 2),
      () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => WalkThroughScreen()),
          (route) => false,
        );
        auth.authStateChanges().listen((User? user) {
          if (user == null && mounted) {
            Get.to(() => SignInScreen());
          } else {
            Get.to(() => DashBoardScreen());
          }
        });
      },
    );
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(splash_logo, width: 100, height: 100, fit: BoxFit.cover),
      ),
    );
  }
}
