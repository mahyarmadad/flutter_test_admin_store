import 'dart:convert';

class SubCategory {
  final String id;
  final String name;
  final String imageId;
  final String categoryId;

  SubCategory(
      {required this.id,
      required this.name,
      required this.imageId,
      required this.categoryId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "imageId": imageId,
      "categoryId": categoryId,
    };
  }

  String toJson() => json.encode(toMap());

  factory SubCategory.fromJson(Map<String, dynamic> map) {
    return SubCategory(
        id: map["_id"],
        name: map["name"],
        imageId: map["image"],
        categoryId: map["category"]["name"]);
  }
}
