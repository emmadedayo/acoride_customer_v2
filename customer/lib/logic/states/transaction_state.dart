import 'package:acoride/data/Entities/paystack_top_up_form.dart';
import 'package:acoride/data/model/TransactionModel.dart';
import 'package:acoride/data/model/UserModel.dart';
import 'package:flutter/material.dart';
import '../../core/constant/enum.dart';
import '../../data/entities/card_top_up.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

import '../../data/model/UserCard.dart';

class TransactionState{
  UserModel? userModel;
  String? message;
  bool isLoading,isLoadingCard;
  PayStackTopUpForm? payStackTopUpForm;
  CardTopUp? cardTopUpForm;
  TextEditingController amount = TextEditingController();
  List<TransactionModel> transactions = [];
  List<UserCard> userCard = [];
  CheckoutResponse? response;
  UserCard selectedCard = UserCard();

  TransactionState({this.isLoading = false, this.isLoadingCard = false,this.userModel,this.payStackTopUpForm,this.cardTopUpForm});

  TransactionState copy() {
    TransactionState copy = TransactionState(
        isLoading: isLoading,
        userModel: userModel,
        isLoadingCard: isLoadingCard,
        payStackTopUpForm: payStackTopUpForm,
        cardTopUpForm: cardTopUpForm,

    );
    copy.response = response;
    copy.transactions = transactions;
    copy.amount = amount;
    copy.message = message;
    copy.userCard = userCard;
    copy.selectedCard = selectedCard;
    return copy;
  }
}