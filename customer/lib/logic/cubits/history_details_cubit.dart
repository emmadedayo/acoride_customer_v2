import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:google_geocoding/google_geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/constant/enum.dart';
import '../../core/helper/helper_color.dart';
import '../../core/helper/helper_config.dart';
import '../../data/repositories/google_web_service_repository.dart';
import '../../data/repositories/object_box_repository.dart';
import '../../data/repositories/ride_request_repository.dart';
import '../states/history_details_state.dart';


class HistoryDetailsCubit extends Cubit<HistoryDetailsState> {

  HistoryDetailsCubit(HistoryDetailsState initialState) : super(initialState) {
    initState();
  }

  GoogleWebService googleWebService = GoogleWebService();
  RideRequestRepository rideRequestRepository = RideRequestRepository();
  ObjectBoxRepository objectBoxRepository = ObjectBoxRepository();

  var googleGeocoding = GoogleGeocoding(HelperConfig.apiKey);

  initState() async {
    state.positionLoading = CustomState.LOADING;
    state.markers.clear();
    state.polyLines.clear();
    emit(state.copy());
    state.mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(state.rideRequestModel.passengerPickupLatitude ?? 0.0, state.rideRequestModel.passengerPickupLongitude ?? 0.0),
          zoom: 12.0,
        ),
      ),
    );
    await driverMarker();
    await getLocationLine(state.rideRequestModel.passengerPickupLatitude.toString(), state.rideRequestModel.passengerDestinationLongitude.toString(), state.rideRequestModel.passengerDestinationLatitude.toString(), state.rideRequestModel.passengerDestinationLongitude.toString());
    state.positionLoading = CustomState.DONE;
    emit(state.copy());
  }

  void onMapCreated(GoogleMapController mapController) {
    state.mapController = mapController;
    emit(state.copy());
  }

  getLocationLine(String userLatFrom , String userLongFrom, String userLatTo, String userLongTo) async {
    final String polylineIdVal = 'polyline_id_${HelperConfig.getTimeStampDividedByOneThousand(DateTime.now())}';
    final PolylineId polylineId = PolylineId(polylineIdVal);
    state.googleDirectionModel = await googleWebService.getTransaction(userLatFrom,userLongFrom,userLatTo,userLongTo).then((value){
      state.googleDirectionModel = value;
      state.pickupMarker = Marker(
          markerId: MarkerId('pick_up_location_trip${UniqueKey()}'),
          position: LatLng(state.rideRequestModel.passengerPickupLatitude ?? 0.0, state.rideRequestModel.passengerDestinationLongitude ?? 0.0),
          icon:state.dropOffLocationIcon!
      );

      state.dropOffMarker = Marker(
          markerId: MarkerId('drop_off_destination_trip${UniqueKey()}'),
          position: LatLng(state.rideRequestModel.passengerDestinationLatitude ?? 0.0, state.rideRequestModel.passengerDestinationLongitude ?? 0.0),
          icon:state.pickupLocationIcon!
      );

      state.markers.add(state.pickupMarker!);
      state.markers.add(state.dropOffMarker!);
      return value;
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

  driverMarker() async {

    state.startMarkerIcon = await  HelperConfig.getBytesFromAsset('assets/images/start_marker.png', 45);
    state.pickupLocationIcon = BitmapDescriptor.fromBytes(state.startMarkerIcon!);

    state.dropOffMarkerIcon = await  HelperConfig.getBytesFromAsset('assets/images/end_marker.png', 45);
    state.dropOffLocationIcon = BitmapDescriptor.fromBytes(state.dropOffMarkerIcon!);

    emit(state.copy());
  }

}