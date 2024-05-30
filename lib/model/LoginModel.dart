// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  int? authId;
  int? fkKarobarId;
  String? password;
  String? userType;
  String? email;
  String? name;
  dynamic shortName;

  LoginModel({
    this.authId,
    this.fkKarobarId,
    this.password,
    this.userType,
    this.email,
    this.name,
    this.shortName,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    authId: json["authId"],
    fkKarobarId: json["fkKarobarId"],
    password: json["password"],
    userType: json["userType"],
    email: json["email"],
    name: json["name"],
    shortName: json["shortName"],
  );

  Map<String, dynamic> toJson() => {
    "authId": authId,
    "fkKarobarId": fkKarobarId,
    "password": password,
    "userType": userType,
    "email": email,
    "name": name,
    "shortName": shortName,
  };
}
