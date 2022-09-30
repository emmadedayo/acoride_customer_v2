import 'dart:async';

import 'package:acoride/data/repositories/card_repository.dart';
import 'package:acoride/data/repositories/transaction_repository.dart';
import 'package:acoride/data/repositories/user_repository.dart';
import 'package:acoride/logic/states/transaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionCubit extends Cubit<TransactionState> {

  UserRepository repository = UserRepository();
  TransactionRepository transactionRepository = TransactionRepository();
  CardRepository cardRepository = CardRepository();

  TransactionCubit(TransactionState initialState) : super(initialState) {
    initData();
  }

  Future initData() async {
    await initState();
    //
  }


  initState() async {
    state.isLoading = true;
    emit(state.copy());

    state.transactions = await transactionRepository.getTransaction();
    state.userModel = (await repository.getMe()).result;
    state.userCard = await cardRepository.getAll();
    // AppTest.run();
    // debugPrint('==${state.user?.toMap(showId: true)}');

    state.isLoading = false;
    emit(state.copy());
  }

  topFromCard() async {
    state.isLoadingCard = true;
    emit(state.copy());
    var result = await transactionRepository.topUpWithCard({
      'amount': state.amount.text,
      'card_id': state.selectedCard.id,
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

  topFromPayStack() async {
    state.isLoadingCard = true;
    emit(state.copy());
    var result = await transactionRepository.topUpWithPayStack({
      'amount': state.amount.text,
      'payment_ref': state.response?.reference,
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
    state.isLoadingCard = false;
    emit(state.copy());
  }
}