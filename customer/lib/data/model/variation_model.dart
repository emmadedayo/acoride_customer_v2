class VariationModel {
  String? variationCode;
  String? name;
  String? variationAmount;
  String? fixedPrice;

  VariationModel(
      {this.variationCode, this.name, this.variationAmount, this.fixedPrice});

  VariationModel.fromJson(Map<String, dynamic> json) {
    variationCode = json['variation_code'];
    name = json['name'];
    variationAmount = json['variation_amount'];
    fixedPrice = json['fixedPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['variation_code'] = variationCode;
    data['name'] = name;
    data['variation_amount'] = variationAmount;
    data['fixedPrice'] = fixedPrice;
    return data;
  }
}
