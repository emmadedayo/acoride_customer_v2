class DeliveryPayer {
  const DeliveryPayer({this.paying});
  final String? paying;
}

const List<DeliveryPayer> deliveryPayer = <DeliveryPayer>[
  DeliveryPayer(paying:"Sender"),
  DeliveryPayer(paying:"Receiver",),
];

class DeliveryPaymentMethod {
  const DeliveryPaymentMethod({this.method});
  final String? method;
}

const List<DeliveryPaymentMethod> paymentMethod = <DeliveryPaymentMethod>[
  DeliveryPaymentMethod(method:"Cash"),
  DeliveryPaymentMethod(method:"Wallet",),
];