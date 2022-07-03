import 'dart:convert';

import 'package:http/http.dart';

class UserServices {
  final baseUrl = 'http://10.0.2.2:3000';
  final headers = {"Content-Type": "application/json;charset=UTF-8"};

  Future<List<dynamic>> getUsuarios() async {
    final response = await get(Uri.parse(baseUrl + '/api/usuarios'));
    print(response.body);
    return jsonDecode(response.body) as List;
  }

  Future<List<dynamic>> getUsuarioByIdEmail(String id) async {
    final response = await get(Uri.parse(baseUrl + '/api/usuarios/$id'));
    print(response.body);
    return jsonDecode(response.body) as List;
  }

  Future<bool> actualizarUsuario(Map<String, String> userObj, String id) async {
    await patch(Uri.parse(baseUrl + '/api/usuarios/$id'), body: userObj);
    return true;
  }

  Future<bool> actualizarPass(
      Map<String, String> passUserObj, String id) async {
    await patch(Uri.parse(baseUrl + '/api/usuarios/password/$id'),
        body: passUserObj);
    return true;
  }

  Future<bool> eliminarUsusario(String id) async {
    await delete(Uri.parse(baseUrl + '/usuarios/$id'));
    return true;
  }
}
