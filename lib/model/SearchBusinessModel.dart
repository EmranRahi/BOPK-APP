import 'dart:convert';
SearchBusinessModel searchBusinessModelFromJson(String str) => SearchBusinessModel.fromJson(json.decode(str));
String searchBusinessModelToJson(SearchBusinessModel data) => json.encode(data.toJson());

class SearchBusinessModel {
  int? categoryId;
  int? page;
  String? searchTerm;
  double? lat;
  double? lng;
  int? miles;

  SearchBusinessModel({
    this.categoryId,
    this.page,
    this.searchTerm,
    this.lat,
    this.lng,
    this.miles,
  });

  factory SearchBusinessModel.fromJson(Map<String, dynamic> json) => SearchBusinessModel(
    categoryId: json["categoryId"],
    page: json["page"],
    searchTerm: json["searchTerm"],
    lat: json["lat"],
    lng: json["lng"],
    miles: json["miles"],
  );

  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "page": page,
    "searchTerm": searchTerm,
    "lat": lat,
    "lng": lng,
    "miles": miles,
  };
}
