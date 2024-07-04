// To parse this JSON data, do
//
//     final updateProfileModel = updateProfileModelFromJson(jsonString);

import 'dart:convert';

UpdateProfileModel updateProfileModelFromJson(String str) => UpdateProfileModel.fromJson(json.decode(str));

String updateProfileModelToJson(UpdateProfileModel data) => json.encode(data.toJson());

class UpdateProfileModel {
  int? karobarId;
  String? title;
  String? description;
  String? speciality;
  String? contactName;
  String? contactPhone;
  String? email;
  String? address;
  double? lat;
  double? lng;
  String? url;
  String? otherNumbers;
  String? weblink;
  String? faxNumber;
  String? androidUrl;
  String? iOsurl;
  String? facebookUrl;
  String? twitterUrl;
  String? youtubeUrl;
  String? instagramUrl;
  String? whatsAppNumber;
  int? fkCategoryId;
  String? linkedInUrl;

  UpdateProfileModel({
    this.karobarId=0,
    this.title="",
    this.description="",
    this.speciality="",
    this.contactName="",
    this.contactPhone="",
    this.email="",
    this.address="",
    this.lat=0,
    this.lng=0,
    this.url="",
    this.otherNumbers="",
    this.weblink="",
    this.faxNumber="",
    this.androidUrl="",
    this.iOsurl="",
    this.facebookUrl="",
    this.twitterUrl="",
    this.youtubeUrl="",
    this.instagramUrl="",
    this.whatsAppNumber="",
    this.fkCategoryId=0,
    this.linkedInUrl="",
  });

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) => UpdateProfileModel(
    karobarId: json["karobarId"],
    title: json["title"],
    description: json["description"],
    speciality: json["speciality"],
    contactName: json["contactName"],
    contactPhone: json["contactPhone"],
    email: json["email"],
    address: json["address"],
    lat: json["lat"],
    lng: json["lng"],
    url: json["url"],
    otherNumbers: json["otherNumbers"],
    weblink: json["weblink"],
    faxNumber: json["faxNumber"],
    androidUrl: json["androidUrl"],
    iOsurl: json["iOsurl"],
    facebookUrl: json["facebookUrl"],
    twitterUrl: json["twitterUrl"],
    youtubeUrl: json["youtubeUrl"],
    instagramUrl: json["instagramUrl"],
    whatsAppNumber: json["whatsAppNumber"],
    fkCategoryId: json["fkCategoryId"],
    linkedInUrl: json["linkedInUrl"],
  );

  Map<String, dynamic> toJson() => {
    "karobarId": karobarId,
    "title": title,
    "description": description,
    "speciality": speciality,
    "contactName": contactName,
    "contactPhone": contactPhone,
    "email": email,
    "address": address,
    "lat": lat,
    "lng": lng,
    "url": url,
    "otherNumbers": otherNumbers,
    "weblink": weblink,
    "faxNumber": faxNumber,
    "androidUrl": androidUrl,
    "iOsurl": iOsurl,
    "facebookUrl": facebookUrl,
    "twitterUrl": twitterUrl,
    "youtubeUrl": youtubeUrl,
    "instagramUrl": instagramUrl,
    "whatsAppNumber": whatsAppNumber,
    "fkCategoryId": fkCategoryId,
    "linkedInUrl": linkedInUrl,
  };
}
