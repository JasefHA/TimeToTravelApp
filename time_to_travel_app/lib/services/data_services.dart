import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:time_to_travel_app/model/data_model.dart';

//AQUI SE HACE LA CONEXION A LA API

class DataServices {
  //String baseUrl = "http://mark.bslmeiyu.com/api";
  String baseUrl = "http://10.0.2.2:3000/api";
  Future<List<DataModel>> getInfo() async {
    var apiUrl = '/destinos';
    //var apiUrl = '/getplaces';
    http.Response res = await http.get(Uri.parse(baseUrl + apiUrl));
    try {
      if (res.statusCode == 200) {
        List<dynamic> list = json.decode(res.body);
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
