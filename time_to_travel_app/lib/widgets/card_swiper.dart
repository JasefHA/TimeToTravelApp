import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class CardSwiper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
          itemCount: 10,
          layout: SwiperLayout.STACK,
          itemWidth: size.width * 0.6,
          itemHeight: size.height * 0.45,
          itemBuilder: (_, int index) {
            return Image.network(
              "https://via.placeholder.com/288x188",
              //fit: BoxFit.fill,

            );
            // return GestureDetector(
            //   onTap: () => Navigator.pushNamed(context, 'details', arguments: 'movie-instace'),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(30),
            //     child: FadeInImage(
            //         placeholder: AssetImage('assets/no-image.jpg'),
            //         image: NetworkImage('https://via.placeholder.com/300x400'),
            //         fit: BoxFit.cover,
            //     ),
            //   ),
            // );
          }),
    );
  }
}
