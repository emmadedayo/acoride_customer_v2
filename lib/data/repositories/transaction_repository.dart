import 'dart:async';

import 'package:acoride/core/constant/constants.dart';
import 'package:acoride/data/Server/result_item.dart';
import 'package:acoride/data/model/TransactionModel.dart';
import 'package:acoride/data/provider/transaction_provider.dart';

class TransactionRepository {

  TransactionProvider transactionProvider = TransactionProvider();

  Future<ResultItem?> topUpWithCard(maps,token) async {
    Map map = await transactionProvider.topUpWithCard(maps,token).timeout(const Duration(seconds: 5));
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

  Future<ResultItem?> topUpWithPayStack(maps,token) async {
    Map map = await transactionProvider.topUpWithPayStack(maps,token).timeout(const Duration(seconds: 5));
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

  Future<List<TransactionModel>> getTransaction(String token) async {
    List<TransactionModel> sites = [];
    List list = await transactionProvider.getTransaction(token);
    for (int i = 0; i < list.length; i++) {
      Map map = list[i]['data'];
      if (map.isNotEmpty && map['id'] > 0) {
        TransactionModel? site = TransactionModel.fromMap(map);
        if (site != null) {
          sites.add(site);
        }
      }
    }
    return sites;
  }
}