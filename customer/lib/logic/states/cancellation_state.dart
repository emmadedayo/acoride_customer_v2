import 'package:acoride/data/model/UserModel.dart';
import 'package:acoride/data/model/ride_request_model.dart';
import 'package:geolocator/geolocator.dart';
import '../../data/model/cancellation_model.dart';

class CancellationState{
  UserModel? userModel;
  String? message;
  bool isLoading;
  int? selectedReason;
  List<CancellationModel> data = [];
  CancellationModel? cancellationModel;
  RideRequestModel? rideRequestModel;
  Position? position;

  CancellationState({this.isLoading = false,this.userModel,this.cancellationModel,this.rideRequestModel,this.position});

  CancellationState copy() {
    CancellationState copy = CancellationState(
      isLoading: isLoading,
      userModel: userModel,
      cancellationModel: cancellationModel,
      rideRequestModel: rideRequestModel,
      position: position,
    );
    copy.data = data;
    copy.message = message;
    copy.selectedReason = selectedReason;
    return copy;
  }
}