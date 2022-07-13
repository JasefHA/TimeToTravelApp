import 'package:flutter/material.dart';
import 'package:time_to_travel_app/Pages/NavPages/fullscreenmap.dart';

class BarItemPage extends StatelessWidget {
  const BarItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FullScreenMap(),
    );
  }
}
