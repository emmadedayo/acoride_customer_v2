import 'package:acoride/data/Server/api_url.dart';
import 'package:acoride/data/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../../core/constant/enum.dart';
import '../Server/http.dart';

class CancellationProvider{

  UserRepository userRepository = UserRepository();

  Future<List> getCancellation() async {
    Response? response = await RestApi.getDataFromServer('${ApiUrl.getCancellation}?type=passenger', {}, method:
    HttpMethod.GET_WITH_AUTH, token: await userRepository.getToken());
    debugPrint('getEmergencys: ${response?.body}');
    return RestApi.getListFromResponse(response);
  }
}