import 'package:flutter/material.dart';
import 'package:time_to_travel_app/Colors/colors.dart';
import 'package:time_to_travel_app/Pages/home_Page.dart';
import 'package:time_to_travel_app/Pages/NavPages/my_Page.dart';
import 'package:time_to_travel_app/Pages/NavPages/search_Page.dart';
import 'package:time_to_travel_app/Pages/NavPages/search_Pageeee.dart';

import 'barItem_Page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final String textbar1 = "Home";
  final String textbar2 = "Bar";
  final String textbar3 = "Search";
  final String textbar4 = "My";

  List pages = [HomePage(), BarItemPage(), SearchPage(), MyPage()];

  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 0,
        selectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(31, 230, 230, 230),
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: AppColors.secundaryColor,
        unselectedItemColor: Colors.black38,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
              label: textbar1, icon: Icon(Icons.home_outlined, size: 35)),
          BottomNavigationBarItem(
              label: textbar2, icon: Icon(Icons.map_outlined, size: 35)),
          BottomNavigationBarItem(label: textbar3, icon: Icon(Icons.search, size: 35,)),
          BottomNavigationBarItem(label: textbar4, icon: Icon(Icons.person, size: 35)),
        ],
      ),
    );
  }
}
