import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:time_to_travel_app/model/data_model.dart';
//import 'package:time_to_travel_app/model/data_model_Restaurante.dart';

//AQUI SE HACE LA CONEXION A LA API

class DataServices {
  //String baseUrl = "http://mark.bslmeiyu.com/api";
  String baseUrl = "http://10.0.2.2:3000/api";

  Future<List<DataModel>> getDestinos() async {
    var apiDestinos = '/destinos';
    //var apiUrl = '/getplaces';
    http.Response resDestinos = await http.get(Uri.parse(baseUrl + apiDestinos));
    try {
      if (resDestinos.statusCode == 200) {
        List<dynamic> list = json.decode(resDestinos.body);
        //print(list);
        return list.map((e) => DataModel.fromJson(e)).toList();
      } else {
        return <DataModel>[];
      }
    } catch (e) {
      //print(e);
      return <DataModel>[];
    }
  }

  Future<List<DataModel>> getRestaurantes() async {
    var apiRestaurantes = '/restaurantes';

    http.Response resRestaurantes = await http.get(Uri.parse(baseUrl + apiRestaurantes));
    try {
      if (resRestaurantes.statusCode == 200) {
        List<dynamic> list = json.decode(resRestaurantes.body);
        //print(list[1]);
        return list.map((e) => DataModel.fromJson(e)).toList();
      } else {
        return <DataModel>[];
      }
    } catch (e) {
      print(e);
      return <DataModel>[];
    }
  }

  Future<List<DataModel>> getAlojamientos() async {
    var apiAlojamientos = '/alojamientos';

    http.Response resAlojamientos = await http.get(Uri.parse(baseUrl + apiAlojamientos));
    try {
      if (resAlojamientos.statusCode == 200) {
        List<dynamic> list = json.decode(resAlojamientos.body);
        //print(list[1]);
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
