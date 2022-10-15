
import 'package:acoride/core/constant/enum.dart';
import 'package:acoride/data/entities/ridedb_entities.dart';
import 'package:acoride/data/model/TransactionModel.dart';
import 'package:acoride/data/model/UserModel.dart';

import '../../data/model/UserCard.dart';
import '../../data/model/notification_item.dart';

class AppState {

  UserModel? user;
  String? token;
  List<TransactionModel> transactions = [];
  List<UserCard> cards = [];
  CustomState customState;
  bool userInitialized;
  RideDetails? rideDetails;
  NotificationItem? notification;

  AppState({this.user, this.customState: CustomState.LOADING, this.userInitialized: false, this.token,this.rideDetails,this.notification});

  AppState copy() {
    AppState copy = AppState(user: user, customState: customState, userInitialized: userInitialized, token: token,rideDetails: rideDetails,notification: notification);
    copy.transactions = transactions;
    copy.cards = cards;
    return copy;
  }

}