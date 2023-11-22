// To parse this JSON data, do
//
//     final bannersClass = bannersClassFromJson(jsonString);

import 'dart:convert';

List<BannersClass> bannersClassFromJson(String str) => List<BannersClass>.from(json.decode(str).map((x) => BannersClass.fromJson(x)));

String bannersClassToJson(List<BannersClass> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BannersClass {
  BannersClass({
    required this.bannerId,
    required this.bannerName,
    required this.mobileBanner,
    required this.webBanner,
    required this.isActive,
    required this.dateAdded,
    this.mobileImage,
    this.webImage,
  });

  int bannerId;
  String bannerName;
  String mobileBanner;
  String webBanner;
  bool isActive;
  DateTime dateAdded;
  dynamic mobileImage;
  dynamic webImage;

  factory BannersClass.fromJson(Map<String, dynamic> json) => BannersClass(
    bannerId: json["bannerId"],
    bannerName: json["bannerName"],
    mobileBanner:json["mobileBanner"],
    webBanner: json["webBanner"],
    isActive: json["isActive"],
    dateAdded: DateTime.parse(json["dateAdded"]),
    mobileImage: json["mobileImage"],
    webImage: json["webImage"],
  );

  Map<String, dynamic> toJson() => {
    "bannerId": bannerId,
    "bannerName": bannerName,
    "mobileBanner":mobileBanner,
    "webBanner": webBanner,
    "isActive": isActive,
    "dateAdded": dateAdded.toIso8601String(),
    "mobileImage": mobileImage,
    "webImage": webImage,
  };
}

enum MobileBanner { NOT_FOUND_PNG }

final mobileBannerValues = EnumValues({
  "NotFound.png": MobileBanner.NOT_FOUND_PNG
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
