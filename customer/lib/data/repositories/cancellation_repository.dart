import 'dart:async';
import 'package:acoride/data/model/cancellation_model.dart';
import 'package:acoride/data/provider/cancellation_provider.dart';
import 'package:acoride/data/provider/emergency_provider.dart';
import 'package:acoride/data/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';
import '../../core/constant/constants.dart';
import '../Server/result_item.dart';

class CancellationRepository{

  CancellationProvider provider = CancellationProvider();
  UserRepository userRepository = UserRepository();

  Future<List<CancellationModel>> get() async {
    List<CancellationModel> sites = [];
    List list = await provider.getCancellation();
    debugPrint('getEmergency: ${list}');
    for (int i = 0; i < list.length; i++) {
      Map map = list[i];
      if (map.isNotEmpty && map['id'] > 0) {
        CancellationModel? site = CancellationModel.fromMap(map);
        if (site.id != null) {
          sites.add(site);
        }
      }
    }
    return sites;
  }

  // Future<ResultItem<CancellationModel?>> addEmergency(maps) async {
  //   CancellationModel? newUser;
  //   Map map = await provider.addCancellation(maps);
  //   int? statusCode = map[FIELD_STATUS_CODE];
  //   String message = map[FIELD_MESSAGE]?? '';
  //   if (map.isNotEmpty) {
  //     try {
  //       newUser = CancellationModel.fromMap(map[FIELD_DATA]);
  //     }
  //     catch(err) {
  //       if (kDebugMode) {
  //         print(err);
  //       }
  //     }
  //   }
  //   return ResultItem<CancellationModel?>(result: newUser, errorCode: statusCode, message: message);
  // }
}