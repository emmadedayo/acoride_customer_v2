import 'dart:collection';
import 'dart:typed_data';

import 'package:acoride/data/model/UserModel.dart';
import 'package:acoride/data/model/ride_request_model.dart';
import 'package:flutter/animation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/constant/enum.dart';
import '../../data/model/user_ride_request.dart';
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
  String? message;
  CustomState positionLoading = CustomState.LOADING;
  LocationSettings locationSettings = const LocationSettings();
  dynamic routers;
  List<Map<String, dynamic>> dataFrom = [];
  List<Map<String, dynamic>> dataTo = [];
  bool? hasError,amountLoading,amountLoadingResult;
  UserRideRequest? userRideRequest;
  UserModel? userModel;
  RideRequestModel? rideRequestModel;
  String? paymentType,cardID;
  BitmapDescriptor? pickupLocationIcon, dropOffLocationIcon;
  Uint8List? markerIcon,startMarkerIcon;

  ///Animation Controller Here
  double bottomSheetHeight;
  double bottomSheetHeight2;
  bool loadingView;
  bool loadingView2;

  AnimationController? controller;

  MapState({
    this.mapController, this.cameraPosition, this.position, this.lastKnownPositions,
    this.dropOffMarker, this.positionLoading: CustomState.LOADING, this.locationSettings: const LocationSettings(),
    this.sourceLatLng, this.destinationLatLng, this.currentLatLng,this.dataFrom:const [], this.dataTo:const [],
    this.userModel,
    this.message,
    this.cardID = '0',
    this.loadingView: true,
    this.loadingView2: false,
    this.amountLoading: false,
    this.amountLoadingResult:false,
    this.controller,
    this.hasError,
    this.paymentType = "wallet",
    this.bottomSheetHeight = 0.5,
    this.bottomSheetHeight2 = 0.6,
    this.pickupLocationIcon = BitmapDescriptor.defaultMarker,
    this.dropOffLocationIcon = BitmapDescriptor.defaultMarker,
  });

  MapState copy() {
    MapState copy = MapState(controller:controller,loadingView:loadingView,loadingView2:loadingView2,bottomSheetHeight2: bottomSheetHeight2,bottomSheetHeight: bottomSheetHeight,
        mapController: mapController, cameraPosition: cameraPosition, position: position, lastKnownPositions: lastKnownPositions,
        dropOffMarker: dropOffMarker, positionLoading: positionLoading, sourceLatLng: sourceLatLng, destinationLatLng: destinationLatLng, cardID: cardID,
        currentLatLng: currentLatLng, dataFrom: dataFrom, dataTo: dataTo,userModel: userModel,paymentType: paymentType,hasError: hasError,message: message,amountLoading: amountLoading,amountLoadingResult:amountLoadingResult);

    copy.polyLines.addAll(polyLines);
    copy.distance = distance;
    copy.duration = duration;
    copy.pickupMarker = pickupMarker;
    copy.dropOffMarker = dropOffMarker;
    copy.pickUpAddress = pickUpAddress;
    copy.dropOffAddress = dropOffAddress;
    copy.pickupLocationIcon = pickupLocationIcon;
    copy.dropOffLocationIcon = dropOffLocationIcon;
    copy.markerIcon = markerIcon;
    copy.startMarkerIcon = startMarkerIcon;
    copy.markers = markers;
    copy.googleDirectionModel = googleDirectionModel;
    copy.locationSettings = locationSettings;
    copy.routers = routers;
    copy.rideRequestModel = rideRequestModel;
    copy.userRideRequest = userRideRequest;
    return copy;
  }
}