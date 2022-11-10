import 'package:acoride/data/model/TransactionModel.dart';
import 'package:acoride/data/model/ride_request_model.dart';

import 'UserModel.dart';
import 'advert_model.dart';

class DashBoardModel {
  UserModel? user;
  RideRequestModel? rideRequest;
  List<AdvertModel>? advertisements;
  List<TransactionModel>? transactions;
  List<RideRequestModel>? topThree;
  int? notification;

  DashBoardModel({this.user, this.topThree,this.advertisements, this.notification, this.transactions,this.rideRequest});

  DashBoardModel.fromMap(json) {
    user = json['user'] != null ? UserModel.fromMap(json['user']) : null;
    rideRequest = json['ride'] != null ? RideRequestModel.fromMap(json['ride']) : null;
    if (json['advertisements'] != null) {
      advertisements = <AdvertModel>[];
      json['advertisements'].forEach((v) {
        advertisements?.add(AdvertModel.fromJson(v));
      });
    }
    if (json['transactions'] != null) {
      transactions = <TransactionModel>[];
      json['transactions'].forEach((v) {
        transactions?.add(TransactionModel.fromMap(v));
      });
    }

    if (json['top_three_ride'] != null) {
      topThree = <RideRequestModel>[];
      json['top_three_ride'].forEach((v) {
        topThree?.add(RideRequestModel.fromMap(v));
      });
    }

    notification = json['notification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    final rideRequest = this.rideRequest;
    if (rideRequest != null) {
      data['ride'] = rideRequest.toMap();
    }

    final user = this.user;
    if (user != null) {
      data['user'] = user.toMap();
    }
    final advertisements = this.advertisements;
    if (advertisements != null) {
      data['advertisements'] =
          advertisements.map((v) => v.toJson()).toList();
    }
    final transaction = transactions;
    if (transaction != null) {
      data['transactions'] =
          transaction.map((v) => v.toMap()).toList();
    }

    final topThree = this.topThree;
    if (topThree != null) {
      data['top_three_ride'] =
          topThree.map((v) => v.toMap()).toList();
    }

    data['notifications'] = notification;
    return data;
  }
}
