import 'dart:async';

import 'package:acoride/data/Server/result_item.dart';
import 'package:acoride/data/model/UserCard.dart';

import '../../core/constant/constants.dart';
import '../provider/card_provider.dart';

class CardRepository {

  CardProvider cardProvider = CardProvider();

  Future<ResultItem?> saveCard(maps) async {
    Map map = await cardProvider.saveCard(maps);
    print("object $map");
    try {
      int? statusCode = map[FIELD_STATUS_CODE];
      String message = map[FIELD_MESSAGE]?? '';
      return ResultItem(result: null, errorCode: statusCode, message: message);

    } catch(err) {
      return ResultItem(result: null, errorCode: 404, message: err.toString());
    }
  }

  Future<ResultItem?> deleteCard(maps) async {
    Map map = await cardProvider.deleteCard(maps).timeout(const Duration(seconds: 5));
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

  Future<List<UserCard>> getAll() async {
    List<UserCard> sites = [];
    List list = await cardProvider.getCard();
    for (int i = 0; i < list.length; i++) {
      Map map = list[i];
      if (map.isNotEmpty && map['id'] > 0) {
        UserCard? site = UserCard.fromMap(map);
        if (site != null) {
          sites.add(site);
        }
      }
    }
    return sites;
  }
}