// To parse this JSON data, do
//
//     final registerYourBusinessModel = registerYourBusinessModelFromJson(jsonString);

import 'dart:convert';

RegisterYourBusinessModel registerYourBusinessModelFromJson(String str) => RegisterYourBusinessModel.fromJson(json.decode(str));

String registerYourBusinessModelToJson(RegisterYourBusinessModel data) => json.encode(data.toJson());

class RegisterYourBusinessModel {
  int? karobarId;
  String? title;
  String? description;
  String? speciality;
  int? fkLocationId;
  String? contactName;
  String? contactPhone;
  String? email;
  String? address;
  double lat; // Corrected type to double
  double lng; // Corrected type to double
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
  bool isVerified;
  String? whatsAppNumber;
  int fkCategoryId;
  Location? location;
  List<dynamic>? images;

  RegisterYourBusinessModel({
    this.karobarId = 0,
    this.title = "",
    this.description = "",
    this.speciality = "",
    this.fkLocationId = 0,
    this.contactName = "",
    this.contactPhone = "",
    this.email = "",
    this.address = "",
    this.lat = 0.0, // Initialize as double
    this.lng = 0.0, // Initialize as double
    this.isActive = true,
    this.password = "",
    this.url = "",
    this.dated,
    this.fkPartnerId = 0,
    this.otherNumbers = "",
    this.hits = 0,
    this.weblink = "",
    this.faxNumber = "",
    this.androidUrl = "",
    this.iOsurl = "",
    this.facebookUrl = "",
    this.twitterUrl = "",
    this.youtubeUrl = "",
    this.linkedInUrl = "",
    this.instagramUrl = "",
    this.isVerified = false,
    this.whatsAppNumber = "",
    this.fkCategoryId = 1,
    this.location,
    this.images,
  });

  factory RegisterYourBusinessModel.fromJson(Map<String, dynamic> json) => RegisterYourBusinessModel(
    karobarId: json["karobarId"] ?? 0,
    title: json["title"] ?? "",
    description: json["description"] ?? "",
    speciality: json["speciality"] ?? "",
    fkLocationId: json["fkLocationId"] ?? 0,
    contactName: json["contactName"] ?? "",
    contactPhone: json["contactPhone"] ?? "",
    email: json["email"] ?? "",
    address: json["address"] ?? "",
    lat: json["lat"] ?? 0,
    lng: json["lng"] ?? 0,
    isActive: json["isActive"] ?? true,
    password: json["password"] ?? "",
    url: json["url"] ?? "",
    dated: json["dated"],
    fkPartnerId: json["fkPartnerId"] ?? 0,
    otherNumbers: json["otherNumbers"] ?? "",
    hits: json["hits"] ?? 0,
    weblink: json["weblink"] ?? "",
    faxNumber: json["faxNumber"] ?? "",
    androidUrl: json["androidUrl"] ?? "",
    iOsurl: json["iOsurl"] ?? "",
    facebookUrl: json["facebookUrl"] ?? "",
    twitterUrl: json["twitterUrl"] ?? "",
    youtubeUrl: json["youtubeUrl"] ?? "",
    linkedInUrl: json["linkedInUrl"] ?? "",
    instagramUrl: json["instagramUrl"] ?? "",
    isVerified: json["isVerified"] ?? false,
    whatsAppNumber: json["whatsAppNumber"] ?? "",
    fkCategoryId: json["fkCategoryId"] ?? 1,
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
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
    "dated": dated,
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
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
  };
}

class Location {
  int? locationId;
  String locationName;
  double locLat;
  double locLng;

  Location({
    this.locationId=0,
    this.locationName="",
    this.locLat=0,
    this.locLng=0,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    locationId: json["locationId"]?? 0,
    locationName: json["locationName"]?? "",
    locLat: json["locLat"]?? 0,
    locLng: json["locLng"]?? 0,
  );

  Map<String, dynamic> toJson() => {
    "locationId": locationId,
    "locationName": locationName,
    "locLat": locLat,
    "locLng": locLng,
  };
}

// class RegisterYourBusinessModel {
//   int? karobarId;
//   String? title;
//   String? description;
//   String? speciality;
//   int? fkLocationId;
//   String? contactName;
//   String? contactPhone;
//   String? email;
//   String? address;
//   int lat;
//   int lng;
//   bool? isActive;
//   String? password;
//   String? url;
//   dynamic dated;
//   dynamic fkPartnerId;
//   String? otherNumbers;
//   dynamic hits;
//   String? weblink;
//   String? faxNumber;
//   String? androidUrl;
//   String? iOsurl;
//   String? facebookUrl;
//   String? twitterUrl;
//   String? youtubeUrl;
//   String? linkedInUrl;
//   String? instagramUrl;
//   dynamic isVerified;
//   String? whatsAppNumber;
//   dynamic fkCategoryId;
//   Location? location;
//   List<dynamic>? images;
//
//   RegisterYourBusinessModel({
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
//     this.hits="",
//     this.weblink="",
//     this.faxNumber="",
//     this.androidUrl="",
//     this.iOsurl="",
//     this.facebookUrl="",
//     this.twitterUrl="",
//     this.youtubeUrl="",
//     this.linkedInUrl="",
//     this.instagramUrl="",
//     this.isVerified="",
//     this.whatsAppNumber="",
//     this.fkCategoryId=1,
//     this.location,
//     this.images,
//   });
//
//   factory RegisterYourBusinessModel.fromJson(Map<String, dynamic> json) => RegisterYourBusinessModel(
//     karobarId: json["karobarId"] ?? 0,
//     title: json["title"] ?? "",
//     description: json["description"] ?? "",
//     speciality: json["speciality"] ?? "",
//     fkLocationId: json["fkLocationId"] ?? 0,
//     contactName: json["contactName"] ?? "",
//     contactPhone: json["contactPhone"] ?? "",
//     email: json["email"] ?? "",
//     address: json["address"] ?? "",
//     lat: json["lat"] ?? 0,
//     lng: json["lng"] ?? 0,
//     isActive: json["isActive"] ?? true,
//     password: json["password"] ?? "",
//     url: json["url"] ?? "",
//     dated: json["dated"],
//     fkPartnerId: json["fkPartnerId"] ?? 0,
//     otherNumbers: json["otherNumbers"] ?? "",
//     hits: json["hits"] ?? "",
//     weblink: json["weblink"] ?? "",
//     faxNumber: json["faxNumber"] ?? "",
//     androidUrl: json["androidUrl"] ?? "",
//     iOsurl: json["iOsurl"] ?? "",
//     facebookUrl: json["facebookUrl"] ?? "",
//     twitterUrl: json["twitterUrl"] ?? "",
//     youtubeUrl: json["youtubeUrl"] ?? "",
//     linkedInUrl: json["linkedInUrl"] ?? "",
//     instagramUrl: json["instagramUrl"] ?? "",
//     isVerified: json["isVerified"] ?? "",
//     whatsAppNumber: json["whatsAppNumber"] ?? "",
//     fkCategoryId: json["fkCategoryId"] ?? 1,
//     location: json["location"] == null ? null : Location.fromJson(json["location"]),
//     images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
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
//     "dated": dated,
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
//     "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
//   };
// }
//
// class Location {
//   int? locationId;
//   String locationName;
//   double locLat;
//   double locLng;
//
//   Location({
//     this.locationId=0,
//     this.locationName="",
//     this.locLat=0,
//     this.locLng=0,
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
