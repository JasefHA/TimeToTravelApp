import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_to_travel_app/Colors/colors.dart';
import 'package:time_to_travel_app/cubit/app_cubit_states.dart';
import 'package:time_to_travel_app/cubit/app_cubits.dart';
import 'package:time_to_travel_app/widgets/app_buttons.dart';
import 'package:time_to_travel_app/widgets/app_text.dart';
import 'package:time_to_travel_app/widgets/app_text_large.dart';
import 'package:time_to_travel_app/widgets/responsive_button.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key? key}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int gottenStars = 4;
  int selectedIndex = -1;
  int voto = 0;
  String ciudad = "Madrid";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      DetailState detail = state as DetailState;
      return Scaffold(
        body: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            child: Stack(
              children: [
                Positioned(
                    left: 0,
                    right: 0,
                    child: Container(
                        width: double.maxFinite,
                        height: 350,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(
                                detail.places.img
                                  //"http://mark.bslmeiyu.com/uploads/" +
                                      //detail.places.img
                              ),
                              fit: BoxFit.cover),
                        ))),
                Positioned(
                    left: 10,
                    top: 60,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              BlocProvider.of<AppCubits>(context).goHome();
                            },
                            icon: Icon(Icons.menu),
                            color: Colors.white,
                            iconSize: 35),
                      ],
                    )),
                Positioned(
                    top: 330,
                    child: Container(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 30),
                      width: MediaQuery.of(context).size.width,
                      height: double.maxFinite,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AppLargeText(
                                  text: detail.places.name,
                                  color: Colors.black.withOpacity(0.8),
                                  size: 30,
                                ),
                                AppLargeText(
                                  text: "\$" + detail.places.price.toString(),
                                  color: AppColors.secundaryColor,
                                  size: 30,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(Icons.location_on,
                                    color: AppColors.secundaryColor, size: 25),
                                const SizedBox(height: 5),
                                AppText(
                                  text: detail.places.location,
                                  color: AppColors.textColor1,
                                  size: 20,
                                )
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Wrap(
                                  children: List.generate(5, (index) {
                                    return Icon(
                                      Icons.star_rate_rounded,
                                      color: index < detail.places.stars
                                          ? AppColors.starColor
                                          : AppColors.textColor2,
                                      size: 30,
                                    );
                                  }),
                                ),
                                const SizedBox(width: 5),
                                AppText(
                                  text: "(" +
                                      detail.places.stars.toString() +
                                      ".0)",
                                  color: AppColors.textColor2,
                                )
                              ],
                            ),
                            const SizedBox(height: 25),
                            //CAMBIAR POR CARRUSEL DE IMAGENES SACAR DE APP_PELICULAS
                            AppLargeText(
                              text: "Te gustó la experiencia?",
                              color: Colors.black.withOpacity(0.8),
                              size: 20,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            AppText(
                              text: "Recomienda este atractivo a los demás",
                              color: AppColors.mainTextColor,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Wrap(
                              children: List.generate(5, (index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                      voto = selectedIndex + 1;
                                      print(
                                          "Nivel recomendacion: $voto");
                                    });
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 12),
                                    child: AppButtons(
                                      size: 50,
                                      color: selectedIndex == index
                                          ? Colors.white
                                          : Colors.black,
                                      backgroundColor: selectedIndex == index
                                          ? Colors.black
                                          : AppColors.secundarybuttonColor,
                                      borderColor: selectedIndex == index
                                          ? Colors.black
                                          : AppColors.secundarybuttonColor,
                                      text: (index + 1).toString(),
                                    ),
                                  ),
                                );
                              }),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            AppLargeText(
                              text: "Descripción",
                              color: Colors.black.withOpacity(0.8),
                              size: 30,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            AppText(
                              text: detail.places.description,
                              color: AppColors.mainTextColor,
                            ),
                          ]),
                    )),
                Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Row(
                      children: [
                        AppButtons(
                          size: 60,
                          color: AppColors.textColor2,
                          backgroundColor: Colors.white,
                          borderColor: AppColors.textColor1,
                          isIcon: true,
                          icon: Icons.favorite_border,
                        ),
                        const SizedBox(width: 20),
                        ResponsiveButton(
                          isResponsive: true,
                        )
                      ],
                    ))
              ],
            )),
      );
    });
  }
}
