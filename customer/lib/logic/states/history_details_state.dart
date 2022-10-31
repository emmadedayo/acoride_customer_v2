import 'dart:collection';
import 'dart:typed_data';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/constant/enum.dart';
import '../../data/model/ride_request_model.dart';
import '../../map_component/google_direction_model.dart' as google_direction_model;

class HistoryDetailsState {

  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  Marker? pickupMarker, dropOffMarker;
  Set<Marker> markers = HashSet();
  Set<Polyline> polyLines = <Polyline>{};
  LatLng? sourceLatLng, destinationLatLng;
  String distance = '', duration = '';
  CustomState positionLoading = CustomState.LOADING;
  RideRequestModel rideRequestModel;
  google_direction_model.GoogleDirectionModel? googleDirectionModel;
  BitmapDescriptor? pickupLocationIcon, dropOffLocationIcon;
  Uint8List? startMarkerIcon,dropOffMarkerIcon;

  HistoryDetailsState({
    this.mapController, this.cameraPosition,
    this.dropOffMarker, this.positionLoading: CustomState.LOADING,
    this.sourceLatLng, this.destinationLatLng,
    required this.rideRequestModel,
    this.startMarkerIcon,this.dropOffMarkerIcon,
    this.pickupLocationIcon = BitmapDescriptor.defaultMarker,
    this.dropOffLocationIcon = BitmapDescriptor.defaultMarker,
  });

  HistoryDetailsState copy() {
    HistoryDetailsState copy = HistoryDetailsState(
        mapController: mapController, cameraPosition: cameraPosition,
        dropOffMarker: dropOffMarker, positionLoading: positionLoading,
        sourceLatLng: sourceLatLng, destinationLatLng: destinationLatLng,
        rideRequestModel: rideRequestModel,
        pickupLocationIcon: pickupLocationIcon,
        dropOffLocationIcon: dropOffLocationIcon,
        dropOffMarkerIcon: dropOffMarkerIcon,
        startMarkerIcon: startMarkerIcon
    );

    copy.polyLines.addAll(polyLines);
    copy.distance = distance;
    copy.duration = duration;
    copy.pickupMarker = pickupMarker;
    copy.dropOffMarker = dropOffMarker;
    copy.markers = markers;
    copy.googleDirectionModel = googleDirectionModel;
    return copy;
  }
}