import 'dart:convert';

List<HomeCategory> homeCategoryFromJson(String str) => List<HomeCategory>.from(json.decode(str).map((x) => HomeCategory.fromJson(x)));

String homeCategoryToJson(List<HomeCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeCategory {
  HomeCategory({
    required this.categoryId,
    required  this.categoryName,
    required  this.categoryIcon,
    required  this.myImage,
    required  this.subCategories,
    required  this.isPresent,
  });

  int? categoryId=0;
  String? categoryName="";
  String? categoryIcon="";
  String? myImage="";
  List<SubCategory?> subCategories=[];
  bool? isPresent=false;

  factory HomeCategory.fromJson(Map<String, dynamic> json) => HomeCategory(
    categoryId: json["categoryId"],
    categoryName: json["categoryName"],
    categoryIcon: json["categoryIcon"],
    myImage: json["myImage"],
    subCategories: List<SubCategory>.from(json["subCategories"].map((x) => SubCategory.fromJson(x))),
    isPresent: json["isPresent"],
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "categoryName": categoryName,
    "categoryIcon": categoryIcon,
    "myImage": myImage,
    "subCategories": List<dynamic>.from(subCategories.map((x) => x!.toJson())),
    "isPresent": isPresent,
  };
}

class SubCategory {
  SubCategory({
    required  this.subCategoryId,
    required  this.fkCategory,
    required  this.subCategoryName,
    required  this.subCategoryIcon,
    required  this.myImage,
    required  this.category,
    required  this.isPresent,
    required  this.categories,
    required  this.subCategoriesL1,
  });

  int? subCategoryId=0;
  int? fkCategory=0;
  String? subCategoryName="";
  String? subCategoryIcon="";
  String? myImage="";
  String? category="";
  bool? isPresent=false;
  String? categories="";
  List<SubCategoriesL1?> subCategoriesL1;

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    subCategoryId: json["subCategoryId"],
    fkCategory: json["fkCategory"],
    subCategoryName: json["subCategoryName"],
    subCategoryIcon: json["subCategoryIcon"],
    myImage: json["myImage"],
    category: json["category"],
    isPresent: json["isPresent"],
    categories: json["categories"],
    subCategoriesL1: List<SubCategoriesL1>.from(json["subCategoriesL1"].map((x) => SubCategoriesL1.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "subCategoryId": subCategoryId,
    "fkCategory": fkCategory,
    "subCategoryName": subCategoryName,
    "subCategoryIcon": subCategoryIcon,
    "myImage": myImage,
    "category": category,
    "isPresent": isPresent,
    "categories": categories,
    "subCategoriesL1": List<dynamic>.from(subCategoriesL1.map((x) => x!.toJson())),
  };
}

class SubCategoriesL1 {
  SubCategoriesL1({
    required  this.subCategoryIdL1,
    required  this.fkSubCategory,
    required  this.subCategoryL1Name,
    required  this.subCategoryL1Icon,
    required  this.myImage,
    required  this.isPresent,
    required  this.subCategory,
    required  this.subCategories,
    required  this.subCategoriesL2,
  });

  int? subCategoryIdL1=0;
  int? fkSubCategory=0;
  String? subCategoryL1Name="";
  String? subCategoryL1Icon="";
  String? myImage="";
  bool? isPresent=false;
  String? subCategory="";
  String? subCategories="";
  List<SubCategoriesL2> subCategoriesL2;

  factory SubCategoriesL1.fromJson(Map<String, dynamic> json) => SubCategoriesL1(
    subCategoryIdL1: json["subCategoryIdL1"],
    fkSubCategory: json["fkSubCategory"],
    subCategoryL1Name: json["subCategoryL1Name"],
    subCategoryL1Icon: json["subCategoryL1Icon"],
    myImage: json["myImage"],
    isPresent: json["isPresent"],
    subCategory: json["subCategory"],
    subCategories: json["subCategories"],
    subCategoriesL2: List<SubCategoriesL2>.from(json["subCategoriesL2"].map((x) => SubCategoriesL2.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "subCategoryIdL1": subCategoryIdL1,
    "fkSubCategory": fkSubCategory,
    "subCategoryL1Name": subCategoryL1Name,
    "subCategoryL1Icon": subCategoryL1Icon,
    "myImage": myImage,
    "isPresent": isPresent,
    "subCategory": subCategory,
    "subCategories": subCategories,
    "subCategoriesL2": List<dynamic>.from(subCategoriesL2.map((x) => x.toJson())),
  };
}

class SubCategoriesL2 {
  SubCategoriesL2({
    required  this.subCategoryIdL2,
    required  this.fkSubCategoryL1,
    required  this.subCategoryL2Name,
    required  this.subCategoryL2Icon,
    required  this.myImage,
    required  this.isPresent,
    required  this.subCategoryL1,
    required  this.subCategoriesL1,
  });

  int? subCategoryIdL2=0;
  int? fkSubCategoryL1=0;
  String? subCategoryL2Name="";
  String? subCategoryL2Icon="";
  String? myImage="";
  bool? isPresent=false;
  String? subCategoryL1="";
  String? subCategoriesL1="";

  factory SubCategoriesL2.fromJson(Map<String, dynamic> json) => SubCategoriesL2(
    subCategoryIdL2: json["subCategoryIdL2"],
    fkSubCategoryL1: json["fkSubCategoryL1"],
    subCategoryL2Name: json["subCategoryL2Name"],
    subCategoryL2Icon: json["subCategoryL2Icon"],
    myImage: json["myImage"],
    isPresent: json["isPresent"],
    subCategoryL1: json["subCategoryL1"],
    subCategoriesL1: json["subCategoriesL1"],
  );

  Map<String, dynamic> toJson() => {
    "subCategoryIdL2": subCategoryIdL2,
    "fkSubCategoryL1": fkSubCategoryL1,
    "subCategoryL2Name": subCategoryL2Name,
    "subCategoryL2Icon": subCategoryL2Icon,
    "myImage": myImage,
    "isPresent": isPresent,
    "subCategoryL1": subCategoryL1,
    "subCategoriesL1": subCategoriesL1,
  };
}
