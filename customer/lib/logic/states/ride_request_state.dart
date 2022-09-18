import 'dart:collection';
import 'package:acoride/data/entities/firebase_ride_model.dart';
import 'package:acoride/data/model/ride_request_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/constant/enum.dart';
import '../../data/model/user_ride_request.dart';
import '../../map_component/google_direction_model.dart' as google_direction_model;

class RideRequestState {

  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  Position? position, lastKnownPositions;
  Marker? pickupMarker, dropOffMarker;
  Set<Marker> markers = HashSet();
  google_direction_model.GoogleDirectionModel? googleDirectionModel;
  Set<Polyline> polyLines = <Polyline>{};
  LatLng? sourceLatLng, destinationLatLng,currentLatLng;
  String distance = '', duration = '';
  CustomState positionLoading = CustomState.LOADING;
  LocationSettings locationSettings = const LocationSettings();
  bool initVisible = true, driverFoundVisible = false, noDriverFound = false, displayDriver = false, rideCancelled = false;
  RideRequestModel? rideRequestModel;
  FireStoreModel? fireStoreModel;

  RideRequestState({
    this.mapController, this.cameraPosition, this.position, this.lastKnownPositions,
    this.dropOffMarker, this.positionLoading: CustomState.LOADING, this.locationSettings: const LocationSettings(),
    this.sourceLatLng, this.destinationLatLng, this.currentLatLng,
    this.initVisible: true, this.driverFoundVisible: false, this.noDriverFound: false, this.displayDriver: false, this.rideCancelled: false, required this.rideRequestModel,
  });

  RideRequestState copy() {
    RideRequestState copy = RideRequestState(mapController: mapController, cameraPosition: cameraPosition, position: position, lastKnownPositions: lastKnownPositions,
        dropOffMarker: dropOffMarker, positionLoading: positionLoading, sourceLatLng: sourceLatLng, destinationLatLng: destinationLatLng,
        currentLatLng: currentLatLng, initVisible: initVisible, driverFoundVisible: driverFoundVisible, noDriverFound: noDriverFound,
        displayDriver: displayDriver, rideCancelled: rideCancelled, rideRequestModel: rideRequestModel);

    copy.polyLines.addAll(polyLines);
    copy.distance = distance;
    copy.duration = duration;
    copy.pickupMarker = pickupMarker;
    copy.dropOffMarker = dropOffMarker;
    copy.markers = markers;
    copy.googleDirectionModel = googleDirectionModel;
    copy.locationSettings = locationSettings;
    copy.fireStoreModel = fireStoreModel;
    return copy;
  }
}