import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:time_to_travel_app/model/data_model.dart';

//AQUI SE HACE LA CONEXION A LA API

class DataServices {
  //String baseUrl = "http://mark.bslmeiyu.com/api";
  String baseUrl = "http://10.0.2.2:3000/api";
  Future<List<DataModel>> getInfo() async {
    var apiDestinos = '/destinos';
    //TODO var apiRestaurantes = '/restaurantes';
    //var apiUrl = '/getplaces';
    http.Response resDestinos = await http.get(Uri.parse(baseUrl + apiDestinos));
    //TODO http.Response resRestaurantes = await http.get(Uri.parse(baseUrl + apiRestaurantes));
    try {
      if (resDestinos.statusCode == 200) {
        List<dynamic> list = json.decode(resDestinos.body);
        print(list);
        return list.map((e) => DataModel.fromJson(e)).toList();
      } else {
        return <DataModel>[];
      }
    } catch (e) {
      print(e);
      return <DataModel>[];
    }
  }
}
