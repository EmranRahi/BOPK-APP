// To parse this JSON data, do
//
//     final contactUsModel = contactUsModelFromJson(jsonString);

import 'dart:convert';

ContactUsModel contactUsModelFromJson(String str) => ContactUsModel.fromJson(json.decode(str));

String contactUsModelToJson(ContactUsModel data) => json.encode(data.toJson());

class ContactUsModel {
  int? contactId ;
  int? fkCityId ;
  int? fkServiceId;
  int? fkProgramId;
  int? fkCountryId;
  int? fkPackageId;
  String? message;
  String? timing;
  int? budget;
  String? area;
  String? token;
  User? user;

  ContactUsModel({
    this.contactId =0,
    this.fkCityId =0,
    this.fkServiceId =0,
    this.fkProgramId =0,
    this.fkCountryId =0,
    this.fkPackageId =0,
    this.message = "",
    this.timing = "",
    this.budget=0,
    this.area ="",
    this.token="",
    this.user,
  });

  factory ContactUsModel.fromJson(Map<String, dynamic> json) => ContactUsModel(
    contactId: json["contactId"] ?? 0,
    fkCityId: json["fkCityId"] ?? 0,
    fkServiceId: json["fkServiceId"]??0,
    fkProgramId: json["fkProgramId"]??0,
    fkCountryId: json["fkCountryId"]??0,
    fkPackageId: json["fkPackageId"]??0,
    message: json["message"]??"",
    timing: json["timing"]??"",
    budget: json["budget"]??0,
    area: json["area"]??"",
    token: json["token"]??"",
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "contactId": contactId,
    "fkCityId": fkCityId,
    "fkServiceId": fkServiceId,
    "fkProgramId": fkProgramId,
    "fkCountryId": fkCountryId,
    "fkPackageId": fkPackageId,
    "message": message,
    "timing": timing,
    "budget": budget,
    "area": area,
    "token": token,
    "user": user?.toJson(),
  };
}

class User {
  String? name;
  String? contact;
  String? email;

  User({
    this.name ="",
    this.contact ="",
    this.email="",
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"]?? "",
    contact: json["contact"]??"",
    email: json["email"]??"",
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "contact": contact,
    "email": email,
  };
}
