// To parse this JSON data, do
//
//     final detailsPageProductModel = detailsPageProductModelFromJson(jsonString);

import 'dart:convert';

List<DetailsPageProductModel> detailsPageProductModelFromJson(String str) => List<DetailsPageProductModel>.from(json.decode(str).map((x) => DetailsPageProductModel.fromJson(x)));

String detailsPageProductModelToJson(List<DetailsPageProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DetailsPageProductModel {
  int? itemsId;
  int? fkKarobarId;
  int? fkCategoryId;
  String? itemName;
  String? detail;
  String? description;
  int? price;
  String? orignalPrice;
  String? overeview;
  int? stockQuantity;
  bool? isFeature;
  bool? isActive;
  bool? isDelete;
  DateTime? featuredDate;
  DateTime? dateAdded;
  List<dynamic>? images;

  DetailsPageProductModel({
    this.itemsId,
    this.fkKarobarId,
    this.fkCategoryId,
    this.itemName,
    this.detail,
    this.description,
    this.price,
    this.orignalPrice,
    this.overeview,
    this.stockQuantity,
    this.isFeature,
    this.isActive,
    this.isDelete,
    this.featuredDate,
    this.dateAdded,
    this.images,
  });

  factory DetailsPageProductModel.fromJson(Map<String, dynamic> json) => DetailsPageProductModel(
    itemsId: json["itemsId"],
    fkKarobarId: json["fkKarobarId"],
    fkCategoryId: json["fkCategoryId"],
    itemName: json["itemName"],
    detail: json["detail"],
    description: json["description"],
    price: json["price"],
    orignalPrice: json["orignalPrice"],
    overeview: json["overeview"],
    stockQuantity: json["stockQuantity"],
    isFeature: json["isFeature"],
    isActive: json["isActive"],
    isDelete: json["isDelete"],
    featuredDate: json["featuredDate"] == null ? null : DateTime.parse(json["featuredDate"]),
    dateAdded: json["dateAdded"] == null ? null : DateTime.parse(json["dateAdded"]),
    images: json["images"] == null ? [] : List<dynamic>.from(json["images"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "itemsId": itemsId,
    "fkKarobarId": fkKarobarId,
    "fkCategoryId": fkCategoryId,
    "itemName": itemName,
    "detail": detail,
    "description": description,
    "price": price,
    "orignalPrice": orignalPrice,
    "overeview": overeview,
    "stockQuantity": stockQuantity,
    "isFeature": isFeature,
    "isActive": isActive,
    "isDelete": isDelete,
    "featuredDate": featuredDate?.toIso8601String(),
    "dateAdded": dateAdded?.toIso8601String(),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
  };
}
