import 'package:acoride/data/model/ride_request_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/constant/enum.dart';
import '../../data/entities/ridedb_entities.dart';

class DashBoardState {

  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  Position? position, lastKnownPositions;
  Marker? currentMarker;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  String currentAddress = 'Enter Pick Up Location';
  CustomState positionLoading = CustomState.LOADING;
  LocationSettings locationSettings = const LocationSettings();
  RideDetails? rideDetails;
  RideRequestModel? rideRequestModel;
  bool isLoading;

  DashBoardState({this.mapController, this.cameraPosition, this.position, this.lastKnownPositions, this.currentMarker, this.positionLoading: CustomState.LOADING, this.locationSettings: const LocationSettings(),this.rideDetails, this.rideRequestModel, this.isLoading = false});

  DashBoardState copy() {
    DashBoardState copy = DashBoardState(mapController: mapController, cameraPosition: cameraPosition, position: position, lastKnownPositions: lastKnownPositions, currentMarker: currentMarker, positionLoading: positionLoading,rideDetails: rideDetails, rideRequestModel: rideRequestModel, isLoading: isLoading);
    copy.markers.addAll(markers);
    copy.currentAddress = currentAddress;
    copy.locationSettings = locationSettings;
    return copy;
  }
}