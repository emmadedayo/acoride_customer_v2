import 'package:acoride/data/repositories/app_repository.dart';
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
    getAppSettings();
  }

  var googleGeocoding = GoogleGeocoding(HelperConfig.apiKey);
  RideRequestRepository rideRequestRepository = RideRequestRepository();
  UserRepository userRepository = UserRepository();
  ObjectBoxRepository objectBoxRepository = ObjectBoxRepository();
  AppRepository appRepository = AppRepository();


  getDashboard() async {
    state.userLoading = true;
    emit(state.copy());
    Future.delayed(const Duration(seconds: 10), () async {
      var result = await userRepository.getDashboard();
      if (result.errorCode != 400) {
        state.userModel = result.result?.user;
        state.dashBoardModel = result.result;
        state.rideRequestModel = result.result?.rideRequest;
        state.transactions = result.result?.transactions ?? [];
        state.advert = result.result?.advertisements ?? [];
        state.rideHistory = result.result?.topThree ?? [];
      }
      state.userLoading = false;
      emit(state.copy());
    });
  }

  getAppSettings() async {
    var result = await appRepository.getAppVersion();
    if(result.errorCode! == 200) {
      state.appSettings = result.result;
    }
    emit(state.copy());
  }

}