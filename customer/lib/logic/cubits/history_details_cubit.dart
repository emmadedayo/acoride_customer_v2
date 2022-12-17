import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/constant/enum.dart';
import '../../core/helper/helper_color.dart';
import '../../core/helper/helper_config.dart';
import '../../data/repositories/google_web_service_repository.dart';
import '../../data/repositories/object_box_repository.dart';
import '../../data/repositories/ride_request_repository.dart';
import '../states/history_details_state.dart';


class HistoryDetailsCubit extends Cubit<HistoryDetailsState> {

  HistoryDetailsCubit(HistoryDetailsState initialState) : super(initialState) {
    initState();
  }

  GoogleWebService googleWebService = GoogleWebService();
  RideRequestRepository rideRequestRepository = RideRequestRepository();
  ObjectBoxRepository objectBoxRepository = ObjectBoxRepository();

  var googleGeocoding = GoogleGeocoding(HelperConfig.apiKey);

  initState() async {
    state.positionLoading = CustomState.LOADING;
    state.markers.clear();
    state.polyLines.clear();
    emit(state.copy());
    state.positionLoading = CustomState.DONE;
    emit(state.copy());
  }

}