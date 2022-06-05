import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_to_travel_app/Pages/NavPages/main_Page.dart';
import 'package:time_to_travel_app/Pages/detail_page.dart';
//import 'package:time_to_travel_app/Pages/home_Page.dart';
import 'package:time_to_travel_app/Pages/welcome_page.dart';
import 'package:time_to_travel_app/cubit/app_cubit_states.dart';
import 'package:time_to_travel_app/cubit/app_cubits.dart';

class AppCubitsLogics extends StatefulWidget {
  AppCubitsLogics({Key? key}) : super(key: key);

  @override
  State<AppCubitsLogics> createState() => _AppCubitsLogicsState();
}

class _AppCubitsLogicsState extends State<AppCubitsLogics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
        if (state is WelcomeState) {
          return WelcomePage();
        }
        if (state is DetailState) {
          return DetailPage();
        }
        if (state is LoadedState) {
          return MainPage();
        }
        if (state is LoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Container();
        }
      }),
    );
  }
}
