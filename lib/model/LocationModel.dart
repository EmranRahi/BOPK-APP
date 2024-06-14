class LocationModel {
  int? locationId;
  dynamic locationName;
  dynamic locLat;
  dynamic locLng;

  LocationModel({
    this.locationId,
    this.locationName,
    this.locLat,
    this.locLng,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
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