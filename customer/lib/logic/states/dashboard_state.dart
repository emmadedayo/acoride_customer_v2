import 'package:acoride/data/model/advert_model.dart';
import 'package:acoride/data/model/app_settings.dart';
import 'package:acoride/data/model/dashboard_model.dart';
import 'package:acoride/data/model/ride_request_model.dart';

import '../../data/model/TransactionModel.dart';
import '../../data/model/UserModel.dart';

class DashBoardState {

  RideRequestModel? rideRequestModel;
  AppSettings? appSettings;
  bool isLoading,userLoading;
  UserModel? userModel;
  DashBoardModel? dashBoardModel;
  List<TransactionModel> transactions = [];
  List<AdvertModel> advert = [];
  List<RideRequestModel> rideHistory = [];

  DashBoardState({this.userLoading=false, this.rideRequestModel, this.appSettings, this.isLoading = false});

  DashBoardState copy() {
    DashBoardState copy = DashBoardState(userLoading:userLoading, rideRequestModel: rideRequestModel, isLoading: isLoading,appSettings: appSettings);
    copy.userModel = userModel;
    copy.dashBoardModel = dashBoardModel;
    copy.transactions = transactions;
    copy.rideHistory = rideHistory;
    copy.advert = advert;
    return copy;
  }
}