import 'dart:convert';

class SliderModel {
  List<SliderData>? data;

  SliderModel({
    this.data,
  });

  factory SliderModel.fromRawJson(String str) => SliderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
    data: json["data"] == null ? [] : List<SliderData>.from(json["data"]!.map((x) => SliderData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class SliderData {
  int? id;
  Media? media;
  String? linkedType;
  int? linkedId;
  String? type;
  String? externalLink;

  SliderData({
    this.id,
    this.media,
    this.linkedType,
    this.linkedId,
    this.type,
    this.externalLink,
  });

  factory SliderData.fromRawJson(String str) => SliderData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SliderData.fromJson(Map<String, dynamic> json) => SliderData(
    id: json["id"],
    media: json["media"] == null ? null : Media.fromJson(json["media"]),
    linkedType: json["linked_type"],
    linkedId: json["linked_id"],
    type: json["type"],
    externalLink: json["external_link"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "media": media?.toJson(),
    "linked_type": linkedType,
    "linked_id": linkedId,
    "type": type,
    "external_link": externalLink,
  };
}

class Media {
  int? id;
  String? file;

  Media({
    this.id,
    this.file,
  });

  factory Media.fromRawJson(String str) => Media.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Media.fromJson(Map<String, dynamic> json) => Media(
    id: json["id"],
    file: json["file"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "file": file,
  };
}
