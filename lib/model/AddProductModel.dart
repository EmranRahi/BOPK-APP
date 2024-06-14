// To parse this JSON data, do
//
//     final addProductModel = addProductModelFromJson(jsonString);

import 'dart:convert';

AddProductModel addProductModelFromJson(String str) => AddProductModel.fromJson(json.decode(str));

String addProductModelToJson(AddProductModel data) => json.encode(data.toJson());

class AddProductModel {
  int? itemsId;
  int? fkKarobarId;
  String? name;
  String? description;
  int? price;
  int? orignalPrice;
  int? stockQuantity;

  AddProductModel({
    this.itemsId=0,
    this.fkKarobarId=0,
    this.name="",
    this.description="",
    this.price=0,
    this.orignalPrice=0,
    this.stockQuantity=0,
  });

  factory AddProductModel.fromJson(Map<String, dynamic> json) => AddProductModel(
    itemsId: json["itemsId"],
    fkKarobarId: json["fkKarobarId"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    orignalPrice: json["orignalPrice"],
    stockQuantity: json["stockQuantity"],
  );

  Map<String, dynamic> toJson() => {
    "itemsId": itemsId,
    "fkKarobarId": fkKarobarId,
    "name": name,
    "description": description,
    "price": price,
    "orignalPrice": orignalPrice,
    "stockQuantity": stockQuantity,
  };
}
