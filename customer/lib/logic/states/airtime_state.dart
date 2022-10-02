import 'package:acoride/data/model/bill_model.dart';
import 'package:flutter/material.dart';


class AirtimeState{
  String? message;
  bool isLoading,isLoadingCard;
  bool? hasError;
  TextEditingController amount = TextEditingController();
  TextEditingController phone = TextEditingController();
  List<BillModel> billModel;
  BillModel? selectedBill;
  int? selectedNetwork;


  AirtimeState({this.selectedNetwork,this.hasError,this.isLoading = false, this.isLoadingCard = false,this.billModel = const [],this.message,this.selectedBill});

  AirtimeState copy() {
    AirtimeState copy = AirtimeState(
      isLoading: isLoading,
      isLoadingCard: isLoadingCard,
      hasError: hasError,
      message: message,
      billModel: billModel,
      selectedNetwork: selectedNetwork,
      selectedBill: selectedBill,
    );
    copy.amount = amount;
    copy.phone = phone;
    copy.message = message;
    return copy;
  }
}