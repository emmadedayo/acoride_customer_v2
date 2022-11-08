import 'package:acoride/data/model/bank_model.dart';

import 'kyc_model.dart';

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
  int? userID;
  String? acorideId;
  String? name;
  String? email;
  String? phoneNumber;
  int? walletBalance;
  bool? accountVerified;
  bool? accountIsDriver;
  bool? userHasLoan;
  String? deviceId;
  String? deviceToken;
  String? rideID;
  String? rideStatus;
  bool? hasPin;
  int? bonus;
  int? rate;
  int? totalRide;
  Kyc? kyc;
  UserBank? userBank;

  UserModel({
    this.id =0,
    this.userID =0,
    this.acorideId = '',
    this.name = '',
    this.email = '',
    this.phoneNumber = '',
    this.walletBalance = 0,
    this.accountVerified = false,
    this.accountIsDriver = false,
    this.userHasLoan = false,
    this.deviceId = '',
    this.deviceToken = '',
    this.hasPin = false,
    this.bonus = 0,
    this.rate = 0,
    this.totalRide = 0,
    this.kyc,
    this.userBank,
    this.rideID,
    this.rideStatus,
  });

  UserModel.fromMap(Map json) {
    id = json['id'] ?? 0;
    userID = json['user_id'] ?? 0;
    acorideId = json['acoride_id'] ?? '';
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    phoneNumber = json['phone_number'] ?? '';
    walletBalance = json['wallet_balance'] ?? 0;
    accountVerified = json['account_verified'] ?? false;
    accountIsDriver = json['account_is_driver'] ?? false;
    userHasLoan = json['user_has_loan'] ?? false;
    deviceId = json['device_id'] ?? '';
    deviceToken = json['device_token'] ?? '';
    hasPin = json['has_pin'] ?? false;
    bonus = json['bonus']  ?? 0;
    rate = json['rate']  ?? 0;
    rideID = json['ride_id']  ?? 0;
    rideStatus = json['ride_status']  ?? 0;
    totalRide = json['total_ride']  ?? 0;
    kyc = json['kyc'] != null ? Kyc.fromMap(json['kyc']) : null;
    userBank = json['userbank'] != null ? UserBank.fromMap(json['userbank']) : null;
  }


  Map<String, dynamic> toMap() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userID;
    data['acoride_id'] = acorideId;
    data['name'] = name;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['wallet_balance'] = walletBalance;
    data['account_verified'] = accountVerified;
    data['account_is_driver'] = accountIsDriver;
    data['user_has_loan'] = userHasLoan;
    data['device_id'] = deviceId;
    data['device_token'] = deviceToken;
    data['has_pin'] = hasPin;
    data['bonus'] = bonus;
    data['rate'] = rate;
    data['ride_status'] = rideStatus;
    data['ride_id'] = rideID;
    data['total_ride'] = totalRide;
    if (kyc != null) {
      data['kyc'] = kyc!.toMap();
    }
    if (userBank != null) {
      data['userbank'] = userBank!.toMap();
    }
    return data;
  }
}
