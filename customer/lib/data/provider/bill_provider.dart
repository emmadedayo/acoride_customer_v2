import 'package:http/http.dart';

import '../../core/constant/enum.dart';
import '../Server/api_url.dart';
import '../Server/http.dart';

class BillProvider{

  Future<List> getBills(String type,token) async {
    Response? response = await RestApi.getDataFromServer('${ApiUrl.getBill}?type=$type', {}, method:
    HttpMethod.GET_WITH_AUTH,token: token);
    return RestApi.getListFromResponse(response);
  }

  Future<List> getVariation(String type,token) async {
    Response? response = await RestApi.getDataFromServer('${ApiUrl.getVariation}?serviceID=$type', {}, method:
    HttpMethod.GET_WITH_AUTH,token:token);
    return RestApi.getListFromResponse(response);
  }

  Future<Map> getSmartName(Map<String,dynamic> map, String token) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.getSmartName,
        map, method: HttpMethod.POST_WITH_AUTH, token: token);
    return RestApi.getMapFromResponse(response);
  }

}