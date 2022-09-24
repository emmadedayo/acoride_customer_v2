import 'dart:async';

import 'package:acoride/data/model/cancellation_model.dart';
import 'package:acoride/data/repositories/cancellation_repository.dart';
import 'package:acoride/data/repositories/ride_request_repository.dart';
import 'package:acoride/data/repositories/transaction_repository.dart';
import 'package:acoride/data/repositories/user_repository.dart';
import 'package:acoride/logic/states/cancellation_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CancellationCubit extends Cubit<CancellationState> {

  UserRepository repository = UserRepository();
  TransactionRepository transactionRepository = TransactionRepository();
  CancellationRepository cancellationRepository = CancellationRepository();
  RideRequestRepository rideRequestRepository = RideRequestRepository();

  CancellationCubit(CancellationState initialState) : super(initialState) {
    initData();
  }

  Future initData() async {
    await initState();
  }


  initState() async {
    state.isLoading = true;
    emit(state.copy());
    state.data = await cancellationRepository.get();
    state.isLoading = false;
    emit(state.copy());
  }

  selectedCancellation(selectedValue, CancellationModel dataModel) async {
    state.cancellationModel = dataModel;
    state.selectedReason = selectedValue;
    emit(state.copy());
  }

  cancelTrip() async {
    state.isLoading = true;
    emit(state.copy());
    if(state.cancellationModel != null) {
      var result = await rideRequestRepository.cancelTrip(
          {
            "driver_id": state.rideRequestModel?.driverId,
            "passenger_id": state.rideRequestModel?.passengerId,
            "ride_id": state.rideRequestModel?.rideId,
            "cancellation_policy_id": state.cancellationModel?.id,
            "amount_to_debit": "0",
            "should_deduct": "no",
            "cancelled_by": state.rideRequestModel?.passengerId,
            "end_ride_location_latitude": state.position?.latitude,
            "end_ride_location_longitude": state.position?.longitude,
          }
      );
      if (result.errorCode! > 400) {
        state.isLoading = false;
        state.message = result.message;
      } else {
        state.message = result.message;
        state.isLoading = false;
      }
    }else{
      state.message = "Please select a reason";
    }
    emit(state.copy());
  }
}