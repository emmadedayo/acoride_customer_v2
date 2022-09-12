
import 'package:acoride/core/constant/enum.dart';
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

  AppState({this.user, this.customState: CustomState.LOADING, this.userInitialized: false, this.token});

  AppState copy() {
    AppState copy = AppState(user: user, customState: customState, userInitialized: userInitialized, token: token);
    copy.transactions = transactions;
    copy.cards = cards;
    return copy;
  }

}