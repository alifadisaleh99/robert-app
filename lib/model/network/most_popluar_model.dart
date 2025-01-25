import 'dart:convert';

class MostPopularModel {
  List<MostPopularData>? data;

  MostPopularModel({
    this.data,
  });

  factory MostPopularModel.fromRawJson(String str) => MostPopularModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MostPopularModel.fromJson(Map<String, dynamic> json) => MostPopularModel(
    data: json["data"] == null ? [] : List<MostPopularData>.from(json["data"]!.map((x) => MostPopularData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class MostPopularData {
  int? id;
  String? arName;
  String? slug;
  String? metaTitle;
  String? metaDescription;
  int? questionsCount;
  int? timer;
  String? image;
  String? notes;
  String? surveyType;

  MostPopularData({
    this.id,
    this.arName,
    this.slug,
    this.metaTitle,
    this.metaDescription,
    this.questionsCount,
    this.timer,
    this.image,
    this.notes,
    this.surveyType,
  });

  factory MostPopularData.fromRawJson(String str) => MostPopularData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MostPopularData.fromJson(Map<String, dynamic> json) => MostPopularData(
    id: json["id"],
    arName: json["ar_name"],
    slug: json["slug"],
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    questionsCount: json["questions_count"],
    timer: json["timer"],
    image: json["image"],
    notes: json["notes"],
    surveyType: json["survey_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ar_name": arName,
    "slug": slug,
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "questions_count": questionsCount,
    "timer": timer,
    "image": image,
    "notes": notes,
    "survey_type": surveyType,
  };
}

