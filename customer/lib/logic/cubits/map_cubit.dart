import 'package:acoride/core/constant/enum.dart';
import 'package:acoride/core/helper/helper_color.dart';
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


class MapCubit extends Cubit<MapState> {

  MapCubit(MapState initialState) : super(initialState) {
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
      getLocationLine(state.dataFrom[0]['lat'].toString(), state.dataFrom[0]['lng'].toString(), state.dataTo[0]['lat'].toString(), state.dataTo[0]['lng'].toString());
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
      }
    } else {

    }
    state.positionLoading = CustomState.DONE;
    emit(state.copy());
  }

  loadingAndWaitingForDriver() async {
    state.positionLoading = CustomState.LOADING;
    emit(state.copy());
    var result = await rideRequestRepository.getDriver(
        {
          "myLat":"7.3313237",
          "myLon":"3.8666836"
        }
    );
    if (result.errorCode! >= 400) {
      state.positionLoading = CustomState.DONE;
      state.initVisible = true;
    } else {
      state.initVisible = false;
      state.driverFoundVisible = true;
      state.userRideRequest = result.result;
      state.positionLoading = CustomState.DONE;
    }
    state.positionLoading = CustomState.DONE;
    emit(state.copy());
  }


  createTrip() async {
    state.positionLoading = CustomState.LOADING;
    emit(state.copy());
    var result = await rideRequestRepository.createTrip(
        {
          "ride_id":"2801cac9-6aa0-430a-a9ea-810dd3ed7772",
          "driver_id":state.userRideRequest?.user?.id,
          "passenger_id":"2",
          "passenger_pickup_address":state.dataFrom[0]['address'],
          "passenger_pickup_latitude":state.dataFrom[0]['lat'],
          "passenger_pickup_longitude":state.dataFrom[0]['lng'],
          "passenger_destination_address":state.dataTo[0]['address'],
          "passenger_destination_latitude":state.dataTo[0]['lat'],
          "passenger_destination_longitude":state.dataTo[0]['lng'],
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
      state.initVisible = true;
    } else {
      state.initVisible = false;
      state.driverFoundVisible = true;
      //state.userRideRequest = result.result;
      state.positionLoading = CustomState.DONE;
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

    state.dropOffMarker = Marker(
      markerId: MarkerId('drop_off_destination${UniqueKey()}'),
      position: LatLng(state.dataFrom[0]['lat'] ?? 0.0 , state.dataFrom[0]['lng'] ?? 0.0),
      icon:BitmapDescriptor.defaultMarker,
    );

    state.pickupMarker = Marker(
      markerId: MarkerId('pick_up_location${UniqueKey()}'),
      position: LatLng(state.dataTo[0]['lat'] ?? 0.0, state.dataTo[0]['lng'] ?? 0.0),
      icon:BitmapDescriptor.defaultMarker
    );

    double miny = (state.dataFrom[0]['lat'] <= state.dataTo[0]['lat']) ? state.dataFrom[0]['lat'] : state.dataTo[0]['lat'];
    double minx = (state.dataFrom[0]['long'] <= state.dataTo[0]['long']) ? state.dataFrom[0]['long'] : state.dataTo[0]['long'];
    double maxy = (state.dataFrom[0]['lat'] <= state.dataTo[0]['lat']) ? state.dataTo[0]['lat'] : state.dataFrom[0]['lat'];
    double maxx = (state.dataFrom[0]['long'] <= state.dataTo[0]['long']) ? state.dataTo[0]['long'] : state.dataFrom[0]['long'];

    double southWestLatitude = miny;
    double southWestLongitude = minx;

    double northEastLatitude = maxy;
    double northEastLongitude = maxx;

    Future.delayed(const Duration(milliseconds: 200), () async {
      state.mapController?.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          100.0,
        ),
      );
    });
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
      addMarker();
      return value;
    });
    state.distance = state.googleDirectionModel?.routes?[0].legs?[0].distance?.text ?? '';
    state.duration = state.googleDirectionModel?.routes?[0].legs?[0].duration?.text ?? '';
    debugPrint("=============================>>>>>>>>>> object distance ${state.distance}");
    debugPrint("=============================>>>>>>>>>> object duration ${state.duration}");
    state.polyLines.add(Polyline(
      polylineId: polylineId,
      width: 3,
      geodesic: true,
      consumeTapEvents: true,
      color: HelperColor.black,
      jointType: JointType.round,
      points: HelperConfig.convertToLatLng(HelperConfig.decodePoly(state.googleDirectionModel?.routes?[0].overviewPolyline?.points ?? '')),
    ));
  }
}