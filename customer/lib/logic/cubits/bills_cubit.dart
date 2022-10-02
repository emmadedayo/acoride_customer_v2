import 'dart:async';

import 'package:acoride/data/model/bill_model.dart';
import 'package:acoride/data/repositories/transaction_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/bill_repository.dart';
import '../states/bills_state.dart';


class BillsCubit extends Cubit<BillState> {

  BillRepository repository = BillRepository();
  TransactionRepository transactionRepository = TransactionRepository();

  BillsCubit(BillState initialState) : super(initialState) {
    initData();
  }

  Future initData() async {
    await initState();
    //
  }


  initState() async {
    state.isLoading = true;
    emit(state.copy());
    state.billModel = await repository.getBill(state.type ?? 'airtime');
    state.isLoading = false;
    emit(state.copy());
  }

  payBill() async {
    state.isLoadingCard = true;
    emit(state.copy());
    var result = await transactionRepository.buyBills({
      "amount":state.amount.text,
      "serviceID":state.selectedBill?.serviceID,
      "phone":state.phone.text, //The phone number of the customer
      "variation_code":state.selectedVariation?.variationCode,
      "billersCode":state.smartNumber.text,
    });
    if ((result?.errorCode ?? 0) >= 400) {
      state.isLoadingCard = false;
      state.hasError = true;
      state.message = result?.message;
    } else {
      state.hasError = false;
      state.message = result?.message;
      state.isLoadingCard = false;
    }
    emit(state.copy());
  }

  selectNetwork(BillModel billModel, int index) {
    state.selectedBill = billModel;
    state.selectedNetwork = index;
    emit(state.copy());
  }

  setDataPlan(value) {
    state.selectedVariation = value;
    state.planName.text = state.selectedVariation?.name ?? '';
    state.amount.text = state.selectedVariation?.variationAmount ?? '';
    emit(state.copy());
  }

  getSmartNumber() async {
    state.isLoadingCard = true;
    emit(state.copy());
    var result = await repository.getSmartName({
      "serviceID":state.selectedBill?.serviceID,
      "billersCode": state.smartNumber.text,
    });
    if ((result?.errorCode ?? 0) >= 400) {
      state.isLoadingCard = true;
      state.hasSmartCardError = true;
      state.message = result?.message;
    } else {
      state.hasSmartCardError = false;
      state.smartCardName = result?.message ?? '';
      state.isLoadingCard = false;
    }
    state.isLoadingCard = false;
    emit(state.copy());
  }

  electricityPlan(value) {
    state.selectedVariation = value;
    state.meterType.text = state.selectedVariation?.name ?? '';
    emit(state.copy());
  }

  electricitySelectedPlan(BillModel billModel) {
    state.selectedBill = billModel;
    state.planName.text = state.selectedBill?.name ?? '';
    emit(state.copy());
  }

  getElectricityName() async {
    state.isLoadingCard = true;
    emit(state.copy());
    var result = await repository.getSmartName({
      "serviceID":state.selectedBill?.serviceID,
      "billersCode": state.smartNumber.text,
      "variation_type":state.meterType.text,
    });
    if ((result?.errorCode ?? 0) >= 400) {
      state.isLoadingCard = true;
      state.hasSmartCardError = true;
      state.message = result?.message;
    } else {
      state.hasSmartCardError = false;
      state.smartCardName = result?.message ?? '';
      state.isLoadingCard = false;
    }
    state.isLoadingCard = false;
    emit(state.copy());
  }

}