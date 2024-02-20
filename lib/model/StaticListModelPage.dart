// // To parse this JSON data, do
// //
// //     final staticListModel = staticListModelFromJson(jsonString);
//
// import 'dart:convert';
//
// List<StaticListModel> staticListModelFromJson(String str) => List<StaticListModel>.from(json.decode(str).map((x) => StaticListModel.fromJson(x)));
//
// String staticListModelToJson(List<StaticListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
//
// class StaticListModel {
//   int? karobarId;
//   String? title;
//   String? description;
//   String? speciality;
//   int? fkLocationId;
//   String? contactName;
//   String? contactPhone;
//   String? email;
//   String? address;
//   double? lat;
//   double? lng;
//   bool? isActive;
//   String? password;
//   String? url;
//   DateTime? dated;
//   int? fkPartnerId;
//   String? otherNumbers;
//   int? hits;
//   String? weblink;
//   String? faxNumber;
//   String? androidUrl;
//   String? iOsurl;
//   String? facebookUrl;
//   String? twitterUrl;
//   String? youtubeUrl;
//   String? linkedInUrl;
//   String? instagramUrl;
//   bool? isVerified;
//   String? whatsAppNumber;
//   int? fkCategoryId;
//   Location? location;
//
//   StaticListModel({
//     this.karobarId=0,
//     this.title="",
//     this.description="",
//     this.speciality="",
//     this.fkLocationId=0,
//     this.contactName="",
//     this.contactPhone="",
//     this.email="",
//     this.address="",
//     this.lat=0,
//     this.lng=0,
//     this.isActive=true,
//     this.password="",
//     this.url="",
//     this.dated,
//     this.fkPartnerId=0,
//     this.otherNumbers="",
//     this.hits=0,
//     this.weblink="",
//     this.faxNumber="",
//     this.androidUrl="",
//     this.iOsurl="",
//     this.facebookUrl="",
//     this.twitterUrl="",
//     this.youtubeUrl="",
//     this.linkedInUrl="",
//     this.instagramUrl="",
//     this.isVerified=false,
//     this.whatsAppNumber="",
//     this.fkCategoryId=0,
//     this.location,
//   });
//
//   factory StaticListModel.fromJson(Map<String, dynamic> json) => StaticListModel(
//     karobarId: json["karobarId"],
//     title: json["title"],
//     description: json["description"],
//     speciality: json["speciality"],
//     fkLocationId: json["fkLocationId"],
//     contactName: json["contactName"],
//     contactPhone: json["contactPhone"],
//     email: json["email"],
//     address: json["address"],
//     lat: json["lat"]?.toDouble(),
//     lng: json["lng"]?.toDouble(),
//     isActive: json["isActive"],
//     password: json["password"],
//     url: json["url"],
//     dated: json["dated"] == null ? null : DateTime.parse(json["dated"]),
//     fkPartnerId: json["fkPartnerId"],
//     otherNumbers: json["otherNumbers"],
//     hits: json["hits"],
//     weblink: json["weblink"],
//     faxNumber: json["faxNumber"] == null ? "":json["faxNumber"],
//     androidUrl: json["androidUrl"],
//     iOsurl: json["iOsurl"],
//     facebookUrl: json["facebookUrl"],
//     twitterUrl: json["twitterUrl"],
//     youtubeUrl: json["youtubeUrl"],
//     linkedInUrl: json["linkedInUrl"],
//     instagramUrl: json["instagramUrl"],
//     isVerified: json["isVerified"],
//     whatsAppNumber: json["whatsAppNumber"],
//     fkCategoryId: json["fkCategoryId"],
//     location: json["location"] == null ? null : Location.fromJson(json["location"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "karobarId": karobarId,
//     "title": title,
//     "description": description,
//     "speciality": speciality,
//     "fkLocationId": fkLocationId,
//     "contactName": contactName,
//     "contactPhone": contactPhone,
//     "email": email,
//     "address": address,
//     "lat": lat,
//     "lng": lng,
//     "isActive": isActive,
//     "password": password,
//     "url": url,
//     "dated": dated?.toIso8601String(),
//     "fkPartnerId": fkPartnerId,
//     "otherNumbers": otherNumbers,
//     "hits": hits,
//     "weblink": weblink,
//     "faxNumber": faxNumber,
//     "androidUrl": androidUrl,
//     "iOsurl": iOsurl,
//     "facebookUrl": facebookUrl,
//     "twitterUrl": twitterUrl,
//     "youtubeUrl": youtubeUrl,
//     "linkedInUrl": linkedInUrl,
//     "instagramUrl": instagramUrl,
//     "isVerified": isVerified,
//     "whatsAppNumber": whatsAppNumber,
//     "fkCategoryId": fkCategoryId,
//     "location": location?.toJson(),
//   };
// }
// class Location {
//   int? locationId;
//   String? locationName;
//   double? locLat;
//   double? locLng;
//
//   Location({
//     this.locationId,
//     this.locationName,
//     this.locLat,
//     this.locLng,
//   });
//
//   factory Location.fromJson(Map<String, dynamic> json) => Location(
//     locationId: json["locationId"],
//     locationName: json["locationName"],
//     locLat: json["locLat"],
//     locLng: json["locLng"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "locationId": locationId,
//     "locationName": locationName,
//     "locLat": locLat,
//     "locLng": locLng,
//   };
// }
// To parse this JSON data, do
//
//     final staticListModel = staticListModelFromJson(jsonString);

