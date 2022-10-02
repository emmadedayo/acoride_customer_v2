class BillModel {
  String? serviceID;
  String? name;
  String? minimiumAmount;
  String? maximumAmount;
  String? convinienceFee;
  String? productType;
  String? image;

  BillModel(
      {this.serviceID,
        this.name,
        this.minimiumAmount,
        this.maximumAmount,
        this.convinienceFee,
        this.productType,
        this.image});

  BillModel.fromJson(json) {
    serviceID = json['serviceID'];
    name = json['name'];
    minimiumAmount = json['minimium_amount'];
    maximumAmount = json['maximum_amount'];
    convinienceFee = json['convinience_fee'];
    productType = json['product_type'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['serviceID'] = serviceID;
    data['name'] = name;
    data['minimium_amount'] = minimiumAmount;
    data['maximum_amount'] = maximumAmount;
    data['convinience_fee'] = convinienceFee;
    data['product_type'] = productType;
    data['image'] = image;
    return data;
  }
}
