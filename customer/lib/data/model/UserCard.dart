///
/// Code generated by jsonToDartModel https://ashamp.github.io/jsonToDartModel/
///
class UserCard {
/*
{
  "id": 1,
  "user_id": "1",
  "transaction_id": "2062927690",
  "authorization_code": "AUTH_1q1t7sdzhv",
  "bin": "408408",
  "last4": "4081",
  "exp_month": "12",
  "exp_year": "2030",
  "channel": "card",
  "card_type": "visa ",
  "bank": "TEST BANK",
  "country_code": "NG",
  "brand": "visa",
  "reusable": "true",
  "signature": "SIG_ZknOGYR5HlqFGZ6I8QDF",
  "account_name": null,
  "is_active": "1",
  "created_at": "2022-08-31T01:36:03.000000Z",
  "updated_at": "2022-08-31T01:36:03.000000Z",
  "deleted_at": null
}
*/

  int? id;
  String? userId;
  String? transactionId;
  String? bin;
  String? last4;
  String? expMonth;
  String? expYear;
  String? channel;
  String? cardType;
  String? bank;
  String? countryCode;
  String? brand;
  String? reusable;
  String? accountName;
  String? isActive;

  UserCard({
    this.id,
    this.userId,
    this.transactionId,
    this.bin,
    this.last4,
    this.expMonth,
    this.expYear,
    this.channel,
    this.cardType,
    this.bank,
    this.countryCode,
    this.brand,
    this.reusable,
    this.accountName,
    this.isActive,
  });
  UserCard.fromMap(json) {
    id = json['id']?.toInt();
    userId = json['user_id']?.toString();
    transactionId = json['transaction_id']?.toString();
    bin = json['bin']?.toString();
    last4 = json['last4']?.toString();
    expMonth = json['exp_month']?.toString();
    expYear = json['exp_year']?.toString();
    channel = json['channel']?.toString();
    cardType = json['card_type']?.toString();
    bank = json['bank']?.toString();
    countryCode = json['country_code']?.toString();
    brand = json['brand']?.toString();
    reusable = json['reusable']?.toString();
    accountName = json['account_name']?.toString();
    isActive = json['is_active']?.toString();
  }
  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['transaction_id'] = transactionId;
    data['bin'] = bin;
    data['last4'] = last4;
    data['exp_month'] = expMonth;
    data['exp_year'] = expYear;
    data['channel'] = channel;
    data['card_type'] = cardType;
    data['bank'] = bank;
    data['country_code'] = countryCode;
    data['brand'] = brand;
    data['reusable'] = reusable;
    data['account_name'] = accountName;
    data['is_active'] = isActive;
    return data;
  }
}
