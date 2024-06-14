class ProductDetail {
  int? itemsId;
  int? fkKarobarId;
  String? name;
  String? description;
  int? price;
  int? orignalPrice;
  int? stockQuantity;
  bool? isActive;
  bool? isDelete;
  DateTime? dateAdded;
  List<ProductItems>? images;
  String? karobar;

  ProductDetail({
    this.itemsId,
    this.fkKarobarId,
    this.name,
    this.description,
    this.price,
    this.orignalPrice,
    this.stockQuantity,
    this.isActive,
    this.isDelete,
    this.dateAdded,
    this.images,
    this.karobar,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
    itemsId: json["itemsId"],
    fkKarobarId: json["fkKarobarId"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    orignalPrice: json["orignalPrice"],
    stockQuantity: json["stockQuantity"],
    isActive: json["isActive"],
    isDelete: json["isDelete"],
    dateAdded: json["dateAdded"] == null ? null : DateTime.parse(json["dateAdded"]),
    images: json["images"] == null ? [] : List<ProductItems>.from(json["images"]!.map((x) => ProductItems.fromJson(x))),
    karobar: json["karobar"],
  );

  Map<String, dynamic> toJson() => {
    "itemsId": itemsId,
    "fkKarobarId": fkKarobarId,
    "name": name,
    "description": description,
    "price": price,
    "orignalPrice": orignalPrice,
    "stockQuantity": stockQuantity,
    "isActive": isActive,
    "isDelete": isDelete,
    "dateAdded": dateAdded?.toIso8601String(),
    "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
    "karobar": karobar,
  };
}

class ProductItems {
  int? imageId;
  int? fkKarobarItemsId;
  String? imageName;
  bool? isActive;
  bool? isMainImage;

  ProductItems({
    this.imageId,
    this.fkKarobarItemsId,
    this.imageName,
    this.isActive,
    this.isMainImage,
  });

  factory ProductItems.fromJson(Map<String, dynamic> json) => ProductItems(
    imageId: json["imageId"],
    fkKarobarItemsId: json["fkKarobarItemsId"],
    imageName: json["imageName"],
    isActive: json["isActive"],
    isMainImage: json["isMainImage"],
  );

  Map<String, dynamic> toJson() => {
    "imageId": imageId,
    "fkKarobarItemsId": fkKarobarItemsId,
    "imageName": imageName,
    "isActive": isActive,
    "isMainImage": isMainImage,
  };
}
