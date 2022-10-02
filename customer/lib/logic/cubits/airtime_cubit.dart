import 'dart:async';

import 'package:acoride/data/model/bill_model.dart';
import 'package:acoride/data/repositories/transaction_repository.dart';
import 'package:acoride/logic/states/airtime_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/bill_repository.dart';

class AirtimeCubit extends Cubit<AirtimeState> {

  BillRepository repository = BillRepository();
  TransactionRepository transactionRepository = TransactionRepository();

  AirtimeCubit(AirtimeState initialState) : super(initialState) {
    initData();
  }

  Future initData() async {
    await initState();
    //
  }


  initState() async {
    state.isLoading = true;
    emit(state.copy());
    state.billModel = await repository.getBill('airtime');
    state.isLoading = false;
    emit(state.copy());
  }

  payBill() async {
    state.isLoadingCard = true;
    emit(state.copy());
    var result = await transactionRepository.buyBills({
      "amount":state.amount.text,
      "serviceID":state.selectedBill?.serviceID,
      "phone":state.phone.text
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

  selectNetwork(BillModel billModel,int index) {
    state.selectedBill = billModel;
    state.selectedNetwork = index;
    emit(state.copy());
  }

  buyAirtime() {

  }
}