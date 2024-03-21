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
  bool? isActive;
  DateTime? dateAdded;

  BannerApiModel({
    this.bannerId=0,
    this.fkKarobarId=0,
    this.bannerName="",
    this.webBanner="",
    this.landingLink="",
    this.isActive=false,
    this.dateAdded,
  });

  factory BannerApiModel.fromJson(Map<String, dynamic> json) => BannerApiModel(
    bannerId: json["bannerId"]??0,
    fkKarobarId: json["fkKarobarId"]??0,
    bannerName: json["bannerName"]??"",
    webBanner: json["webBanner"]??"",
    landingLink: json["landingLink"]??"",
    isActive: json["isActive"]??false,
    dateAdded: json["dateAdded"] == null ? null : DateTime.parse(json["dateAdded"]),
  );

  Map<String, dynamic> toJson() => {
    "bannerId": bannerId,
    "fkKarobarId": fkKarobarId,
    "bannerName": bannerName,
    "webBanner": webBanner,
    "landingLink": landingLink,
    "isActive": isActive,
    "dateAdded": dateAdded?.toIso8601String(),
  };
}
