import 'dart:collection';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/constant/enum.dart';
import '../../map_component/google_direction_model.dart' as google_direction_model;

class MapState {

  GoogleMapController? mapController;
  CameraPosition? cameraPosition;
  Position? position, lastKnownPositions;
  Marker? pickupMarker, dropOffMarker;
  Set<Marker> markers = HashSet();
  google_direction_model.GoogleDirectionModel? googleDirectionModel;
  Set<Polyline> polyLines = <Polyline>{};
  LatLng? sourceLatLng, destinationLatLng,currentLatLng;
  String distance = '', duration = '', pickUpAddress = 'Enter Pick Up Location', dropOffAddress = 'Enter Drop Off Location';
  CustomState positionLoading = CustomState.LOADING;
  LocationSettings locationSettings = const LocationSettings();
  dynamic routers;
  List<Map<String, dynamic>> dataFrom = [];
  List<Map<String, dynamic>> dataTo = [];
  double confirmInitValue = 350.0, confirmDriverValue = 250.0, confirmDriverStartTrip = 235.0;
  bool confirmInit = true, confirmToOrder = false, noDriverFound = false, displayDriver = false, rideCancelled = false;

  MapState({
    this.mapController, this.cameraPosition, this.position, this.lastKnownPositions,
    this.dropOffMarker, this.positionLoading: CustomState.LOADING, this.locationSettings: const LocationSettings(),
    this.sourceLatLng, this.destinationLatLng, this.currentLatLng,this.dataFrom:const [], this.dataTo:const [],
    this.confirmInit: true, this.confirmToOrder: false, this.noDriverFound: false, this.displayDriver: false, this.rideCancelled: false,
    this.confirmInitValue: 300.0});

  MapState copy() {
    MapState copy = MapState(mapController: mapController, cameraPosition: cameraPosition, position: position, lastKnownPositions: lastKnownPositions,
        dropOffMarker: dropOffMarker, positionLoading: positionLoading, sourceLatLng: sourceLatLng, destinationLatLng: destinationLatLng,
        currentLatLng: currentLatLng, dataFrom: dataFrom, dataTo: dataTo, confirmInit: confirmInit, confirmToOrder: confirmToOrder, noDriverFound: noDriverFound,
        displayDriver: displayDriver, rideCancelled: rideCancelled,
        confirmInitValue: confirmInitValue);

    copy.polyLines.addAll(polyLines);
    copy.distance = distance;
    copy.duration = duration;
    copy.pickupMarker = pickupMarker;
    copy.dropOffMarker = dropOffMarker;
    copy.pickUpAddress = pickUpAddress;
    copy.dropOffAddress = dropOffAddress;
    copy.markers = markers;
    copy.googleDirectionModel = googleDirectionModel;
    copy.locationSettings = locationSettings;
    copy.routers = routers;
    return copy;
  }
}