// To parse this JSON data, do
//
//     final displayReviewModel = displayReviewModelFromJson(jsonString);

import 'dart:convert';

List<DisplayReviewModel> displayReviewModelFromJson(String str) => List<DisplayReviewModel>.from(json.decode(str).map((x) => DisplayReviewModel.fromJson(x)));

String displayReviewModelToJson(List<DisplayReviewModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DisplayReviewModel {
  int? reviewId;
  int? fkKarobarId;
  String? fullName;
  String? email;
  String? review;
  DateTime? dated;
  bool? isValid;
  int? rating;
  String? karobar;

  DisplayReviewModel({
    this.reviewId,
    this.fkKarobarId,
    this.fullName,
    this.email,
    this.review,
    this.dated,
    this.isValid,
    this.rating,
    this.karobar,
  });

  factory DisplayReviewModel.fromJson(Map<String, dynamic> json) => DisplayReviewModel(
    reviewId: json["reviewId"],
    fkKarobarId: json["fkKarobarId"],
    fullName: json["fullName"],
    email: json["email"],
    review: json["review"],
    dated: json["dated"] == null ? null : DateTime.parse(json["dated"]),
    isValid: json["isValid"],
    rating: json["rating"],
    karobar: json["karobar"],
  );

  Map<String, dynamic> toJson() => {
    "reviewId": reviewId,
    "fkKarobarId": fkKarobarId,
    "fullName": fullName,
    "email": email,
    "review": review,
    "dated": dated?.toIso8601String(),
    "isValid": isValid,
    "rating": rating,
    "karobar": karobar,
  };
}
