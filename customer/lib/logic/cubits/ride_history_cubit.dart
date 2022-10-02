import 'dart:async';

import 'package:acoride/data/repositories/ride_request_repository.dart';
import 'package:acoride/data/repositories/user_repository.dart';
import 'package:acoride/logic/states/ride_history_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RideHistoryCubit extends Cubit<RideHistoryState> {

  UserRepository repository = UserRepository();
  RideRequestRepository rideRequestRepository = RideRequestRepository();

  RideHistoryCubit(RideHistoryState initialState) : super(initialState) {
    initData();
  }

  Future initData() async {
    await initState();
    //
  }

  initState() async {
    state.isLoading = true;
    emit(state.copy());
    state.history = await rideRequestRepository.getRideHistory();
    state.isLoading = false;
    emit(state.copy());
  }

  void startDate(DateTime value) {
    state.dateFrom = '${value.day}/${value.month}/${value.year}';
    emit(state.copy());
  }

  void endDate(DateTime value) {
    state.dateTo = '${value.day}/${value.month}/${value.year}';
    emit(state.copy());
  }
}