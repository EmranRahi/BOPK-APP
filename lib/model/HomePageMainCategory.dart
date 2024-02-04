// To parse this JSON data, do
//
//     final homePageMainCategory = homePageMainCategoryFromJson(jsonString);

import 'dart:convert';

List<HomePageMainCategory> homePageMainCategoryFromJson(String str) => List<HomePageMainCategory>.from(json.decode(str).map((x) => HomePageMainCategory.fromJson(x)));

String homePageMainCategoryToJson(List<HomePageMainCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomePageMainCategory {
  int? mainCategoryId;
  String? mainCategoryName;
  int? sortOrder;
  List<Category>? categories;

  HomePageMainCategory({
    this.mainCategoryId,
    this.mainCategoryName,
    this.sortOrder,
    this.categories,
  });

  factory HomePageMainCategory.fromJson(Map<String, dynamic> json) => HomePageMainCategory(
    mainCategoryId: json["mainCategoryId"],
    mainCategoryName: json["mainCategoryName"],
    sortOrder: json["sortOrder"],
    categories: json["categories"] == null ? [] : List<Category>.from(json["categories"]!.map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "mainCategoryId": mainCategoryId,
    "mainCategoryName": mainCategoryName,
    "sortOrder": sortOrder,
    "categories": categories == null ? [] : List<dynamic>.from(categories!.map((x) => x.toJson())),
  };
}

class Category {
  int? categoryId;
  String? categoryName;
  bool? isAppCategory;
  int? sortOrder;
  int? fkMainCategoryId;

  Category({
    this.categoryId,
    this.categoryName,
    this.isAppCategory,
    this.sortOrder,
    this.fkMainCategoryId,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    categoryId: json["categoryId"],
    categoryName: json["categoryName"],
    isAppCategory: json["isAppCategory"],
    sortOrder: json["sortOrder"],
    fkMainCategoryId: json["fkMainCategoryId"],
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "categoryName": categoryName,
    "isAppCategory": isAppCategory,
    "sortOrder": sortOrder,
    "fkMainCategoryId": fkMainCategoryId,
  };
}
