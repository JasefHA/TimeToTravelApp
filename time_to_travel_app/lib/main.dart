import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_to_travel_app/Pages/NavPages/main_Page.dart';
import 'package:time_to_travel_app/Pages/NavPages/my_Page.dart';
import 'package:time_to_travel_app/Pages/NavPages/register_page.dart';
import 'package:time_to_travel_app/Pages/detail_page.dart';
import 'package:time_to_travel_app/Pages/welcome_page.dart';
import 'package:time_to_travel_app/cubit/app_cubic_logics.dart';
import 'package:time_to_travel_app/cubit/app_cubits.dart';
import 'package:time_to_travel_app/services/data_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/register':(context) => RegisterPage(),
        '/login':(context) => MyPage(),
        '/home':(context) => MainPage()
      },
      //home: WelcomePage()
      home: BlocProvider<AppCubits>(
        create:(context)=>AppCubits(
          data: DataServices(),
        ),
        child: AppCubitsLogics(),
      )
    );
  }
}