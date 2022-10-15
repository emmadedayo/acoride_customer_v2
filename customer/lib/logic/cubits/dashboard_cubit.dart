import 'package:acoride/core/constant/enum.dart';
import 'package:acoride/data/repositories/object_box_repository.dart';
import 'package:acoride/data/repositories/ride_request_repository.dart';
import 'package:acoride/logic/states/dashboard_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/helper/helper_config.dart';

class DashBoardCubit extends Cubit<DashBoardState> {

  DashBoardCubit(DashBoardState initialState) : super(initialState) {
    initState();
  }

  var googleGeocoding = GoogleGeocoding(HelperConfig.apiKey);
  RideRequestRepository rideRequestRepository = RideRequestRepository();
  ObjectBoxRepository objectBoxRepository = ObjectBoxRepository();

  initState() async {
    state.positionLoading = CustomState.LOADING;
    state.markers.clear();
    locationInit();
    initLastKnownLocation();
    emit(state.copy());
    if (await HelperConfig.determinePosition()) {
      state.position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      if (kDebugMode) {
        print("object ${state.position}");
      }
      if (state.position != null) {
        var result = await googleGeocoding.geocoding.getReverse(LatLon(state.position?.latitude ?? 0.0, state.position?.longitude ?? 0.0));
        state.mapController?.animateCamera(
          CameraUpdate?.newCameraPosition(
            CameraPosition(
              target: LatLng(state.position?.latitude ?? 0.0, state.position?.longitude ?? 0.0),
              zoom: 17.0,
            ),
          ),
        );
        state.cameraPosition = CameraPosition(
          target: LatLng(state.position?.latitude ?? 0.0, state.position?.longitude ?? 0.0),
          zoom: 17.0,
        );
        addMarker();
        state.currentAddress = result?.results![0].formattedAddress ?? '';
      }
    }
    state.positionLoading = CustomState.DONE;
    emit(state.copy());
  }

  Future<void> initLastKnownLocation() async {
    Position? position;
    try {
      position = (await Geolocator.getLastKnownPosition(forceAndroidLocationManager: false));
    } on PlatformException {
      position = null;
    }
    state.lastKnownPositions = position;
    emit(state.copy());
  }

  returnToRide() async {
    state.isLoading = true;
    emit(state.copy());

    var result = await rideRequestRepository.getTrip(state.rideDetails?.rideId);
    if (result.errorCode! >= 400) {
      state.isLoading = false;
    } else {
      state.rideRequestModel = result.result;
      state.isLoading = false;
    }
    state.isLoading = false;
    emit(state.copy());
  }

  locationInit(){
    if (defaultTargetPlatform == TargetPlatform.android) {
      state.locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1,
        forceLocationManager: false,
        intervalDuration: const Duration(seconds: 10),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS || defaultTargetPlatform == TargetPlatform.macOS) {
      state.locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        activityType: ActivityType.fitness,
        distanceFilter: 1,
        pauseLocationUpdatesAutomatically: false,
        // Only set to true if our app will be started up in the background.
        showBackgroundLocationIndicator: false,
      );
    } else {
      state.locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 1,
      );
    }
    emit(state.copy());
  }

  void onMapCreated(GoogleMapController mapController) {
    state.mapController = mapController;
    emit(state.copy());
  }

  onCameraMove(CameraPosition position) {
    state.cameraPosition = position;
    emit(state.copy());
  }

  addMarker() async {
    Future.delayed(const Duration(milliseconds: 200), () async {
      state.mapController?.animateCamera(
        CameraUpdate?.newCameraPosition(
          CameraPosition(
            target: LatLng(state.position?.latitude ?? 0.0, state.position?.longitude ?? 0.0),
            zoom: 17.0,
          ),
        ),
      );
    });
  }

  getPositionName(lat,lng) async {
    if (lat != null && lng != null) {
      var result = await googleGeocoding.geocoding.getReverse(LatLon(lat,lng));
      state.currentAddress = result?.results![0].formattedAddress ?? 'Current Location';
      emit(state);
    }
  }
}