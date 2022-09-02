class UserModel {
/*
{
  "id": 2,
  "acoride_id": "0",
  "name": "Emmanuel Adenagbe",
  "email": "emmanzley@yahoo.com",
  "phone_number": "08103141421",
  "wallet_balance": 2000,
  "account_verified": true,
  "account_is_driver": false,
  "user_has_loan": false,
  "device_id": "android",
  "fms_token": "bc6cdc46-5ac3-477b-a9e2-a7879fe633f5",
  "kyc": null,
  "userbank": null,
  "has_pin": false,
  "bonus": 500
}
*/

  int? id;
  String? acorideId;
  String? name;
  String? email;
  String? phoneNumber;
  int? walletBalance;
  bool? accountVerified;
  bool? accountIsDriver;
  bool? userHasLoan;
  String? deviceId;
  String? fmsToken;
  bool? hasPin;
  int? bonus;

  UserModel({
    this.id =0,
    this.acorideId = '',
    this.name = '',
    this.email = '',
    this.phoneNumber = '',
    this.walletBalance = 0,
    this.accountVerified = false,
    this.accountIsDriver = false,
    this.userHasLoan = false,
    this.deviceId = '',
    this.fmsToken = '',
    this.hasPin = false,
    this.bonus = 0,
  });

  UserModel.fromMap(Map json) {
    id = json['id'] ?? 0;
    acorideId = json['acoride_id'] ?? '';
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    phoneNumber = json['phone_number'] ?? '';
    walletBalance = json['wallet_balance'] ?? 0;
    accountVerified = json['account_verified'] ?? false;
    accountIsDriver = json['account_is_driver'] ?? false;
    userHasLoan = json['user_has_loan'] ?? false;
    deviceId = json['device_id'] ?? '';
    fmsToken = json['fms_token'] ?? '';
    hasPin = json['has_pin'] ?? false;
    bonus = json['bonus']  ?? 0;
  }


  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['acoride_id'] = acorideId;
    data['name'] = name;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['wallet_balance'] = walletBalance;
    data['account_verified'] = accountVerified;
    data['account_is_driver'] = accountIsDriver;
    data['user_has_loan'] = userHasLoan;
    data['device_id'] = deviceId;
    data['fms_token'] = fmsToken;
    data['has_pin'] = hasPin;
    data['bonus'] = bonus;
    return data;
  }
}
