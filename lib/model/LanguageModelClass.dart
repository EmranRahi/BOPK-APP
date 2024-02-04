// To parse this JSON data, do
//
//     final languageModelClass = languageModelClassFromJson(jsonString);

import 'dart:convert';

List<LanguageModelClass> languageModelClassFromJson(String str) => List<LanguageModelClass>.from(json.decode(str).map((x) => LanguageModelClass.fromJson(x)));

String languageModelClassToJson(List<LanguageModelClass> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LanguageModelClass {
  int? countryId;
  String? name;
  String? shortName;
  DateTime? dateAdded;

  LanguageModelClass({
    this.countryId,
    this.name,
    this.shortName,
    this.dateAdded,
  });

  factory LanguageModelClass.fromJson(Map<String, dynamic> json) => LanguageModelClass(
    countryId: json["countryId"],
    name: json["name"],
    shortName: json["shortName"],
    dateAdded: json["dateAdded"] == null ? null : DateTime.parse(json["dateAdded"]),
  );

  Map<String, dynamic> toJson() => {
    "countryId": countryId,
    "name": name,
    "shortName": shortName,
    "dateAdded": dateAdded?.toIso8601String(),
  };
}
