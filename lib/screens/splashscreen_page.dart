import 'package:flutter/material.dart';

class SplashScreenPage extends StatelessWidget {
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
                // width:
                //     isLandscape ? screenWidth * 0.6 : screenWidth * 0.7,
                // height:
                //     isLandscape ? screenHeight * 0.6 : screenHeight * 0.5,
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
