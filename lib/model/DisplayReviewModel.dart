// To parse this JSON data, do
//
//     final displayReviewModel = displayReviewModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final displayReviewModel = displayReviewModelFromJson(jsonString);

import 'dart:convert';

List<DisplayReviewModel> displayReviewModelFromJson(String str) => List<DisplayReviewModel>.from(json.decode(str).map((x) => DisplayReviewModel.fromJson(x)));

String displayReviewModelToJson(List<DisplayReviewModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DisplayReviewModel {
  int? reviewId;
  int? fkKarobarId;
  String? name;
  String? email;
  String? review;
  int? rating;
  bool? isValid;
  DateTime? dateTime;
  String? karobar;

  DisplayReviewModel({
    this.reviewId,
    this.fkKarobarId,
    this.name,
    this.email,
    this.review,
    this.rating,
    this.isValid,
    this.dateTime,
    this.karobar,
  });

  factory DisplayReviewModel.fromJson(Map<String, dynamic> json) => DisplayReviewModel(
    reviewId: json["reviewId"],
    fkKarobarId: json["fkKarobarId"],
    name: json["name"],
    email: json["email"],
    review: json["review"],
    rating: json["rating"],
    isValid: json["isValid"],
    dateTime: json["dateTime"] == null ? null : DateTime.parse(json["dateTime"]),
    karobar: json["karobar"],
  );

  Map<String, dynamic> toJson() => {
    "reviewId": reviewId,
    "fkKarobarId": fkKarobarId,
    "name": name,
    "email": email,
    "review": review,
    "rating": rating,
    "isValid": isValid,
    "dateTime": dateTime?.toIso8601String(),
    "karobar": karobar,
  };
}
