import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_to_travel_app/Colors/colors.dart';
import 'package:time_to_travel_app/cubit/app_cubit_states.dart';
import 'package:time_to_travel_app/cubit/app_cubits.dart';
import 'package:time_to_travel_app/widgets/app_buttons.dart';
import 'package:time_to_travel_app/widgets/app_text.dart';
import 'package:time_to_travel_app/widgets/app_text_large.dart';
import 'package:time_to_travel_app/widgets/navbar.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKEy = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitStates>(
      builder: (context, state) {
        DetailState detail = state as DetailState;
        return Scaffold(
          key: _scaffoldKEy,
          drawer: Navbar(),
          body: Container(
            // width: double.maxFinite,
            //  height: double.maxFinite,
            child: Stack(
              children: [
                ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        top: 320.0,
                        left: 20.0,
                        right: 20.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                              20.0), //                 <--- border radius here
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                  child: AutoSizeText(
                                detail.places.name,
                                style: const TextStyle(fontSize: 30),
                                maxLines: 2,
                              )),
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
                            children: List.generate(
                              5,
                              (index) {
                                return InkWell(
                                  onTap: () {
                                    setState(
                                      () {
                                        selectedIndex = index;
                                        voto = selectedIndex + 1;
                                        print("Nivel recomendacion: $voto");
                                      },
                                    );
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
                              },
                            ),
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
                            text: detail.places.description +
                                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                            color: AppColors.mainTextColor,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                              top: 20.0,
                              // left: 20.0,
                              //right: 20.0,
                              bottom: 20.0,
                            ),
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.maxFinite,
                    height: 350,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          30.0,
                        ), //                 <--- border radius here
                      ),
                      image: DecorationImage(
                          image: NetworkImage(detail.places.img
                              //"http://mark.bslmeiyu.com/uploads/" +
                              //detail.places.img
                              ),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 60,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            _scaffoldKEy.currentState?.openDrawer();
                          },
                          icon: Icon(Icons.menu),
                          color: Colors.white,
                          iconSize: 35),
                    ],
                  ),
                ),
                Positioned(
                  right: 10,
                  top: 60,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            BlocProvider.of<AppCubits>(context).goHome();
                          },
                          icon: Icon(Icons.home),
                          color: Colors.white,
                          iconSize: 35),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
