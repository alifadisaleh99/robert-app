import 'dart:convert';

class TestChoosesTimeModel {
  List<SurveyChoosesTime>? survey;
  List<SurveyChoosesTimeDetail>? surveyDetails;

  TestChoosesTimeModel({
    this.survey,
    this.surveyDetails,
  });

  factory TestChoosesTimeModel.fromRawJson(String str) => TestChoosesTimeModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TestChoosesTimeModel.fromJson(Map<String, dynamic> json) => TestChoosesTimeModel(
    survey: json["survey"] == null ? [] : List<SurveyChoosesTime>.from(json["survey"]!.map((x) => SurveyChoosesTime.fromJson(x))),
    surveyDetails: json["survey_details"] == null ? [] : List<SurveyChoosesTimeDetail>.from(json["survey_details"]!.map((x) => SurveyChoosesTimeDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "survey": survey == null ? [] : List<dynamic>.from(survey!.map((x) => x.toJson())),
    "survey_details": surveyDetails == null ? [] : List<dynamic>.from(surveyDetails!.map((x) => x.toJson())),
  };
}

class SurveyChoosesTime {
  int? id;
  String? arName;
  String? slug;
  String? metaTitle;
  String? metaDescription;
  int? entriesCount;
  int? questionsCount;
  int? byAdmin;
  String? notes;
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

  SurveyChoosesTime({
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

  factory SurveyChoosesTime.fromRawJson(String str) => SurveyChoosesTime.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SurveyChoosesTime.fromJson(Map<String, dynamic> json) => SurveyChoosesTime(
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

class SurveyChoosesTimeDetail {
  Question? question;

  SurveyChoosesTimeDetail({
    this.question,
  });

  factory SurveyChoosesTimeDetail.fromRawJson(String str) => SurveyChoosesTimeDetail.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SurveyChoosesTimeDetail.fromJson(Map<String, dynamic> json) => SurveyChoosesTimeDetail(
    question: json["question"] == null ? null : Question.fromJson(json["question"]),
  );

  Map<String, dynamic> toJson() => {
    "question": question?.toJson(),
  };
}

class Question {
  int? id;
  int? surveyId;
  dynamic sectionId;
  String? content;
  dynamic image;
  dynamic secondImage;
  String? type;
  List<String>? arOptions;
  List<String>? answers;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? hasStage;
  dynamic stage;
  dynamic enOptions;

  Question({
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

  factory Question.fromRawJson(String str) => Question.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    surveyId: json["survey_id"],
    sectionId: json["section_id"],
    content: json["content"],
    image: json["image"],
    secondImage: json["second_image"],
    type: json["type"],
    arOptions: json["ar_options"] == null ? [] : List<String>.from(json["ar_options"]!.map((x) => x)),
    answers: json["answers"] == null ? [] : List<String>.from(json["answers"]!.map((x) => x)),
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
    "answers": answers == null ? [] : List<dynamic>.from(answers!.map((x) => x)),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "has_stage": hasStage,
    "stage": stage,
    "en_options": enOptions,
  };
}
