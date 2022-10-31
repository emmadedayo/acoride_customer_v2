class AdvertModel {
  int? id;
  String? advertImage;
  String? advertUrl;

  AdvertModel(
      {this.id,
        this.advertImage,
        this.advertUrl});

  AdvertModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    advertImage = json['advert_image'];
    advertUrl = json['advert_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['advert_image'] = advertImage;
    data['advert_url'] = advertUrl;
    return data;
  }
}
