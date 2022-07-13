import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

class FullScreenMap extends StatefulWidget {

  @override
  State<FullScreenMap> createState() => _FullScreenMapState();
}

class _FullScreenMapState extends State<FullScreenMap> {
  late MapboxMapController mapController;

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;
  }

  //const FullScreenMap({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MapboxMap(
        accessToken: 'sk.eyJ1IjoiamFzZWYiLCJhIjoiY2w1ajJpMm81MGEyeTNjcGZsOGt2MHN4aSJ9.7ZeEDY6As-TIhAN3AQBnig',
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(target: LatLng(-12.180866137998564, -76.96654393352819),zoom: 14),
      ),
    );
  }
}
