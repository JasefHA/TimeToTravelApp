import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_to_travel_app/Colors/colors.dart';
import 'package:time_to_travel_app/cubit/app_cubit_states.dart';
import 'package:time_to_travel_app/cubit/app_cubits.dart';
import 'package:time_to_travel_app/widgets/app_text.dart';
import 'package:time_to_travel_app/widgets/app_text_large.dart';
import 'package:time_to_travel_app/widgets/navbar.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> with TickerProviderStateMixin {
  
  final GlobalKey<ScaffoldState> _scaffoldKEy = GlobalKey();

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 1, vsync: this);
    return Scaffold(
        key: _scaffoldKEy,
        drawer: Navbar(),
        body: BlocBuilder<AppCubits, CubitStates>(
          builder: (context, state) {
            if (state is LoadedState) {
              var paquetes = state.paquetes;
              
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 70, left: 20),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            _scaffoldKEy.currentState?.openDrawer();
                          },
                          icon: Icon(Icons.menu),
                          color: Colors.black,
                          iconSize: 35,
                        ),
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
                      child: AppLargeText(
                        text: "Las Mejores Experiencias",
                        size: 30,
                      )
                  ),
                  const SizedBox(height: 15),
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                          labelPadding:
                              const EdgeInsets.only(left: 20, right: 20),
                          controller: _tabController,
                          labelColor: Colors.black,
                          labelStyle: TextStyle(fontSize: 22),
                          unselectedLabelColor: Colors.grey,
                          isScrollable: true,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: CircleTabIndicator(
                              color: AppColors.mainColor, radius: 5),
                          tabs: [
                            Tab(text: "Actividades"),
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
                          itemCount: paquetes.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                BlocProvider.of<AppCubits>(context)
                                    .DetailPage(paquetes[index]);
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.only(right: 15, top: 10),
                                width: 200,
                                height: 500,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    image: DecorationImage(
                                        image: NetworkImage(paquetes[index].img
                                            //"http://mark.bslmeiyu.com/uploads/" +
                                            //    lugares[index].img
                                            ),
                                        fit: BoxFit.cover)),
                              ),
                            );
                          },
                        ),
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
                  const SizedBox(height: 10)
                  
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
