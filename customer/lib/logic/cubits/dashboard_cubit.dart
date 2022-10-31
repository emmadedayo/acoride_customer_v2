import 'package:acoride/data/repositories/object_box_repository.dart';
import 'package:acoride/data/repositories/ride_request_repository.dart';
import 'package:acoride/logic/states/dashboard_state.dart';
import 'package:bloc/bloc.dart';
import 'package:google_geocoding/google_geocoding.dart';

import '../../core/helper/helper_config.dart';
import '../../data/repositories/user_repository.dart';

class DashBoardCubit extends Cubit<DashBoardState> {

  DashBoardCubit(DashBoardState initialState) : super(initialState) {
    getDashboard();
  }

  var googleGeocoding = GoogleGeocoding(HelperConfig.apiKey);
  RideRequestRepository rideRequestRepository = RideRequestRepository();
  UserRepository userRepository = UserRepository();
  ObjectBoxRepository objectBoxRepository = ObjectBoxRepository();


  getDashboard() async {
    state.userLoading = true;
    emit(state.copy());
    Future.delayed(const Duration(seconds: 10), () async {
      var result = await userRepository.getDashboard();
      if (result.errorCode != 400) {
        state.userModel = result.result?.user;
        state.dashBoardModel = result.result;
        state.transactions = result.result?.transactions ?? [];
        state.advert = result.result?.advertisements ?? [];
      }
      state.userLoading = false;
      emit(state.copy());
    });
  }

  // returnToRide() async {
  //   state.isLoading = true;
  //   emit(state.copy());
  //
  //   var result = await rideRequestRepository.getTrip(state.rideDetails?.rideId);
  //   if (result.errorCode! >= 400) {
  //     state.isLoading = false;
  //   } else {
  //     state.rideRequestModel = result.result;
  //     state.isLoading = false;
  //   }
  //   state.isLoading = false;
  //   emit(state.copy());
  // }
}