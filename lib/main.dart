import 'package:ecommapp/data/remote/apihelper.dart';
import 'package:ecommapp/screens/register/bloc/register_user_bloc.dart';
import 'package:ecommapp/screens/splashscreen_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  return runApp(BlocProvider(
      create: (context) => RegisterUserBloc(apiHelper: ApiHelper()),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreenPage(),
    );
  }
}
