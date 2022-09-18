import 'dart:async';
import 'package:acoride/core/constant/constants.dart';
import 'package:acoride/data/Server/result_item.dart';
import 'package:acoride/data/model/ride_request_model.dart';
import 'package:acoride/data/model/user_ride_request.dart';
import 'package:acoride/data/provider/ride_request_provider.dart';
import 'package:acoride/data/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';

class RideRequestRepository {

  UserRepository userRepository = UserRepository();
  RideRequestProvider provider = RideRequestProvider();

  Future<ResultItem<UserRideRequest?>> getDriver(maps) async {
    UserRideRequest? user;
    Map map = await provider.getDriver(maps,await userRepository.getToken());
    int? statusCode = map[FIELD_STATUS_CODE];
    String message = map[FIELD_MESSAGE]?? '';
    if (map.isNotEmpty) {
      try {
        user = UserRideRequest.fromMap(map[FIELD_DATA]);
      }
      catch(err) {
        return ResultItem<UserRideRequest?>(result: null, errorCode: 404, message: 'Error: $err');
      }
    }
    return ResultItem<UserRideRequest?>(result: user, errorCode: statusCode, message: message);
  }


  Future<ResultItem<RideRequestModel?>> createTrip(maps) async {
    debugPrint('=========Map : ${maps}');
    RideRequestModel? user;
    Map map = await provider.createTrip(maps,await userRepository.getToken());
    int? statusCode = map[FIELD_STATUS_CODE];
    String message = map[FIELD_MESSAGE]?? '';
    if (map.isNotEmpty) {
      try {
        user = RideRequestModel.fromMap(map[FIELD_DATA]);
      }
      catch(err) {
        return ResultItem<RideRequestModel?>(result: null, errorCode: 404, message: 'Error: $err');
      }
    }
    return ResultItem<RideRequestModel?>(result: user, errorCode: statusCode, message: message);
  }

  Future<ResultItem<RideRequestModel?>> cancelTrip(maps) async {
    debugPrint('=========Map : ${maps}');
    RideRequestModel? user;
    Map map = await provider.cancelTrip(maps,await userRepository.getToken());
    int? statusCode = map[FIELD_STATUS_CODE];
    String message = map[FIELD_MESSAGE]?? '';
    if (map.isNotEmpty) {
      try {
        user = RideRequestModel.fromMap(map[FIELD_DATA]);
      }
      catch(err) {
        return ResultItem<RideRequestModel?>(result: null, errorCode: 404, message: 'Error: $err');
      }
    }
    return ResultItem<RideRequestModel?>(result: user, errorCode: statusCode, message: message);
  }
}