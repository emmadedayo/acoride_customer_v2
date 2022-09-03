import 'dart:async';
import 'package:acoride/core/constant/enum.dart';
import 'package:acoride/data/repositories/transaction_repository.dart';
import 'package:acoride/data/repositories/user_repository.dart';
import 'package:acoride/logic/states/transaction_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionCubit extends Cubit<TransactionState> {

  UserRepository repository = UserRepository();
  TransactionRepository transactionRepository = TransactionRepository();

  TransactionCubit(TransactionState initialState) : super(initialState) {
    initData();
  }

  Future initData() async {
    await initState();
    //
  }


  initState() async {
    state.customState = CustomState.LOADING;
    emit(state.copy());

    state.transactions = await transactionRepository.getTransaction('${state.userToken}');
    // AppTest.run();
    // debugPrint('==${state.user?.toMap(showId: true)}');

    state.customState = CustomState.DONE;
    emit(state.copy());
  }



}