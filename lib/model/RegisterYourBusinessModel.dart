// To parse this JSON data, do
//
//     final registerYourBusinessModel = registerYourBusinessModelFromJson(jsonString);

import 'dart:convert';

import 'OpenningHour.dart';

RegisterYourBusinessModel registerYourBusinessModelFromJson(String str) => RegisterYourBusinessModel.fromJson(json.decode(str));

String registerYourBusinessModelToJson(RegisterYourBusinessModel data) => json.encode(data.toJson());

class RegisterYourBusinessModel {
  int? id;
  String? title;
  int? fkCategoryId;
  String? description;
  String? speciality;
  String? ownerName;
  String? contactNumber;
  String? otherNumber;
  String? whatsappNumber;
  String? address;
  double? lat;
  double? lng;
  String? email;
  String? facebookUrl;
  String? twitterUrl;
  String? youtubeUrl;
  String? linkedInUrl;
  String? instagramUrl;
  String? weblink;
  String? faxNumber;
  String? androidUrl;
  String? iosUrl;
  String? url;
  List<OpenningHour>? openningHours;

  RegisterYourBusinessModel({
    this.id=0,
    this.title="",
    this.fkCategoryId=0,
    this.description="",
    this.speciality="",
    this.ownerName="",
    this.contactNumber="",
    this.otherNumber="",
    this.whatsappNumber="",
    this.address="",
    this.lat=0.0,
    this.lng=0.0,
    this.email="",
    this.facebookUrl="",
    this.twitterUrl="",
    this.youtubeUrl="",
    this.linkedInUrl="",
    this.instagramUrl="",
    this.weblink="",
    this.faxNumber="",
    this.androidUrl="",
    this.iosUrl="",
    this.url="",
    this.openningHours,
  });

  factory RegisterYourBusinessModel.fromJson(Map<String, dynamic> json) => RegisterYourBusinessModel(
    id: json["id"],
    title: json["title"],
    fkCategoryId: json["fkCategoryId"],
    description: json["description"],
    speciality: json["speciality"],
    ownerName: json["ownerName"],
    contactNumber: json["contactNumber"],
    otherNumber: json["otherNumber"],
    whatsappNumber: json["whatsappNumber"],
    address: json["address"],
    lat: json["lat"],
    lng: json["lng"],
    email: json["email"],
    facebookUrl: json["facebookUrl"],
    twitterUrl: json["twitterUrl"],
    youtubeUrl: json["youtubeUrl"],
    linkedInUrl: json["linkedInUrl"],
    instagramUrl: json["instagramUrl"],
    weblink: json["weblink"],
    faxNumber: json["faxNumber"],
    androidUrl: json["androidUrl"],
    iosUrl: json["iosUrl"],
    url: json["url"],
    openningHours: json["openningHours"] == null ? [] : List<OpenningHour>.from(json["openningHours"]!.map((x) => OpenningHour.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "fkCategoryId": fkCategoryId,
    "description": description,
    "speciality": speciality,
    "ownerName": ownerName,
    "contactNumber": contactNumber,
    "otherNumber": otherNumber,
    "whatsappNumber": whatsappNumber,
    "address": address,
    "lat": lat,
    "lng": lng,
    "email": email,
    "facebookUrl": facebookUrl,
    "twitterUrl": twitterUrl,
    "youtubeUrl": youtubeUrl,
    "linkedInUrl": linkedInUrl,
    "instagramUrl": instagramUrl,
    "weblink": weblink,
    "faxNumber": faxNumber,
    "androidUrl": androidUrl,
    "iosUrl": iosUrl,
    "url": url,
    "openningHours": openningHours == null ? [] : List<dynamic>.from(openningHours!.map((x) => x.toJson())),
  };
}