import 'dart:convert';

List<StaticListModel> staticListModelFromJson(String str) => List<StaticListModel>.from(json.decode(str).map((x) => StaticListModel.fromJson(x)));

String staticListModelToJson(List<StaticListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class StaticListModel {
  int? karobarId;
  String? title;
  String? description;
  String? speciality;
  int? fkLocationId;
  String? contactName;
  String? contactPhone;
  String? email;
  String? address;
  double? lat;
  double? lng;
  bool? isActive;
  String? password;
  String? url;
  DateTime? dated;
  int? fkPartnerId;
  String? otherNumbers;
  int? hits;
  String? weblink;
  String? faxNumber;
  String? androidUrl;
  String? iOsurl;
  String? facebookUrl;
  String? twitterUrl;
  String? youtubeUrl;
  String? linkedInUrl;
  String? instagramUrl;
  bool? isVerified;
  String? whatsAppNumber;
  int? fkCategoryId;
  Location? location;
  List<ImageBusiness>? images;

  StaticListModel({
    this.karobarId,
    this.title,
    this.description,
    this.speciality,
    this.fkLocationId,
    this.contactName,
    this.contactPhone,
    this.email,
    this.address,
    this.lat,
    this.lng,
    this.isActive,
    this.password,
    this.url,
    this.dated,
    this.fkPartnerId,
    this.otherNumbers,
    this.hits,
    this.weblink,
    this.faxNumber,
    this.androidUrl,
    this.iOsurl,
    this.facebookUrl,
    this.twitterUrl,
    this.youtubeUrl,
    this.linkedInUrl,
    this.instagramUrl,
    this.isVerified,
    this.whatsAppNumber,
    this.fkCategoryId,
    this.location,
    this.images,
  });

  factory StaticListModel.fromJson(Map<String, dynamic> json) => StaticListModel(
    karobarId: json["karobarId"],
    title: json["title"],
    description: json["description"],
    speciality: json["speciality"],
    fkLocationId: json["fkLocationId"],
    contactName: json["contactName"],
    contactPhone: json["contactPhone"],
    email: json["email"],
    address: json["address"],
    lat: json["lat"]?.toDouble(),
    lng: json["lng"]?.toDouble(),
    isActive: json["isActive"],
    password: json["password"],
    url: json["url"],
    dated: json["dated"] == null ? null : DateTime.parse(json["dated"]),
    fkPartnerId: json["fkPartnerId"],
    otherNumbers: json["otherNumbers"],
    hits: json["hits"],
    weblink: json["weblink"],
    faxNumber: json["faxNumber"],
    androidUrl: json["androidUrl"],
    iOsurl: json["iOsurl"],
    facebookUrl: json["facebookUrl"],
    twitterUrl: json["twitterUrl"],
    youtubeUrl: json["youtubeUrl"],
    linkedInUrl: json["linkedInUrl"],
    instagramUrl: json["instagramUrl"],
    isVerified: json["isVerified"],
    whatsAppNumber: json["whatsAppNumber"],
    fkCategoryId: json["fkCategoryId"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    images: json["images"] == null ? [] : List<ImageBusiness>.from(json["images"]!.map((x) => ImageBusiness.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "karobarId": karobarId,
    "title": title,
    "description": description,
    "speciality": speciality,
    "fkLocationId": fkLocationId,
    "contactName": contactName,
    "contactPhone": contactPhone,
    "email": email,
    "address": address,
    "lat": lat,
    "lng": lng,
    "isActive": isActive,
    "password": password,
    "url": url,
    "dated": dated?.toIso8601String(),
    "fkPartnerId": fkPartnerId,
    "otherNumbers": otherNumbers,
    "hits": hits,
    "weblink": weblink,
    "faxNumber": faxNumber,
    "androidUrl": androidUrl,
    "iOsurl": iOsurl,
    "facebookUrl": facebookUrl,
    "twitterUrl": twitterUrl,
    "youtubeUrl": youtubeUrl,
    "linkedInUrl": linkedInUrl,
    "instagramUrl": instagramUrl,
    "isVerified": isVerified,
    "whatsAppNumber": whatsAppNumber,
    "fkCategoryId": fkCategoryId,
    "location": location?.toJson(),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
  };
}


class ImageBusiness {
  int? imageId;
  int? fkKarobarId;
  String? imageName;
  bool? isMainImage;

  ImageBusiness({
    this.imageId,
    this.fkKarobarId,
    this.imageName,
    this.isMainImage,
  });

  factory ImageBusiness.fromJson(Map<String, dynamic> json) => ImageBusiness(
    imageId: json["imageId"],
    fkKarobarId: json["fkKarobarId"],
    imageName: json["imageName"],
    isMainImage: json["isMainImage"],
  );

  Map<String, dynamic> toJson() => {
    "imageId": imageId,
    "fkKarobarId": fkKarobarId,
    "imageName": imageName,
    "isMainImage": isMainImage,
  };
}

class Location {
  int? locationId;
  dynamic locationName;
  dynamic locLat;
  dynamic locLng;

  Location({
    this.locationId,
    this.locationName,
    this.locLat,
    this.locLng,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    locationId: json["locationId"],
    locationName: json["locationName"],
    locLat: json["locLat"],
    locLng: json["locLng"],
  );

  Map<String, dynamic> toJson() => {
    "locationId": locationId,
    "locationName": locationName,
    "locLat": locLat,
    "locLng": locLng,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
