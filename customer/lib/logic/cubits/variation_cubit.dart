import 'dart:async';

import 'package:acoride/data/repositories/transaction_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/bill_repository.dart';
import '../states/variation_state.dart';


class VariationCubit extends Cubit<VariationState> {

  BillRepository repository = BillRepository();
  TransactionRepository transactionRepository = TransactionRepository();

  VariationCubit(VariationState initialState) : super(initialState) {
    initData();
  }

  Future initData() async {
    await initState();
    //
  }
  
  initState() async {
    state.isLoading = true;
    emit(state.copy());
    state.variationModel = await repository.getVariation(state.message);
    state.isLoading = false;
    emit(state.copy());
  }

  filterName(String name){
    state.name = name;
    emit(state.copy());
    filterBank();
  }

  filterBank() {
    if(state.name.isNotEmpty && state.name.length > 2) {
      state.variationSearch = [];
      state.variationModel.addAll(state.variationModel);
      state.variationModel.removeWhere((element) => !element.name!.toLowerCase().contains(state.name.toLowerCase()));
    }else{
      state.variationModel = [];
      state.variationModel.addAll(state.variationModel);
    }
    emit(state.copy());
  }
}