import 'dart:collection';

import 'package:acoride/data/entities/firebase_ride_model.dart';
import 'package:acoride/data/model/ride_request_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../../core/constant/enum.dart';
import '../../data/model/location_model.dart';
import '../../map_component/google_direction_model.dart' as google_direction_model;

class RideRequestState {

  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  Position? position, lastKnownPositions;
  Marker? pickupMarker, dropOffMarker;
  Set<Marker> markers = HashSet();
  google_direction_model.GoogleDirectionModel? googleDirectionModel;
  google_direction_model.GoogleDirectionModel? googleDirectionModelTwo;
  Set<Polyline> polyLines = <Polyline>{};
  LatLng? sourceLatLng, destinationLatLng,currentLatLng,streamLatLng;
  String distance = '', duration = '';
  CustomState positionLoading = CustomState.LOADING;
  LocationSettings locationSettings = const LocationSettings();
  bool initVisible = true, driverFoundVisible = false, noDriverFound = false, displayDriver = false, rideCancelled = false;

  RideRequestModel? rideRequestModel;
  FireStoreModel? fireStoreModel;

  FireStoreLocationModel? fireStoreLocationModel;

  bool isLoading;
  String? message;
  bool? hasError;

  Location? location = Location();


  RideRequestState({
    this.isLoading = false,
    this.hasError,
    this.location,
    this.mapController, this.cameraPosition, this.position, this.lastKnownPositions,
    this.dropOffMarker, this.positionLoading: CustomState.LOADING, this.locationSettings: const LocationSettings(),
    this.sourceLatLng, this.destinationLatLng, this.currentLatLng, this.streamLatLng,
    this.initVisible: true, this.driverFoundVisible: false, this.noDriverFound: false, this.displayDriver: false, this.rideCancelled: false,
    this.rideRequestModel,
  });

  RideRequestState copy() {
    RideRequestState copy = RideRequestState(mapController: mapController, cameraPosition: cameraPosition, position: position, lastKnownPositions: lastKnownPositions,
        dropOffMarker: dropOffMarker, positionLoading: positionLoading, sourceLatLng: sourceLatLng, destinationLatLng: destinationLatLng,
        currentLatLng: currentLatLng, initVisible: initVisible, driverFoundVisible: driverFoundVisible, noDriverFound: noDriverFound,
        displayDriver: displayDriver, rideCancelled: rideCancelled, rideRequestModel: rideRequestModel, isLoading: isLoading, hasError: hasError,streamLatLng:streamLatLng);

    copy.polyLines.addAll(polyLines);
    copy.distance = distance;
    copy.duration = duration;
    copy.pickupMarker = pickupMarker;
    copy.dropOffMarker = dropOffMarker;
    copy.message = message;
    copy.markers = markers;
    copy.googleDirectionModel = googleDirectionModel;
    copy.googleDirectionModelTwo = googleDirectionModelTwo;
    copy.locationSettings = locationSettings;
    copy.location = location;
    copy.fireStoreModel = fireStoreModel;
    copy.fireStoreLocationModel = fireStoreLocationModel;
    return copy;
  }
}