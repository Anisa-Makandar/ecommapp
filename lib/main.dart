import 'package:ecommapp/data/remote/apihelper.dart';
import 'package:ecommapp/domain/thememanage.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/cart/bloc/fetch_bloc.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/cart/delete_bloc/delete_bloc.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/createorder/bloc/create_order_bloc.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/detail/bloc/cart_bloc.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/getorder/bloc/get_order_bloc.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/home/product/bloc/product_bloc.dart';
import 'package:ecommapp/screens/dashboard/nav_pages/profile/bloc/profile_bloc.dart';
import 'package:ecommapp/screens/login/bloc/login_user_bloc.dart';
import 'package:ecommapp/screens/register/bloc/register_user_bloc.dart';
import 'package:ecommapp/screens/splashscreen_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  return runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => RegisterUserBloc(apiHelper: ApiHelper())),
    BlocProvider(create: (context) => LoginUserBloc(apiHelper: ApiHelper())),
    BlocProvider(create: (context) => ProductBloc(apiHelper: ApiHelper())),
    BlocProvider(create: (context) => CartBloc(apiHelper: ApiHelper())),
    BlocProvider(create: (context) => FetchCartBloc(apiHelper: ApiHelper())),
    BlocProvider(create: (context) => CreateOrder(apiHelper: ApiHelper())),
    BlocProvider(create: (context) => GetAllOrderBloc(apiHelper: ApiHelper())),
    BlocProvider(create: (context) => UserProfileBloc(apiHelper: ApiHelper())),
    BlocProvider(create: (context) => DeleteBloc(apiHelper: ApiHelper())),
    ChangeNotifierProvider(create: (_) => Theme_manager()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: context.watch<Theme_manager>().getThemevalue()
          ? ThemeMode.dark
          : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: SplashScreenPage(),
    );
  }
}
