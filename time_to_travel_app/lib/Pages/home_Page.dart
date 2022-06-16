import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_to_travel_app/Colors/colors.dart';
import 'package:time_to_travel_app/cubit/app_cubit_states.dart';
import 'package:time_to_travel_app/cubit/app_cubits.dart';
import 'package:time_to_travel_app/widgets/app_text.dart';
import 'package:time_to_travel_app/widgets/app_text_large.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var images = {
    "mapa-ico.png": "Mapa",
    "actividades-ico.png": "Eventos",
    "restaurant-ico.png": "Restaurant",
    "travel-ico.png": "Popular",
  };

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(body: BlocBuilder<AppCubits, CubitStates>(
      builder: (context, state) {
        if (state is LoadedState) {
          var lugares = state.places;
          var restaurantes = state.restaurants;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 70, left: 20),
                child: Row(
                  children: [
                    Icon(Icons.menu, size: 35, color: Colors.black),
                    Expanded(child: Container()),
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.5)),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: AppLargeText(text: "Descubre", size: 33,)),
              const SizedBox(height: 15),
              Container(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                      labelPadding: const EdgeInsets.only(left: 20, right: 20),
                      controller: _tabController,
                      labelColor: Colors.black,
                      labelStyle: TextStyle(fontSize: 22),
                      unselectedLabelColor: Colors.grey,
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: CircleTabIndicator(
                          color: AppColors.mainColor, radius: 5),
                      tabs: [
                        Tab(text: "Lugares"),
                        Tab(text: "Restaurantes"),
                        Tab(text: "Alojamientos")
                      ]),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 20),
                height: 300,
                width: double.maxFinite,
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    ListView.builder(
                      itemCount: lugares.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            BlocProvider.of<AppCubits>(context)
                                .DetailPage(lugares[index]);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 15, top: 10),
                            width: 200,
                            height: 500,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                image: DecorationImage(
                                    image: NetworkImage(
                                      lugares[index].img
                                        //"http://mark.bslmeiyu.com/uploads/" +
                                        //    lugares[index].img
                                    ),
                                    fit: BoxFit.cover)),
                          ),
                        );
                      },
                    ),
                    ListView.builder(
                      itemCount: restaurantes.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            BlocProvider.of<AppCubits>(context)
                                .DetailPage(restaurantes[index]);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 15, top: 10),
                            width: 200,
                            height: 500,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                                image: DecorationImage(
                                    image: NetworkImage(
                                      restaurantes[index].img
                                        //"http://mark.bslmeiyu.com/uploads/" +
                                        //    lugares[index].img
                                    ),
                                    
                                    fit: BoxFit.cover)),
                          ),
                        );
                      },
                    ),
                    const Text("Ullamco tempor ex nisi exercitation laborum. Nulla ea cupidatat aliqua est anim duis pariatur aliqua. Enim proident proident Lorem sint mollit elit. Qui esse mollit qui labore elit reprehenderit nisi incididunt consequat ut velit amet. Esse ut esse exercitation ex ut ea cillum qui minim tempor enim dolor.")
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppLargeText(
                      text: "Explora más",
                      size: 24,
                    ),
                    AppText(
                      text: "Nuestro contenido",
                      color: AppColors.textColor1,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  margin: const EdgeInsets.only(left: 20),
                  
                  child: ListView.builder(
                      
                      itemCount: 4,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (_, index) {
                        return Container(
                          height: double.maxFinite,
                          margin: const EdgeInsets.only(right: 30),
                          child: Column(
                            
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                //margin: const EdgeInsets.only(right: 50, top: 10),
                                margin: const EdgeInsets.only(right: 45, top: 10),
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: AssetImage("assets/" +
                                            images.keys.elementAt(index)),
                                        fit: BoxFit.cover)),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                margin: const EdgeInsets.only(right: 45, top: 10),
                                child: AppText(
                                  
                                  text: images.values.elementAt(index),
                                  color: AppColors.textColor2,
                                  size: 17,
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              )
            ],
          );
        } else {
          return Container();
        }
      },
    ));
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;

  CircleTabIndicator({required this.color, required this.radius});

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;
  _CirclePainter({required this.color, required this.radius});
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);
    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }
}
