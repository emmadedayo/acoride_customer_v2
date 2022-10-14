import 'dart:async';
import 'package:acoride/core/constant/enum.dart';
import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/data/entities/ridedb_entities.dart';
import 'package:acoride/data/repositories/google_web_service_repository.dart';
import 'package:acoride/data/repositories/ride_request_repository.dart';
import 'package:acoride/logic/states/map_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/helper/helper_config.dart';
import '../../data/repositories/object_box_repository.dart';


class MapCubit extends Cubit<MapState> {

  MapCubit(MapState initialState) : super(initialState) {
     initState();
  }

  GoogleWebService googleWebService = GoogleWebService();
  RideRequestRepository rideRequestRepository = RideRequestRepository();
  ObjectBoxRepository objectBoxRepository = ObjectBoxRepository();

  var googleGeocoding = GoogleGeocoding(HelperConfig.apiKey);

  initState() async {
    state.positionLoading = CustomState.LOADING;
    state.markers.clear();
    initLastKnownLocation();
    locationInit();
    state.amountLoading = true;
    emit(state.copy());
    getLocationLine(state.dataFrom[0]['lat'].toString(), state.dataFrom[0]['long'].toString(), state.dataTo[0]['lat'].toString(), state.dataTo[0]['long'].toString());
    if (await HelperConfig.determinePosition()) {
      state.position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      if (kDebugMode) {
        print("map cubit ${state.position}");
      }
      if (state.position != null) {
        state.mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(state.position?.latitude ?? 0.0, state.position?.longitude ?? 0.0),
              zoom: 17.0,
            ),
          ),
        );
        await customPin();
      }
    } else {

    }
    state.positionLoading = CustomState.DONE;
    emit(state.copy());
  }

  loadingAndWaitingForDriver() async {
    state.positionLoading = CustomState.LOADING;
    emit(state.copy());
    state.bottomSheetHeight = 0.4;
    state.bottomSheetHeight2 = 0.4;
    state.loadingView = false;
    state.loadingView2 = true;

    Future.delayed(const Duration(seconds: 10), () async {
      var result = await rideRequestRepository.getDriver(
          {
            "myLat":state.dataFrom[0]['lat'],
            "myLon":state.dataFrom[0]['long'],
            "ride_id":HelperConfig.uuid(),
            "driver_id":state.userRideRequest?.user?.id,
            "passenger_id": state.userModel?.id,
            "passenger_pickup_address":state.dataFrom[0]['name'],
            "passenger_pickup_latitude":state.dataFrom[0]['lat'],
            "passenger_pickup_longitude":state.dataFrom[0]['long'],
            "passenger_destination_address":state.dataTo[0]['name'],
            "passenger_destination_latitude":state.dataTo[0]['lat'],
            "passenger_destination_longitude":state.dataTo[0]['long'],
            "duration": state.googleDirectionModel?.routes?[0].legs?[0].duration?.value ?? 0,
            "distance":state.googleDirectionModel?.routes?[0].legs?[0].distance?.value ?? 0,
            "ride_type":"instant",
            "km":"983",
            "km_in_time":"8393",
            "payment_type":"wallet",
            "estimated_price":state.userRideRequest?.estimatedPrice,
            "on_going": "1",
            "base_fare_fee": "200"
          }
      );
      if (result.errorCode! >= 400) {
        state.positionLoading = CustomState.DONE;
        state.hasError = true;
        state.message = result.message;
        state.bottomSheetHeight = 0.47;
        state.bottomSheetHeight2 = 0.46;
        state.loadingView = true;
        state.loadingView2 = false;
      } else {
        state.hasError = false;
        state.message = result.message;
        state.rideRequestModel = result.result;
        objectBoxRepository.createRide(RideDetails(hasRide: true, rideId: result.result?.rideId ?? '', rideType: 'CREATE_RIDE'));
        state.positionLoading = CustomState.DONE;
      }
      emit(state.copy());
    });
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
      //  intervalDuration: const Duration(seconds: 10),
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

    state.dropOffMarker = Marker(
      markerId: MarkerId('drop_off_destination${UniqueKey()}'),
      position: LatLng(state.dataTo[0]['lat'] ?? 0.0 , state.dataTo[0]['long'] ?? 0.0),
      icon:state.dropOffLocationIcon!
    );

    state.pickupMarker = Marker(
      markerId: MarkerId('pick_up_location${UniqueKey()}'),
      position: LatLng(state.dataFrom[0]['lat'] ?? 0.0, state.dataFrom[0]['long'] ?? 0.0),
      icon:state.pickupLocationIcon!
    );

    double miny = (state.dataFrom[0]['lat'] <= state.dataTo[0]['lat']) ? state.dataFrom[0]['lat'] : state.dataTo[0]['lat'];
    double minx = (state.dataFrom[0]['long'] <= state.dataTo[0]['long']) ? state.dataFrom[0]['long'] : state.dataTo[0]['long'];

    double maxy = (state.dataFrom[0]['lat'] <= state.dataTo[0]['lat']) ? state.dataTo[0]['lat'] : state.dataFrom[0]['lat'];
    double maxx = (state.dataFrom[0]['long'] <= state.dataTo[0]['long']) ? state.dataTo[0]['long'] : state.dataFrom[0]['long'];

    double southWestLatitude = miny;
    double southWestLongitude = minx;

    double northEastLatitude = maxy;
    double northEastLongitude = maxx;

    state.mapController?.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          northeast: LatLng(northEastLatitude, northEastLongitude),
          southwest: LatLng(southWestLatitude, southWestLongitude),
        ),
        30.0,
      ),
    );
    if (state.position != null) {
      state.markers.add(state.pickupMarker!);
      state.markers.add(state.dropOffMarker!);
    }
  }

  getPositionName(lat,lng) async {
    if (lat != null && lng != null) {
      var result = await googleGeocoding.geocoding.getReverse(LatLon(lat,lng));
      state.pickUpAddress = result?.results![0].formattedAddress ?? 'Current Location';
      emit(state);
    }
  }


  getLocationLine(String userLatFrom , String userLongFrom, String userLatTo, String userLongTo) async {

    final String polylineIdVal = 'polyline_id_${HelperConfig.getTimeStampDividedByOneThousand(DateTime.now())}';
    final PolylineId polylineId = PolylineId(polylineIdVal);
    state.polyLines.clear();
    state.googleDirectionModel = await googleWebService.getTransaction(userLatFrom, userLongFrom, userLatTo, userLongTo).then((value){
      state.googleDirectionModel = value;
      return value;
    });
    state.distance = state.googleDirectionModel?.routes?[0].legs?[0].distance?.text ?? '';
    state.duration = state.googleDirectionModel?.routes?[0].legs?[0].duration?.text ?? '';
    debugPrint("=============================>>>>>>>>>> object distance ${state.distance}");
    debugPrint("=============================>>>>>>>>>> object duration ${state.duration}");
    await addMarker();
    await tripAmount();
    state.polyLines.add(Polyline(
      polylineId: polylineId,
      width: 3,
      geodesic: true,
      consumeTapEvents: true,
      color: HelperColor.black,
      jointType: JointType.round,
      points: HelperConfig.convertToLatLng(HelperConfig.decodePoly(state.googleDirectionModel?.routes?[0].overviewPolyline?.points ?? '')),
    ));
    emit(state.copy());
  }

  updatePayment(payment) {
    state.paymentType = payment;
    emit(state.copy());
  }

  tripAmount() async {
    var result = await rideRequestRepository.getTripAmount(
        {
          "myLat":state.dataTo[0]['lat'],
          "myLon":state.dataTo[0]['long'],
          "duration": state.googleDirectionModel?.routes?[0].legs?[0].duration?.value ?? 0,
          "distance":state.googleDirectionModel?.routes?[0].legs?[0].distance?.value ?? 0,
        }
    );
    if(result.errorCode! >= 400){
      state.amountLoading = true;
      state.amountLoadingResult = true;
      state.hasError = true;
      state.message = result.message;
    }else{
      state.amountLoading = false;
      state.amountLoadingResult = false;
      state.userRideRequest = result.result;
    }
    emit(state.copy());
  }

  customPin() async {
    state.markerIcon = await HelperConfig.getBytesFromAsset('assets/images/end_marker.png', 45);
    state.dropOffLocationIcon = BitmapDescriptor.fromBytes(state.markerIcon!);

    state.startMarkerIcon = await  HelperConfig.getBytesFromAsset('assets/images/start_marker.png', 45);
    state.pickupLocationIcon = BitmapDescriptor.fromBytes(state.startMarkerIcon!);
    emit(state.copy());
  }
}