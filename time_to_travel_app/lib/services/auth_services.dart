import 'dart:convert';

import 'package:http/http.dart';

class AuthServices {
  final baseUrl = "http://10.0.2.2:3000";

  Future<Map?> login(Map<String, String> authObj) async {
    try {
      final response =
          await post(Uri.parse(baseUrl + "/api/auth"), body: authObj);
      return jsonDecode(response.body);
    } catch (e) {
      return null;
    }
  }
}
