// To parse this JSON data, do
//
//     final openingAndClosingTimeModel = openingAndClosingTimeModelFromJson(jsonString);

import 'dart:convert';

List<OpeningAndClosingTimeModel> openingAndClosingTimeModelFromJson(String str) => List<OpeningAndClosingTimeModel>.from(json.decode(str).map((x) => OpeningAndClosingTimeModel.fromJson(x)));

String openingAndClosingTimeModelToJson(List<OpeningAndClosingTimeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OpeningAndClosingTimeModel {
  int? id;
  String? dayOfWeek;
  String? openingTime;
  String? closingTime;
  bool? isOpen;
  int? fkKarobarId;
  bool? is24Hour;

  OpeningAndClosingTimeModel({
    this.id=0,
    this.dayOfWeek="",
    this.openingTime="",
    this.closingTime="",
    this.isOpen= false,
    this.fkKarobarId=0,
    this.is24Hour=false,
  });

  factory OpeningAndClosingTimeModel.fromJson(Map<String, dynamic> json) => OpeningAndClosingTimeModel(
    id: json["id"]??0,
    dayOfWeek: json["dayOfWeek"]??"",
    openingTime: json["openingTime"]??"",
    closingTime: json["closingTime"]??"",
    isOpen: json["isOpen"]??false,
    fkKarobarId: json["fkKarobarId"]??0,
    is24Hour: json["is24Hour"]=false,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dayOfWeek": dayOfWeek,
    "openingTime": openingTime,
    "closingTime": closingTime,
    "isOpen": isOpen,
    "fkKarobarId": fkKarobarId,
    "is24Hour": is24Hour,
  };
}
