import 'dart:async';

import 'package:acoride/data/repositories/card_repository.dart';
import 'package:acoride/data/repositories/user_repository.dart';
import 'package:acoride/logic/states/card_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardCubit extends Cubit<CardState> {

  UserRepository repository = UserRepository();
  CardRepository cardRepository = CardRepository();

  CardCubit(CardState initialState) : super(initialState) {
    initData();
  }

  Future initData() async {
    await initState();
    //
  }


  initState() async {
    state.isLoading = true;
    emit(state.copy());

    state.userCard = await cardRepository.getAll();
    // AppTest.run();
    // debugPrint('==${state.user?.toMap(showId: true)}');

    state.isLoading = false;
    emit(state.copy());
  }

  addCard() async {
    state.isLoading = true;
    emit(state.copy());

    var result = await cardRepository.saveCard({
      'reference': state.response?.reference,
    });
    if (result?.errorCode == 400) {
      state.isLoading = false;
      state.message = result?.message;
    } else {
      state.success == 1;
      state.message = result?.message;
      initData();
      state.isLoading = false;
    }
    state.isLoading = false;
    emit(state.copy());
  }

  deleteCard(id) async {
    state.isLoading = true;
    emit(state.copy());

    var result = await cardRepository.deleteCard({
      'id': id,
    });
    if (result?.errorCode == 400) {
      state.isLoading = false;
      state.message = result?.message;
    } else {
      state.message = result?.message;
      state.isLoading = false;
      state.userCard.removeWhere((element) => element.id == id);
    }
    state.isLoading = false;
    emit(state.copy());
  }


}