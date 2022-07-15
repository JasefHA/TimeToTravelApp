class UserModel {
  String? id;
  String? nombre;
  String? apellido;
  String? email;
  String? password;
  String? imagen;
  String? estado;
  String? rol;
  String? google;
  String? accessToken;
  String? refreshToken;

  UserModel({
    this.id,
    this.nombre,
    this.apellido,
    this.email,
    this.password,
    this.imagen,
    this.estado,
    this.rol,
    this.google,
    this.accessToken,
    this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      nombre: json["nombre"],
      apellido: json["apellido"],
      email: json["email"],
      password: json["password"],
      imagen: json["imagen"],
      estado: json["estado"],
      rol: json["rol"],
      google: json["google"],
      accessToken: json["accessToken"],
      refreshToken: json["refreshToken"],
    );
  }

//    isCompleted = json["isCompleted"] == "true",
  //  id = json["id"] as int;

}
