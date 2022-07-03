class AuthModel {
  String email;
  String password;
  String token;

  AuthModel({
    required this.email,
    required this.password,
    required this.token,
  });
  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      email: json["email"],
      password: json["password"],
      token: json["token"],
    );
  }

//    isCompleted = json["isCompleted"] == "true",
  //  id = json["id"] as int;

}
