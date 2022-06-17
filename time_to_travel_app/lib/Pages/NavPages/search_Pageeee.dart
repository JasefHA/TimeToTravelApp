import 'package:flutter/material.dart';
import 'package:time_to_travel_app/widgets/card_swiper.dart';
import 'package:time_to_travel_app/widgets/slider.dart';

class SearchPageee extends StatelessWidget {
  const SearchPageee({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PAQUETES TURISTICOS'),
        elevation: 10,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.search_outlined))
        ],

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(),
            SliderIm()
          ],
        )
      ),
    );
  }
}