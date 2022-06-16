//modelo de restaurante

class DataModel {
  String name;
  String description;
  int stars;
  int price;
  String img;
  String location;
  DataModel({
    required this.name,
    required this.description,
    required this.stars,
    required this.price,
    required this.img,
    required this.location,
  });
  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
        name: json["name"],
        description: json["description"],
        stars: json["stars"],
        price: json["price"],
        img: json["img"],
        location: json["location"]);
  }
}
