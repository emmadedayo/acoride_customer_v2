import 'package:acoride/data/model/UserCard.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class CardState{
  bool? hasError;
  bool isLoading;
  int? success;
  String? message;
  List<UserCard> userCard = [];
  CheckoutResponse? response;
  CardState({this.message, this.hasError,this.isLoading: true,});

  CardState copy() {
    CardState copy = CardState(message: message, hasError: hasError,isLoading: isLoading);
    copy.userCard = userCard;
    copy.response = response;
    copy.success = success;
    return copy;
  }
}