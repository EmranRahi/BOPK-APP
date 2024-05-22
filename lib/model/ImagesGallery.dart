class ImagesGallery {
  int? imageId;
  int? fkKarobarId;
  String? imageName;
  bool? isMainImage;

  ImagesGallery({
    this.imageId=0,
    this.fkKarobarId=0,
    this.imageName="",
    this.isMainImage=false,
  });

  factory ImagesGallery.fromJson(Map<String, dynamic> json) => ImagesGallery(
    imageId: json["imageId"],
    fkKarobarId: json["fkKarobarId"],
    imageName: json["imageName"],
    isMainImage: json["isMainImage"],
  );

  Map<String, dynamic> toJson() => {
    "imageId": imageId,
    "fkKarobarId": fkKarobarId,
    "imageName": imageName,
    "isMainImage": isMainImage,
  };
}