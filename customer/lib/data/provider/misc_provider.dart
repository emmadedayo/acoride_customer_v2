import 'package:http/http.dart';

import '../../core/constant/enum.dart';
import '../Server/api_url.dart';
import '../Server/http.dart';

class MiscProvider{
  
  Future<List> getState() async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.getState, {}, method:
    HttpMethod.GET);
    return RestApi.getListFromResponse(response);
  }

  Future<List> getCategory() async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.getCategory, {}, method:
    HttpMethod.GET);
    return RestApi.getListFromResponse(response);
  }
}