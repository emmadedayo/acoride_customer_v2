import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../core/constant/enum.dart';
import '../Server/api_url.dart';
import '../Server/http.dart';

class DeliveryProvider{

  Future<Map> getReceiverDetails(Map<String,dynamic> map, String token) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.getUserDelivery,
        map, method: HttpMethod.POST_WITH_AUTH, token: token);
    debugPrint(response?.statusCode.toString());
    return RestApi.getMapFromResponse(response);
  }
}