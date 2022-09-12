
class CardTopUp{
  CardTopUp(
      {required this.amount,required this.cardID});

  final String amount;
  final String cardID;

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};

    map['amount'] = amount;
    map['card_id'] = cardID;

    return map;
  }

  CardTopUp fromMap(dynamic dynamicData) {
    return CardTopUp(
      amount: dynamicData['amount'],
      cardID: dynamicData['card_id'],
    );
  }
}
