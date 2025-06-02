import 'dart:convert';

class TestDetailsSuddenDeathModel {
  List<Survey>? survey;
  List<SurveyDetail>? surveyDetails;

  TestDetailsSuddenDeathModel({
    this.survey,
    this.surveyDetails,
  });

  factory TestDetailsSuddenDeathModel.fromRawJson(String str) => TestDetailsSuddenDeathModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TestDetailsSuddenDeathModel.fromJson(Map<String, dynamic> json) => TestDetailsSuddenDeathModel(
    survey: json["survey"] == null ? [] : List<Survey>.from(json["survey"]!.map((x) => Survey.fromJson(x))),
    surveyDetails: json["survey_details"] == null ? [] : List<SurveyDetail>.from(json["survey_details"]!.map((x) => SurveyDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "survey": survey == null ? [] : List<dynamic>.from(survey!.map((x) => x.toJson())),
    "survey_details": surveyDetails == null ? [] : List<dynamic>.from(surveyDetails!.map((x) => x.toJson())),
  };
}

class Survey {
  int? id;
  String? arName;
  String? slug;
  String? metaTitle;
  String? metaDescription;
  int? entriesCount;
  int? questionsCount;
  int? byAdmin;
  dynamic notes;
  int? featured;
  String? image;
  int? timer;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? status;
  int? categoryId;
  int? userId;
  String? surveyType;
  dynamic deletedAt;

  Survey({
    this.id,
    this.arName,
    this.slug,
    this.metaTitle,
    this.metaDescription,
    this.entriesCount,
    this.questionsCount,
    this.byAdmin,
    this.notes,
    this.featured,
    this.image,
    this.timer,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.categoryId,
    this.userId,
    this.surveyType,
    this.deletedAt,
  });

  factory Survey.fromRawJson(String str) => Survey.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Survey.fromJson(Map<String, dynamic> json) => Survey(
    id: json["id"],
    arName: json["ar_name"],
    slug: json["slug"],
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    entriesCount: json["entries_count"],
    questionsCount: json["questions_count"],
    byAdmin: json["by_admin"],
    notes: json["notes"],
    featured: json["featured"],
    image: json["image"],
    timer: json["timer"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    status: json["status"],
    categoryId: json["category_id"],
    userId: json["user_id"],
    surveyType: json["survey_type"],
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "ar_name": arName,
    "slug": slug,
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "entries_count": entriesCount,
    "questions_count": questionsCount,
    "by_admin": byAdmin,
    "notes": notes,
    "featured": featured,
    "image": image,
    "timer": timer,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "status": status,
    "category_id": categoryId,
    "user_id": userId,
    "survey_type": surveyType,
    "deleted_at": deletedAt,
  };
}

class SurveyDetail {
  QuestionDeath? question;

  SurveyDetail({
    this.question,
  });

  factory SurveyDetail.fromRawJson(String str) => SurveyDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SurveyDetail.fromJson(Map<String, dynamic> json) => SurveyDetail(
    question: json["question"] == null ? null : QuestionDeath.fromJson(json["question"]),
  );

  Map<String, dynamic> toJson() => {
    "question": question?.toJson(),
  };
}

class QuestionDeath {
  int? id;
  int? surveyId;
  dynamic sectionId;
  String? content;
  dynamic image;
  dynamic secondImage;
  String? type;
  List<String>? arOptions;
  Map<String, String>? answers;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? hasStage;
  dynamic stage;
  dynamic enOptions;

  QuestionDeath({
    this.id,
    this.surveyId,
    this.sectionId,
    this.content,
    this.image,
    this.secondImage,
    this.type,
    this.arOptions,
    this.answers,
    this.createdAt,
    this.updatedAt,
    this.hasStage,
    this.stage,
    this.enOptions,
  });

  factory QuestionDeath.fromRawJson(String str) => QuestionDeath.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuestionDeath.fromJson(Map<String, dynamic> json) => QuestionDeath(
    id: json["id"],
    surveyId: json["survey_id"],
    sectionId: json["section_id"],
    content: json["content"],
    image: json["image"],
    secondImage: json["second_image"],
    type: json["type"],
    arOptions: json["ar_options"] == null ? [] : List<String>.from(json["ar_options"]!.map((x) => x)),
    answers: Map.from(json["answers"]!).map((k, v) => MapEntry<String, String>(k, v)),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    hasStage: json["has_stage"],
    stage: json["stage"],
    enOptions: json["en_options"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "survey_id": surveyId,
    "section_id": sectionId,
    "content": content,
    "image": image,
    "second_image": secondImage,
    "type": type,
    "ar_options": arOptions == null ? [] : List<dynamic>.from(arOptions!.map((x) => x)),
    "answers": Map.from(answers!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "has_stage": hasStage,
    "stage": stage,
    "en_options": enOptions,
  };
}
