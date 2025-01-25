import 'dart:convert';

class CategoryModel {
  List<CategoryData>? data;

  CategoryModel({
    this.data,
  });

  factory CategoryModel.fromRawJson(String str) => CategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    data: json["data"] == null ? [] : List<CategoryData>.from(json["data"]!.map((x) => CategoryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class CategoryData {
  int? id;
  String? name;
  String? image;

  CategoryData({
    this.id,
    this.name,
    this.image,
  });

  factory CategoryData.fromRawJson(String str) => CategoryData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryData.fromJson(Map<String, dynamic> json) => CategoryData(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}
