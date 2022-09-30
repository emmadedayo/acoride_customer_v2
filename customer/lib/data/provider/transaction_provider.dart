import 'package:http/http.dart';

import '../../core/constant/enum.dart';
import '../Server/api_url.dart';
import '../Server/http.dart';

class TransactionProvider{

  Future<Map> topUpWithCard(Map<String,dynamic> map, String token) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.topUpWithCard,
        map, method: HttpMethod.POST_WITH_AUTH, token: token);
    return RestApi.getMapFromResponse(response);
  }

  Future<List> getTransaction(String token) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.getTransaction, {}, method:
    HttpMethod.GET_WITH_AUTH, token: token);
    return RestApi.getListFromResponse(response);
  }

  Future<Map> topUpWithPayStack(Map<String,dynamic> map, String token) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.paystackTopUp,
        map, method: HttpMethod.POST_WITH_AUTH, token: token);
    return RestApi.getMapFromResponse(response);
  }

  Future<Map> buyBills(Map<String,dynamic> map, String token) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.payBills,
        map, method: HttpMethod.POST_WITH_AUTH, token: token);
    return RestApi.getMapFromResponse(response);
  }

}