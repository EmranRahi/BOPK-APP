class LocationData {
  int? locationId;
  String? locationName;
  double? locLat;
  double? locLng;

  LocationData({
    this.locationId=0,
    this.locationName="",
    this.locLat=0.0,
    this.locLng=0.0,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) => LocationData(
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