class AmountModel {
  const AmountModel({this.amount});
  final String? amount;
}

const List<AmountModel> billModel = <AmountModel>[
  AmountModel(amount: '100',),
  AmountModel(amount: '500',),
  AmountModel(amount: '1000',),
  AmountModel(amount: '5000',),
];