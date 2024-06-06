// // To parse this JSON data, do
// //
// //     final registerReviewModel = registerReviewModelFromJson(jsonString);
//
// import 'dart:convert';
//
// RegisterReviewModel registerReviewModelFromJson(String str) => RegisterReviewModel.fromJson(json.decode(str));
//
// String registerReviewModelToJson(RegisterReviewModel data) => json.encode(data.toJson());
//
// class RegisterReviewModel {
//   int? reviewId;
//   int? fkKarobarId;
//   String? fullName;
//   String? email;
//   String? review;
//   DateTime? dated;
//   bool? isValid;
//   int? rating;
//
//   RegisterReviewModel({
//     this.reviewId =0,
//     this.fkKarobarId=0,
//     this.fullName="",
//     this.email="",
//     this.review="",
//     this.dated,
//     this.isValid=false,
//     this.rating=0,
//   });
//
//   factory RegisterReviewModel.fromJson(Map<String, dynamic> json) => RegisterReviewModel(
//     reviewId: json["reviewId"] ?? 0,
//     fkKarobarId: json["fkKarobarId"] ?? 0,
//     fullName: json["fullName"] ?? "",
//     email: json["email"] ?? "",
//     review: json["review"] ?? "" ,
//     dated: json["dated"] == null ? null : DateTime.parse(json["dated"]),
//     isValid: json["isValid"] ?? false,
//     rating: json["rating"] ?? 0,
//   );
//
//   Map<String, dynamic> toJson() => {
//     "reviewId": reviewId,
//     "fkKarobarId": fkKarobarId,
//     "fullName": fullName,
//     "email": email,
//     "review": review,
//     "dated": dated?.toIso8601String(),
//     "isValid": isValid,
//     "rating": rating,
//   };
// }
// To parse this JSON data, do
//
//     final registerReviewModel = registerReviewModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final registerReviewModel = registerReviewModelFromJson(jsonString);

import 'dart:convert';

RegisterReviewModel registerReviewModelFromJson(String str) => RegisterReviewModel.fromJson(json.decode(str));

String registerReviewModelToJson(RegisterReviewModel data) => json.encode(data.toJson());

class RegisterReviewModel {
  int? reviewId;
  int? fkKarobarId;
  String? name;
  String? email;
  String? review;
  int? rating;

  RegisterReviewModel({
    this.reviewId,
    this.fkKarobarId,
    this.name,
    this.email,
    this.review,
    this.rating,
  });

  factory RegisterReviewModel.fromJson(Map<String, dynamic> json) => RegisterReviewModel(
    reviewId: json["reviewId"],
    fkKarobarId: json["fkKarobarId"],
    name: json["name"],
    email: json["email"],
    review: json["review"],
    rating: json["rating"],
  );

  Map<String, dynamic> toJson() => {
    "reviewId": reviewId,
    "fkKarobarId": fkKarobarId,
    "name": name,
    "email": email,
    "review": review,
    "rating": rating,
  };
}
