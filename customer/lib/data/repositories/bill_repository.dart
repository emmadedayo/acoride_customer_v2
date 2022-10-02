import 'dart:async';

import 'package:acoride/data/model/bill_model.dart';
import 'package:acoride/data/model/variation_model.dart';
import 'package:acoride/data/provider/bill_provider.dart';
import 'package:acoride/data/repositories/user_repository.dart';

import '../../core/constant/constants.dart';
import '../Server/result_item.dart';

class BillRepository {

  BillProvider billProvider = BillProvider();
  UserRepository userRepository = UserRepository();

  Future<List<BillModel>> getBill(String type) async {
    List<BillModel> sites = [];
    List list = await billProvider.getBills(type,await userRepository.getToken());
    for (int i = 0; i < list.length; i++) {
      Map map = list[i];
      if (map.isNotEmpty) {
        BillModel? site = BillModel.fromJson(map);
        if (site != null) {
          sites.add(site);
        }
      }
    }
    return sites;
  }

  Future<List<VariationModel>> getVariation(String type) async {
    List<VariationModel> sites = [];
    List list = await billProvider.getVariation(type,await userRepository.getToken());
    for (int i = 0; i < list.length; i++) {
      Map map = list[i];
      if (map.isNotEmpty) {
        VariationModel? site = VariationModel.fromJson(map);
        if (site != null) {
          sites.add(site);
        }
      }
    }
    return sites;
  }

  Future<ResultItem?> getSmartName(maps) async {
    print("objectobject $maps");
    Map map = await billProvider.getSmartName(maps,await userRepository.getToken()).timeout(const Duration(seconds: 5));
    try {
      int? statusCode = map[FIELD_STATUS_CODE];
      String message = map[FIELD_MESSAGE]?? '';
      return ResultItem(result: {'name':message}, errorCode: statusCode, message: message);

    } on TimeoutException catch (e) {
      return ResultItem(result: null, errorCode: 404, message: e.toString());
    } catch(err) {
      return ResultItem(result: null, errorCode: 404, message: err.toString());
    }
  }
}