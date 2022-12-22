import 'package:acoride/core/constant/enum.dart';
import 'package:acoride/data/repositories/google_web_service_repository.dart';
import 'package:acoride/data/repositories/ride_request_repository.dart';
import 'package:acoride/logic/states/rate_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/helper/helper_config.dart';
import '../../map_component/place_to_marker.dart';


class RateCubit extends Cubit<RateState> {

  RateCubit(RateState initialState) : super(initialState) {
    initState();
  }

  GoogleWebService googleWebService = GoogleWebService();
  RideRequestRepository rideRequestRepository = RideRequestRepository();
  var googleGeocoding = GoogleGeocoding(HelperConfig.apiKey);

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
    } else {

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


  addMarker() async {
    final pickUpIcons = await placeToMarker(state.rideRequestModel?.passengerPickupAddress ?? '', 0);
    final destinationIcon = await placeToMarker(state.rideRequestModel?.passengerDestinationAddress ?? '', 0);

    state.dropOffMarker = Marker(
      markerId: MarkerId('drop_off_destination${UniqueKey()}'),
      position: LatLng(state.rideRequestModel?.passengerDestinationLatitude ?? 0.0 , state.rideRequestModel?.passengerDestinationLongitude ?? 0.0),
      icon:destinationIcon,
    );

    state.pickupMarker = Marker(
        markerId: MarkerId('pick_up_location${UniqueKey()}'),
        position: LatLng(state.rideRequestModel?.passengerPickupLatitude ?? 0.0, state.rideRequestModel?.passengerPickupLongitude ?? 0.0),
        icon:pickUpIcons
    );

    if (state.position != null) {
      state.markers.add(state.pickupMarker!);
      state.markers.add(state.dropOffMarker!);
    }
    emit(state.copy());
  }

  deliveryRate() async {
    state.isLoading = true;
    emit(state.copy());
    var result = await rideRequestRepository.deliveryRate(
        {
          "driver_id": state.rideRequestModel?.driverId,
          "user_id": state.rideRequestModel?.passengerId,
          "rate": state.rating,
          "ride_id": state.rideRequestModel?.rideId,
          "comment": state.commentController?.text,
        }
    );
    if (result.errorCode! > 400) {
      state.isLoading = false;
      state.hasError = true;
      state.message = result.message;
    } else {
      state.hasError = false;
      state.message = result.message;
      state.isLoading = false;
    }
    emit(state.copy());
  }

  rate() async {
    state.isLoading = true;
    emit(state.copy());
    var result = await rideRequestRepository.rate(
        {
          "driver_id": state.rideRequestModel?.driverId,
          "user_id": state.rideRequestModel?.passengerId,
          "rate": state.rating,
          "ride_id": state.rideRequestModel?.rideId,
          "comment": state.commentController?.text,
        }
    );
    if (result.errorCode! > 400) {
      state.isLoading = false;
      state.hasError = false;
      state.message = result.message;
    } else {
      state.hasError = true;
      state.rideRequestModel = result.result;
      state.message = result.message;
      state.isLoading = false;
    }
    emit(state.copy());
  }

  void selectRating(double v) {
    state.rating = v;
    emit(state.copy());
  }
}