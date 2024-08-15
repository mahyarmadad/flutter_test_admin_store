import 'dart:convert';

class BannerModel {
  final String id;
  final String imageId;

  BannerModel({
    required this.id,
    required this.imageId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "imageId": imageId,
    };
  }

  String toJson() => json.encode(toMap());

  factory BannerModel.fromJson(Map<String, dynamic> map) {
    return BannerModel(id: map["_id"], imageId: map["image"]);
  }
}
