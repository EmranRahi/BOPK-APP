
class GalleryImageDetail {
  int? imageId;
  int? fkKarobarId;
  String? imageName;
  bool? isMainImage;
  String? karobar;

  GalleryImageDetail({
    this.imageId,
    this.fkKarobarId,
    this.imageName,
    this.isMainImage,
    this.karobar,
  });

  factory GalleryImageDetail.fromJson(Map<String, dynamic> json) => GalleryImageDetail(
    imageId: json["imageId"],
    fkKarobarId: json["fkKarobarId"],
    imageName: json["imageName"],
    isMainImage: json["isMainImage"],
    karobar: json["karobar"],
  );

  Map<String, dynamic> toJson() => {
    "imageId": imageId,
    "fkKarobarId": fkKarobarId,
    "imageName": imageName,
    "isMainImage": isMainImage,
    "karobar": karobar,
  };
}