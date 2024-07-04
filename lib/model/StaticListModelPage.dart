// // To parse this JSON data, do
// //
// //     final staticListModel = staticListModelFromJson(jsonString);
//
// import 'dart:convert';
//
// StaticListModel staticListModelFromJson(String str) => StaticListModel.fromJson(json.decode(str));
//
// String staticListModelToJson(StaticListModel data) => json.encode(data.toJson());
//
// class StaticListModel {
//   int? totalCount;
//   int? totalPages;
//   int? page;
//   int? pageSize;
//   List<Datum>? data;
//
//   StaticListModel({
//     this.totalCount,
//     this.totalPages,
//     this.page,
//     this.pageSize,
//     this.data,
//   });
//
//   factory StaticListModel.fromJson(Map<String, dynamic> json) => StaticListModel(
//     totalCount: json["totalCount"],
//     totalPages: json["totalPages"],
//     page: json["page"],
//     pageSize: json["pageSize"],
//     data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "totalCount": totalCount,
//     "totalPages": totalPages,
//     "page": page,
//     "pageSize": pageSize,
//     "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
//   };
// }
//
// class Datum {
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
//   List<ImagesList>? images;
//
//   Datum({
//     this.karobarId,
//     this.title,
//     this.description,
//     this.speciality,
//     this.fkLocationId,
//     this.contactName,
//     this.contactPhone,
//     this.email,
//     this.address,
//     this.lat,
//     this.lng,
//     this.isActive,
//     this.password,
//     this.url,
//     this.dated,
//     this.fkPartnerId,
//     this.otherNumbers,
//     this.hits,
//     this.weblink,
//     this.faxNumber,
//     this.androidUrl,
//     this.iOsurl,
//     this.facebookUrl,
//     this.twitterUrl,
//     this.youtubeUrl,
//     this.linkedInUrl,
//     this.instagramUrl,
//     this.isVerified,
//     this.whatsAppNumber,
//     this.fkCategoryId,
//     this.location,
//     this.images,
//   });
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
//     faxNumber: json["faxNumber"],
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
//     images: json["images"] == null ? [] : List<ImagesList>.from(json["images"]!.map((x) => ImagesList.fromJson(x))),
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
//     "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
//   };
// }
//
// class ImagesList {
//   int? imageId;
//   int? fkKarobarId;
//   String? imageName;
//   bool? isMainImage;
//
//   ImagesList({
//     this.imageId,
//     this.fkKarobarId,
//     this.imageName,
//     this.isMainImage,
//   });
//
//   factory ImagesList.fromJson(Map<String, dynamic> json) => ImagesList(
//     imageId: json["imageId"],
//     fkKarobarId: json["fkKarobarId"],
//     imageName: json["imageName"],
//     isMainImage: json["isMainImage"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "imageId": imageId,
//     "fkKarobarId": fkKarobarId,
//     "imageName": imageName,
//     "isMainImage": isMainImage,
//   };
// }
//
// class Location {
//   int? locationId;
//   dynamic locationName;
//   dynamic locLat;
//   dynamic locLng;
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

StaticListModel staticListModelFromJson(String str) => StaticListModel.fromJson(json.decode(str));

String staticListModelToJson(StaticListModel data) => json.encode(data.toJson());

class StaticListModel {
  int? totalCount;
  int? totalPages;
  int? page;
  int? pageSize;
  List<Datum> data;

  StaticListModel({
    this.totalCount,
    this.totalPages,
    this.page,
    this.pageSize,
    required this.data,
  });

  factory StaticListModel.fromJson(Map<String, dynamic> json) => StaticListModel(
    totalCount: json["totalCount"],
    totalPages: json["totalPages"],
    page: json["page"],
    pageSize: json["pageSize"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount,
    "totalPages": totalPages,
    "page": page,
    "pageSize": pageSize,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
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
  List<dynamic>? openningHours;
  List<ImagesList>? images;
  int? distance;

  Datum({
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
    this.openningHours,
    this.images,
    this.distance,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
    openningHours: json["openningHours"] == null ? [] : List<dynamic>.from(json["openningHours"]!.map((x) => x)),
    images: json["images"] == null ? [] : List<ImagesList>.from(json["images"]!.map((x) => ImagesList.fromJson(x))),
    distance: json["distance"],
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
    "openningHours": openningHours == null ? [] : List<dynamic>.from(openningHours!.map((x) => x)),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
    "distance": distance,
  };
}

class ImagesList {
  int? imageId;
  int? fkKarobarId;
  String? imageName;
  bool? isMainImage;

  ImagesList({
    this.imageId,
    this.fkKarobarId,
    this.imageName,
    this.isMainImage,
  });

  factory ImagesList.fromJson(Map<String, dynamic> json) => ImagesList(
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
