import 'package:acoride/data/model/bill_model.dart';
import 'package:acoride/data/model/variation_model.dart';
import 'package:flutter/material.dart';

class BillState{
  String? message,smartCardName;
  String? type;
  bool isLoading,isLoadingCard;
  bool? hasError,hasSmartCardError;
  TextEditingController amount = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController smartNumber = TextEditingController();
  TextEditingController planName = TextEditingController();
  TextEditingController meterType = TextEditingController();

  List<BillModel> billModel;
  List<VariationModel> variationModel;

  VariationModel? selectedVariation;
  BillModel? selectedBill;
  int? selectedNetwork;


  BillState({this.selectedNetwork,this.hasSmartCardError,required this.type,this.hasError,this.isLoading = false,this.isLoadingCard = false,this.billModel = const [],this.message,this.selectedBill,this.variationModel = const [],this.selectedVariation});

  BillState copy() {
    BillState copy = BillState(
      isLoading: isLoading,
      type: type,
      isLoadingCard: isLoadingCard,
      hasSmartCardError: hasSmartCardError,
      hasError: hasError,
      message: message,
      billModel: billModel,
      selectedBill: selectedBill,
      variationModel: variationModel,
      selectedNetwork: selectedNetwork,
      selectedVariation: selectedVariation,
    );

    copy.amount = amount;
    copy.smartCardName = smartCardName;
    copy.phone = phone;
    copy.smartNumber = smartNumber;
    copy.meterType = meterType;
    copy.planName = planName;
    copy.message = message;
    return copy;
  }
}