import 'package:acoride/core/constant/constants.dart';
import 'package:acoride/core/constant/enum.dart';
import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/data/entities/firebase_ride_model.dart';
import 'package:acoride/data/model/location_model.dart';
import 'package:acoride/data/repositories/google_web_service_repository.dart';
import 'package:acoride/data/repositories/object_box_repository.dart';
import 'package:acoride/data/repositories/ride_request_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/helper/helper_config.dart';
import '../states/ride_request_state.dart';


class RideRequestCubit extends Cubit<RideRequestState> {

  RideRequestCubit(RideRequestState initialState) : super(initialState) {
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
    emit(state.copy());
    locationInit();
    if (await HelperConfig.determinePosition()) {
      state.position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      if (kDebugMode) {
        print("object ${state.position}");
      }
      if (state.position != null) {
        await driverMarker();
        getUsers();
        getLocationLine(
          state.position?.latitude.toString() ?? '',
          state.position?.longitude.toString() ?? '',
          state.rideRequestModel?.passengerDestinationLatitude.toString() ?? "",
          state.rideRequestModel?.passengerDestinationLongitude.toString() ?? "",
        );
        state.mapController?.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(state.position?.latitude ?? 0.0, state.position?.longitude ?? 0.0),
              zoom: 17.0,
            ),
          ),
        );
        getDriverLocation();
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
    state.dropOffMarker = Marker(
      markerId: MarkerId('drop_off_destination${UniqueKey()}'),
      position: LatLng(state.rideRequestModel?.passengerDestinationLatitude ?? 0.0 , state.rideRequestModel?.passengerDestinationLongitude ?? 0.0),
      icon:state.dropOffLocationIcon!,
    );

    state.pickupMarker = Marker(
        markerId: MarkerId('pick_up_location${UniqueKey()}'),
        position: LatLng(state.rideRequestModel?.passengerPickupLatitude ?? 0.0, state.rideRequestModel?.passengerPickupLongitude ?? 0.0),
      icon:state.pickupLocationIcon!,
    );

    if (state.position != null) {
      state.markers.add(state.pickupMarker!);
      state.markers.add(state.dropOffMarker!);
    }
    emit(state.copy());
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
    emit(state.copy());
  }

  getStartRideLocation(userLatFrom, userLongFrom, userLatTo, userLongTo) async {
    state.googleDirectionModelTwo = await googleWebService.getTransaction(userLatFrom, userLongFrom, userLatTo, userLongTo).then((value){
      state.googleDirectionModelTwo = value;
      addMarker();
      return value;
    });
    state.distance = state.googleDirectionModelTwo?.routes?[0].legs?[0].distance?.text ?? '';
    state.duration = state.googleDirectionModelTwo?.routes?[0].legs?[0].duration?.text ?? '';
    debugPrint("=============================>>>>>>>>>> object in real time distance ${state.distance}");
    debugPrint("=============================>>>>>>>>>> object in real time duration ${state.duration}");
  }

   getUsers(){
     state.userStream = FirebaseFirestore.instance.collection(HelperConfig.getFirebaseEnvironment()).doc(state.rideRequestModel?.driverId.toString()).snapshots()
         .listen((DocumentSnapshot documentSnapshot) {
       state.fireStoreModel = FireStoreModel.fromJson(documentSnapshot.data()!);
       emit(state.copy());
     });

  }

  getDriverLocation(){
    state.rideRequestStream = FirebaseFirestore.instance.collection(HelperConfig.getFirebaseRealTimeEnvironment()).doc(state.rideRequestModel?.rideId.toString()).snapshots()
        .listen((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        state.fireStoreLocationModel = FireStoreLocationModel.fromJson(documentSnapshot.data()!);
        state.streamLatLng = LatLng(state.fireStoreLocationModel?.suppliedLatitude ?? 0.0, state.fireStoreLocationModel?.suppliedLongitude ?? 0.0);
        CameraPosition cPosition = CameraPosition(
          zoom: CAMERA_ZOOM,
          tilt: CAMERA_TILT,
          bearing: 180,
          target: state.streamLatLng!,
        );

        state.markers.removeWhere((m) => m.markerId.value == 'driverPin');
        state.markers.add(Marker(
          markerId: const MarkerId('driverPin'),
          position: state.streamLatLng!,
          icon: state.driverMarkerIcon!,
        ));

        Future.delayed(const Duration(milliseconds: 200), () async {
          state.mapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              cPosition,
            ),
          );
        });
        // if(state.fireStoreModel?.confirmTrip == false && state.fireStoreModel?.sendTrip == true){
        //   getStartRideLocation(state.fireStoreLocationModel?.suppliedLatitude.toString(),
        //       state.fireStoreLocationModel?.suppliedLongitude.toString(),
        //       state.rideRequestModel?.passengerPickupLatitude.toString(),
        //       state.rideRequestModel?.passengerPickupLongitude.toString()
        //   );
        // }else if(state.fireStoreModel?.confirmTrip == true && state.fireStoreModel?.sendTrip == false){
        //   getStartRideLocation(state.fireStoreLocationModel?.suppliedLatitude.toString(),
        //       state.fireStoreLocationModel?.suppliedLongitude.toString(),
        //       state.rideRequestModel?.passengerPickupLatitude.toString(),
        //       state.rideRequestModel?.passengerPickupLongitude.toString()
        //   );
        // }else if(state.fireStoreModel?.startTrip == true && state.fireStoreModel?.endTrip == false){
        //   getStartRideLocation(state.fireStoreLocationModel?.suppliedLatitude.toString(),
        //       state.fireStoreLocationModel?.suppliedLongitude.toString(),
        //       state.rideRequestModel?.passengerDestinationLatitude.toString(),
        //       state.rideRequestModel?.passengerDestinationLongitude.toString()
        //   );
        // }
      }
     // emit(state.copy());
    });
  }

  driverMarker() async {
    state.markerIcon = await  HelperConfig.getBytesFromAsset('assets/images/motorcycle.png', 45);
    state.driverMarkerIcon = BitmapDescriptor.fromBytes(state.markerIcon!);

    state.startMarkerIcon = await  HelperConfig.getBytesFromAsset('assets/images/start_marker.png', 45);
    state.pickupLocationIcon = BitmapDescriptor.fromBytes(state.startMarkerIcon!);

    state.dropOffMarkerIcon = await  HelperConfig.getBytesFromAsset('assets/images/end_marker.png', 45);
    state.dropOffLocationIcon = BitmapDescriptor.fromBytes(state.dropOffMarkerIcon!);

    emit(state.copy());
  }

  @override
  Future<void> close() async {
    //cancel streams
    state.rideRequestStream?.cancel();
    state.userStream?.cancel();
    return super.close();
  }

  panicAlert() async {
   // state.isLoadingCard = true;
    emit(state.copy());
    var result = await rideRequestRepository.emergencyAlert({
      "driver_id":state.rideRequestModel?.user?.userID,
      "passenger_id":state.rideRequestModel?.passengerId,
      "initiated_address": 'Unknown',
      "initiated_by":state.rideRequestModel?.passengerId,
      "ride_id":state.rideRequestModel?.rideId,
      "initiated_latitude":state.position?.latitude.toString(),
      "initiated_longitude":state.position?.longitude.toString(),
    });
    if ((result.errorCode ?? 0) >= 400) {
      //state.isLoadingCard = false;
      state.hasError = true;
      state.message = result.message;
    } else {
      state.hasError = false;
      state.message = result.message;
    //  state.isLoadingCard = false;
    }
    emit(state.copy());
  }
}