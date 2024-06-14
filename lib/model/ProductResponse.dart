class ProductResponse {
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
  List<String>? images;
  String? karobar;

  ProductResponse({
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

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      itemsId: json['itemsId'],
      fkKarobarId: json['fkKarobarId'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      orignalPrice: json['orignalPrice'],
      stockQuantity: json['stockQuantity'],
      isActive: json['isActive'],
      isDelete: json['isDelete'],
      dateAdded: DateTime.parse(json['dateAdded']),
      images: List<String>.from(json['images']),
      karobar: json['karobar'],
    );
  }
}
