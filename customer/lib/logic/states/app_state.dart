
import 'package:acoride/core/constant/enum.dart';
import 'package:acoride/data/entities/ridedb_entities.dart';
import 'package:acoride/data/model/TransactionModel.dart';
import 'package:acoride/data/model/UserModel.dart';

import '../../data/model/UserCard.dart';

class AppState {

  UserModel? user;
  String? token;
  List<TransactionModel> transactions = [];
  List<UserCard> cards = [];
  CustomState customState;
  bool userInitialized;
  RideDetails? rideDetails;

  AppState({this.user, this.customState: CustomState.LOADING, this.userInitialized: false, this.token,this.rideDetails,});

  AppState copy() {
    AppState copy = AppState(user: user, customState: customState, userInitialized: userInitialized, token: token,rideDetails: rideDetails);
    copy.transactions = transactions;
    copy.cards = cards;
    return copy;
  }

}