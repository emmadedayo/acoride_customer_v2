import 'package:acoride/core/constant/enum.dart';
import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/data/entities/firebase_ride_model.dart';
import 'package:acoride/data/repositories/firebase_repository.dart';
import 'package:acoride/data/repositories/google_web_service_repository.dart';
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
  var googleGeocoding = GoogleGeocoding(HelperConfig.apiKey);

  initState() async {
    state.positionLoading = CustomState.LOADING;
    state.markers.clear();
    locationInit();
    initLastKnownLocation();
    await getUsers();
    emit(state.copy());
    if (await HelperConfig.determinePosition()) {
      getLocationLine(
          state.rideRequestModel?.passengerPickupLatitude.toString() ?? "",
          state.rideRequestModel?.passengerPickupLongitude.toString() ?? "",
          state.rideRequestModel?.passengerDestinationLatitude.toString() ?? "",
          state.rideRequestModel?.passengerDestinationLongitude.toString() ?? "",
      );
      state.position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      if (kDebugMode) {
        print("object ${state.position}");
      }
      if (state.position != null) {
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
      icon:BitmapDescriptor.defaultMarker,
    );

    state.pickupMarker = Marker(
        markerId: MarkerId('pick_up_location${UniqueKey()}'),
        position: LatLng(state.rideRequestModel?.passengerPickupLatitude ?? 0.0, state.rideRequestModel?.passengerPickupLongitude ?? 0.0),
        icon:BitmapDescriptor.defaultMarker
    );

    if (state.position != null) {
      state.markers.add(state.pickupMarker!);
      state.markers.add(state.dropOffMarker!);
    }
    emit(state.copy());
  }
  

  getLocationLine(String userLatFrom , String userLongFrom, String userLatTo, String userLongTo) async {
    emit(state.copy());
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

    Future.delayed(const Duration(milliseconds: 200), () async {
      state.mapController?.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(state.googleDirectionModel?.routes![0].bounds?.northeast?.lat ?? 0.0, state.googleDirectionModel?.routes![0].bounds?.northeast?.lng ?? 0.0),
            southwest: LatLng(state.googleDirectionModel?.routes![0].bounds?.southwest?.lat! ?? 0.0, state.googleDirectionModel?.routes![0].bounds?.southwest?.lng ?? 0.0),
          ),
          10,
        ),
      );
    });

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

   getUsers() async{

    final Stream<DocumentSnapshot> rideRequestStream = FirebaseFirestore.instance.collection('ride_request').doc('OG6839').snapshots();
    rideRequestStream.listen((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        state.fireStoreModel = FireStoreModel.fromJson(documentSnapshot.data()!);
        print("objectobject ${state.fireStoreModel?.driverID}");
        emit(state.copy());
      }
    });
  }
}