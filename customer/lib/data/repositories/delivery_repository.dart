import 'dart:async';

import 'package:acoride/core/constant/constants.dart';
import 'package:acoride/data/Server/result_item.dart';
import 'package:acoride/data/model/delivery_user_request.dart';
import 'package:acoride/data/provider/delivery_provider.dart';
import 'package:acoride/data/provider/ride_request_provider.dart';
import 'package:acoride/data/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../model/ride_request_model.dart';

class DeliveryRepository {

  DeliveryProvider deliveryProvider = DeliveryProvider();
  UserRepository userRepository = UserRepository();
  RideRequestProvider requestProvider = RideRequestProvider();


  Future<ResultItem<RideRequestModel?>> getDriver(maps) async {
    debugPrint('==================Get Ride Request Map ${maps}==================');
    RideRequestModel? user;
    Map map = await requestProvider.getDeliveryDriver(maps,await userRepository.getToken());
    int? statusCode = map[FIELD_STATUS_CODE];
    String message = map[FIELD_MESSAGE]?? '';
    if (map.isNotEmpty) {
      try {
        user = RideRequestModel.fromMap(map[FIELD_DATA]);
      }
      catch(err) {
        return ResultItem<RideRequestModel?>(result: null, errorCode: 404, message: message);
      }
    }
    return ResultItem<RideRequestModel?>(result: user, errorCode: statusCode, message: message);
  }


  Future<ResultItem<DeliveryUserRequest?>> resolveAccount(maps) async {
    debugPrint("----------ResolveUserDetails------------- $maps");
    DeliveryUserRequest? user;
    Map map = await deliveryProvider.getReceiverDetails(maps,await userRepository.getToken()).timeout(const Duration(seconds: 5));
    int? statusCode = map[FIELD_STATUS_CODE];
    String message = map[FIELD_MESSAGE]?? '';
    if (map.isNotEmpty) {
      try {
        user = DeliveryUserRequest.fromJson(map[FIELD_DATA]);
      }
      catch(err) {
        return ResultItem<DeliveryUserRequest?>(result: null, errorCode: statusCode, message: message);
      }
    }
    return ResultItem<DeliveryUserRequest?>(result: user, errorCode: statusCode, message: message);
  }

}