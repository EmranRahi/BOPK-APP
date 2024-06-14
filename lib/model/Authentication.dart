class Authentication {
  int? authId;
  int? fkKarobarId;
  String? password;
  String? userType;
  String? email;
  String? name;
  dynamic shortName;

  Authentication({
    this.authId,
    this.fkKarobarId,
    this.password,
    this.userType,
    this.email,
    this.name,
    this.shortName,
  });

  factory Authentication.fromJson(Map<String, dynamic> json) => Authentication(
    authId: json["authId"],
    fkKarobarId: json["fkKarobarId"],
    password: json["password"],
    userType: json["userType"],
    email: json["email"],
    name: json["name"],
    shortName: json["shortName"],
  );

  Map<String, dynamic> toJson() => {
    "authId": authId,
    "fkKarobarId": fkKarobarId,
    "password": password,
    "userType": userType,
    "email": email,
    "name": name,
    "shortName": shortName,
  };
}