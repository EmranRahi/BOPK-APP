// To parse this JSON data, do
//
//     final subCategoryModel = subCategoryModelFromJson(jsonString);

import 'dart:convert';

List<SubCategoryModel> subCategoryModelFromJson(String str) => List<SubCategoryModel>.from(json.decode(str).map((x) => SubCategoryModel.fromJson(x)));

String subCategoryModelToJson(List<SubCategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCategoryModel {
  int? categoryId;
  String? categoryName;
  String? uniqueName;
  bool? isAppCategory;
  int? sortOrder;
  int? fkMainCategoryId;
  String? mainCategory;

  SubCategoryModel({
    this.categoryId,
    this.categoryName,
    this.uniqueName,
    this.isAppCategory,
    this.sortOrder,
    this.fkMainCategoryId,
    this.mainCategory,
  });

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) => SubCategoryModel(
    categoryId: json["categoryId"],
    categoryName: json["categoryName"],
    uniqueName: json["uniqueName"],
    isAppCategory: json["isAppCategory"],
    sortOrder: json["sortOrder"],
    fkMainCategoryId: json["fkMainCategoryId"],
    mainCategory: json["mainCategory"],
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "categoryName": categoryName,
    "uniqueName": uniqueName,
    "isAppCategory": isAppCategory,
    "sortOrder": sortOrder,
    "fkMainCategoryId": fkMainCategoryId,
    "mainCategory": mainCategory,
  };
}
