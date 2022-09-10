import 'dart:async';
import 'package:acoride/data/model/EmergencyModel.dart';
import 'package:acoride/data/provider/emergency_provider.dart';
import 'package:acoride/data/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';
import '../../core/constant/constants.dart';
import '../Server/result_item.dart';

class EmergencyRepository{

  EmergencyProvider provider = EmergencyProvider();
  UserRepository userRepository = UserRepository();

  Future<List<EmergencyModel>> get() async {
    List<EmergencyModel> sites = [];
    List list = await provider.getEmergency();
    debugPrint('getEmergency: ${list}');
    for (int i = 0; i < list.length; i++) {
      Map map = list[i];
      if (map.isNotEmpty && map['id'] > 0) {
        EmergencyModel? site = EmergencyModel.fromMap(map);
        if (site.id != null) {
          sites.add(site);
        }
      }
    }
    return sites;
  }

  Future<ResultItem<EmergencyModel?>> addEmergency(maps) async {
    EmergencyModel? newUser;
    Map map = await provider.addEmergency(maps);
    int? statusCode = map[FIELD_STATUS_CODE];
    String message = map[FIELD_MESSAGE]?? '';
    if (map.isNotEmpty) {
      try {
        newUser = EmergencyModel.fromMap(map[FIELD_DATA]);
      }
      catch(err) {
        if (kDebugMode) {
          print(err);
        }
      }
    }
    return ResultItem<EmergencyModel?>(result: newUser, errorCode: statusCode, message: message);
  }

  Future<ResultItem?> updateEmergency(maps) async {
    Map map = await provider.updateEmergency(maps).timeout(const Duration(seconds: 5));
    try {
      int? statusCode = map[FIELD_STATUS_CODE];
      String message = map[FIELD_MESSAGE]?? '';
      return ResultItem(result: null, errorCode: statusCode, message: message);

    } on TimeoutException catch (e) {
      return ResultItem(result: null, errorCode: 404, message: e.toString());
    } catch(err) {
      return ResultItem(result: null, errorCode: 404, message: err.toString());
    }
  }


  Future<ResultItem?> deleteEmergency(maps) async {
    Map map = await provider.deleteEmergency(maps).timeout(const Duration(seconds: 5));
    try {
      int? statusCode = map[FIELD_STATUS_CODE];
      String message = map[FIELD_MESSAGE]?? '';
      return ResultItem(result: null, errorCode: statusCode, message: message);

    } on TimeoutException catch (e) {
      return ResultItem(result: null, errorCode: 404, message: e.toString());
    } catch(err) {
      return ResultItem(result: null, errorCode: 404, message: err.toString());
    }
  }
}