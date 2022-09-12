
class PayStackTopUpForm{
  PayStackTopUpForm(
      {required this.amount,required this.paymentRef});

  final String amount;
  final String paymentRef;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['amount'] = amount;
    map['payment_ref'] = paymentRef;

    return map;
  }

  PayStackTopUpForm fromMap(dynamic dynamicData) {
    return PayStackTopUpForm(
      amount: dynamicData['amount'],
      paymentRef: dynamicData['payment_ref'],
    );
  }
}
