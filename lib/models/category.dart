import 'dart:convert';

class Category {
  final String id;
  final String name;
  final String imageId;
  final String bannerId;

  Category(
      {required this.id,
      required this.name,
      required this.imageId,
      required this.bannerId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "imageId": imageId,
      "bannerId": bannerId,
    };
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(Map<String, dynamic> map) {
    return Category(
        id: map["_id"],
        name: map["name"],
        imageId: map["image"],
        bannerId: map["banner"]);
  }
}
