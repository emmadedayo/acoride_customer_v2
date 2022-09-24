import 'dart:collection';

import 'package:acoride/data/model/ride_request_model.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/constant/enum.dart';

class RateState {

  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  Position? position, lastKnownPositions;
  Marker? pickupMarker, dropOffMarker;
  Set<Marker> markers = HashSet();
  Set<Polyline> polyLines = <Polyline>{};
  LatLng? sourceLatLng, destinationLatLng,currentLatLng;
  String distance = '', duration = '';
  CustomState positionLoading = CustomState.LOADING;
  LocationSettings locationSettings = const LocationSettings();

  RideRequestModel? rideRequestModel;

  bool isLoading;
  String? message;
  bool? hasError;

  double? rating;

  TextEditingController? commentController = TextEditingController();
  

  RateState({
    this.isLoading = false,
    this.hasError = false,
    this.rating = 4.5,
    this.mapController, this.cameraPosition, this.position, this.lastKnownPositions,
    this.dropOffMarker, this.positionLoading: CustomState.LOADING, this.locationSettings: const LocationSettings(),
    this.sourceLatLng, this.destinationLatLng, this.currentLatLng,
    this.rideRequestModel,
  });

  RateState copy() {
    RateState copy = RateState(mapController: mapController, cameraPosition: cameraPosition, position: position, lastKnownPositions: lastKnownPositions,
        dropOffMarker: dropOffMarker, positionLoading: positionLoading, sourceLatLng: sourceLatLng, destinationLatLng: destinationLatLng,
        currentLatLng: currentLatLng, rideRequestModel: rideRequestModel, isLoading: isLoading,
        rating: rating,hasError: hasError);

    copy.polyLines.addAll(polyLines);
    copy.distance = distance;
    copy.duration = duration;
    copy.pickupMarker = pickupMarker;
    copy.commentController = commentController;
    copy.dropOffMarker = dropOffMarker;
    copy.message = message;
    copy.markers = markers;
    copy.locationSettings = locationSettings;
    return copy;
  }
}