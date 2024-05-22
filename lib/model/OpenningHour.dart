// class OpenningHour {
//   String? dayOfWeek;
//   String? openingTime;
//   String? closingTime;
//   bool? isOpen;
//
//   OpenningHour({
//     this.dayOfWeek="",
//     this.openingTime="",
//     this.closingTime="",
//     this.isOpen=true,
//   });
//
//   factory OpenningHour.fromJson(Map<String, dynamic> json) => OpenningHour(
//     dayOfWeek: json["dayOfWeek"],
//     openingTime: json["openingTime"],
//     closingTime: json["closingTime"],
//     isOpen: json["isOpen"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "dayOfWeek": dayOfWeek,
//     "openingTime": openingTime,
//     "closingTime": closingTime,
//     "isOpen": isOpen,
//   };
// }
class OpenningHour {
  int? id;
  String? dayOfWeek;
  String? openingTime;
  String? closingTime;
  bool? isOpen;
  int? fkBusinessId;
  bool? is24Hour;
  String? karobar;

  OpenningHour({
    this.id=0,
    this.dayOfWeek="",
    this.openingTime="",
    this.closingTime="",
    this.isOpen=false,
    this.fkBusinessId=0,
    this.is24Hour=false,
    this.karobar="",
  });

  factory OpenningHour.fromJson(Map<String, dynamic> json) => OpenningHour(
    id: json["id"],
    dayOfWeek: json["dayOfWeek"],
    openingTime: json["openingTime"],
    closingTime: json["closingTime"],
    isOpen: json["isOpen"],
    fkBusinessId: json["fkBusinessID"],
    is24Hour: json["is24Hour"],
    karobar: json["karobar"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dayOfWeek": dayOfWeek,
    "openingTime": openingTime,
    "closingTime": closingTime,
    "isOpen": isOpen,
    "fkBusinessID": fkBusinessId,
    "is24Hour": is24Hour,
    "karobar": karobar,
  };
}
