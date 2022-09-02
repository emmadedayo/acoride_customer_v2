import 'package:acoride/data/model/UserCard.dart';
import 'package:http/http.dart';

import '../../core/constant/enum.dart';
import '../Server/api_url.dart';
import '../Server/http.dart';

class CardProvider{

  Future<Map> saveCard(Map<String,dynamic> map, String token) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.saveCard,
        map, method: HttpMethod.POST_WITH_AUTH, token: token);
    return RestApi.getMapFromResponse(response);
  }

  Future<List> getCard(String token) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.getCard, {}, method:
    HttpMethod.GET_WITH_AUTH, token: token);
    return RestApi.getListFromResponse(response);
  }

  Future<Map> deleteCard(Map<String,dynamic> map, String token) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.deleteCard,
        map, method: HttpMethod.POST_WITH_AUTH, token: token);
    return RestApi.getMapFromResponse(response);
  }
}