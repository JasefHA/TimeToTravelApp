//modelo de restaurante

class DataModel {
  String name;
  String description;
  int stars;
  double price;
  String img;
  String location;
  DataModel({
    required this.name,
    required this.img,
    required this.price,
    required this.stars,
    required this.description,
    required this.location,
  });
  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
        name: json["name"],
        img: json["img"],
        price: json["price"],
        stars: json["stars"],
        description: json["description"],
        location: json["location"]);
  }
}
