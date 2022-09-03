import 'package:acoride/data/Entities/paystack_top_up_form.dart';
import 'package:acoride/data/model/TransactionModel.dart';
import '../../core/constant/enum.dart';
import '../../data/entities/card_top_up.dart';

class TransactionState{
  String? userToken;
  CustomState customState;
  bool isLoading;
  PayStackTopUpForm? payStackTopUpForm;
  CardTopUp? cardTopUpForm;
  List<TransactionModel> transactions = [];

  TransactionState({this.isLoading = false, this.userToken,this.customState: CustomState.LOADING,this.payStackTopUpForm,this.cardTopUpForm});

  TransactionState copy() {
    TransactionState copy = TransactionState(
        isLoading: isLoading,
        userToken: userToken, customState: customState,
        payStackTopUpForm: payStackTopUpForm,
        cardTopUpForm: cardTopUpForm
    );
    copy.transactions = transactions;
    return copy;
  }
}