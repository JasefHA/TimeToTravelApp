import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class FullScreenMap extends StatefulWidget {
  @override
  State<FullScreenMap> createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  late MapboxMapController mapController;

  final center = const LatLng(-12.180866137998564, -76.96654393352819);
  String selectedStyle = 'mapbox://styles/jasef/cl5kdyoll001t14owunsl8d6a';
  final oscuroStyle = 'mapbox://styles/jasef/cl5ke94xb001e14jhriqax1zz';
  final streetStyle = 'mapbox://styles/jasef/cl5kdyoll001t14owunsl8d6a';

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  //const FullScreenMap({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: crearMapa(),
      floatingActionButton: botonesFlotantes(),
    );
  }

  Column botonesFlotantes() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        //ZOOM IN
        FloatingActionButton(
            child: Icon(Icons.zoom_in),
            onPressed: () {
              mapController.animateCamera(CameraUpdate.zoomIn());
            }
        ),
        SizedBox(height: 5),

        //ZOOM OUT
        FloatingActionButton(
            child: Icon(Icons.zoom_out),
            onPressed: () {
              mapController.animateCamera(CameraUpdate.zoomOut());
            }
        ),
        SizedBox(height: 5),

        //CAMBIAR STYLE
        FloatingActionButton(
            child: Icon(Icons.dark_mode_outlined),
            onPressed: () {
              if (selectedStyle == oscuroStyle) {
                selectedStyle = streetStyle;
              } else {
                selectedStyle = oscuroStyle;
              }
              //selectedStyle = streetStyle;
              setState(() {});
            })
      ],
    );
  }

  MapboxMap crearMapa() {
    return MapboxMap(
      styleString: selectedStyle,
      accessToken:
          'sk.eyJ1IjoiamFzZWYiLCJhIjoiY2w1ajJpMm81MGEyeTNjcGZsOGt2MHN4aSJ9.7ZeEDY6As-TIhAN3AQBnig',
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(target: center, zoom: 14),
    );
  }
}
