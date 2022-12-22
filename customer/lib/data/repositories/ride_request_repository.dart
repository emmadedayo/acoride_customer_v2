import 'dart:async';

import 'package:acoride/core/constant/constants.dart';
import 'package:acoride/data/Server/result_item.dart';
import 'package:acoride/data/model/ride_request_model.dart';
import 'package:acoride/data/provider/ride_request_provider.dart';
import 'package:acoride/data/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';

import '../model/user_ride_request.dart';

class RideRequestRepository {

  UserRepository userRepository = UserRepository();
  RideRequestProvider provider = RideRequestProvider();

  Future<ResultItem<RideRequestModel?>> getDriver(maps) async {
    debugPrint('==================Get Ride Request Map ${maps}==================');
    RideRequestModel? user;
    Map map = await provider.getDriver(maps,await userRepository.getToken());
    int? statusCode = map[FIELD_STATUS_CODE];
    String message = map[FIELD_MESSAGE]?? '';
  //  debugPrint('==================Get Ride Request Request ${map}==================');
    if (map.isNotEmpty) {
      try {
        user = RideRequestModel.fromMap(map[FIELD_DATA]);
        debugPrint('==================Get Ride Request Request ${user.user}==================');
      }
      catch(err) {
        debugPrint('==================Get Ride Request Map Error ${err}==================');
        return ResultItem<RideRequestModel?>(result: null, errorCode: 404, message: message);
      }
    }
    return ResultItem<RideRequestModel?>(result: user, errorCode: statusCode, message: message);
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

  Future<ResultItem<RideRequestModel?>> deliveryRate(maps) async {
    debugPrint('=========Map : ${maps}');
    RideRequestModel? user;
    Map map = await provider.deliveryRate(maps,await userRepository.getToken());
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

  Future<ResultItem<RideRequestModel?>> rate(maps) async {
    debugPrint('=========Map : ${maps}');
    RideRequestModel? user;
    Map map = await provider.rateRide(maps,await userRepository.getToken());
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

  Future<ResultItem<RideRequestModel?>> getTrip(id) async {
    debugPrint('=========Map : $id');
    RideRequestModel? user;
    Map map = await provider.getTrip(id,await userRepository.getToken());
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


  Future<ResultItem<UserRideRequest?>> getTripAmount(maps) async {
    debugPrint("=========Map : $maps");
    UserRideRequest? user;
    Map map = await provider.getTripAmount(maps,await userRepository.getToken());
    int? statusCode = map[FIELD_STATUS_CODE];
    String message = map[FIELD_MESSAGE]?? '';
    debugPrint("=========Map Result : $map");
    if (map.isNotEmpty) {
      try {
        user = UserRideRequest.fromMap(map[FIELD_DATA]);
      }
      catch(err) {
        return ResultItem<UserRideRequest?>(result: null, errorCode: 404, message: message);
      }
    }
    return ResultItem<UserRideRequest?>(result: user, errorCode: statusCode, message: message);
  }



  Future<List<RideRequestModel>> getRideHistory() async {
    List<RideRequestModel> sites = [];
    List list = await provider.getRideHistory(await userRepository.getToken());
    for (int i = 0; i < list.length; i++) {
      Map map = list[i];
      if (map.isNotEmpty && map['id'] > 0) {
        RideRequestModel? site = RideRequestModel.fromMap(map);
        if (site != null) {
          sites.add(site);
        }
      }
    }
    return sites;
  }

  Future<ResultItem<RideRequestModel?>> emergencyAlert(maps) async {
    debugPrint('=========Map : ${maps}');
    RideRequestModel? user;
    Map map = await provider.emergencyAlert(maps,await userRepository.getToken());
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