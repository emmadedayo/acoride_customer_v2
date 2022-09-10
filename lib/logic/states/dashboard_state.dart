import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/constant/enum.dart';

class DashBoardState {

  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  Position? position, lastKnownPositions;
  Marker? currentMarker;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  String currentAddress = 'Enter Pick Up Location';
  CustomState positionLoading = CustomState.LOADING;
  LocationSettings locationSettings = const LocationSettings();

  DashBoardState({this.mapController, this.cameraPosition, this.position, this.lastKnownPositions, this.currentMarker, this.positionLoading: CustomState.LOADING, this.locationSettings: const LocationSettings()});

  DashBoardState copy() {
    DashBoardState copy = DashBoardState(mapController: mapController, cameraPosition: cameraPosition, position: position, lastKnownPositions: lastKnownPositions, currentMarker: currentMarker, positionLoading: positionLoading);
    copy.markers.addAll(markers);
    copy.currentAddress = currentAddress;
    copy.locationSettings = locationSettings;
    return copy;
  }
}