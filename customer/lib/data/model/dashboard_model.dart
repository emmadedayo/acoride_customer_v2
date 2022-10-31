import 'package:acoride/data/model/TransactionModel.dart';

import 'UserModel.dart';
import 'advert_model.dart';

class DashBoardModel {
  UserModel? user;
  List<AdvertModel>? advertisements;
  List<TransactionModel>? transactions;
  int? notification;

  DashBoardModel({this.user, this.advertisements, this.notification, this.transactions});

  DashBoardModel.fromMap(json) {
    user = json['user'] != null ? UserModel.fromMap(json['user']) : null;
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
    notification = json['notification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    data['notifications'] = notification;
    return data;
  }
}
