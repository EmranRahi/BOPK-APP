// To parse this JSON data, do
//
//     final bannerApiModel = bannerApiModelFromJson(jsonString);

import 'dart:convert';

List<BannerApiModel> bannerApiModelFromJson(String str) => List<BannerApiModel>.from(json.decode(str).map((x) => BannerApiModel.fromJson(x)));

String bannerApiModelToJson(List<BannerApiModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BannerApiModel {
  int? bannerId;
  int? fkKarobarId;
  String? bannerName;
  String? webBanner;
  String? landingLink;
  bool? isMain;
  bool? isActive;
  DateTime? dateAdded;
  String? karobar;

  BannerApiModel({
    this.bannerId=0,
    this.fkKarobarId=0,
    this.bannerName="",
    this.webBanner="",
    this.landingLink="",
    this.isMain=false,
    this.isActive=false,
    this.dateAdded,
    this.karobar="",
  });

  factory BannerApiModel.fromJson(Map<String, dynamic> json) => BannerApiModel(
    bannerId: json["bannerId"],
    fkKarobarId: json["fkKarobarId"],
    bannerName: json["bannerName"],
    webBanner: json["webBanner"],
    landingLink: json["landingLink"],
    isMain: json["isMain"],
    isActive: json["isActive"],
    dateAdded: json["dateAdded"] == null ? null : DateTime.parse(json["dateAdded"]),
    karobar: json["karobar"],
  );

  Map<String, dynamic> toJson() => {
    "bannerId": bannerId,
    "fkKarobarId": fkKarobarId,
    "bannerName": bannerName,
    "webBanner": webBanner,
    "landingLink": landingLink,
    "isMain": isMain,
    "isActive": isActive,
    "dateAdded": dateAdded?.toIso8601String(),
    "karobar": karobar,
  };
}

