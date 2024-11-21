import 'package:ecommapp/screens/detailscreen.dart';
import 'package:ecommapp/screens/homescreen.dart';
import 'package:ecommapp/screens/registerscreen.dart';
import 'package:flutter/material.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DetailPage(),
    );
  }
}
