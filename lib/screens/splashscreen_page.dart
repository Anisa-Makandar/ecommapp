import 'dart:async';

import 'package:ecommapp/screens/dashboard/bottomnavigation.dart';
import 'package:ecommapp/screens/login/loginscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    navigateBasedOnToken();
  }

  Future<void> navigateBasedOnToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token");
    Timer(Duration(seconds: 4), () {
      if (token != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (_) => NavifationPage()), // Replace with your HomePage
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 300,
                height: 350,
                child: FittedBox(
                  child: Image.asset(
                    'assets/icons/splashscreenicon.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
