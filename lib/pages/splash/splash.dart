import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:taskizer/styles/global.dart';

class FutureSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('assets/icon/logo.png'),
      title: Text(
        "تمرکز یار",
        style: titleStyle.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontFamily: 'Bach'),
      ),
      backgroundColor: Colors.teal.shade400,
      loaderColor: Colors.white,
      // showLoader: true,
      loadingText: Text("درحال بارگذاری",
          style:
              normTextStyle.copyWith(color: Colors.white, fontFamily: 'Bach')),
    );
  }
}
