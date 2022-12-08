import 'dart:convert';

import 'package:acoride/data/Server/api_url.dart';
import 'package:acoride/data/model/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constant/constants.dart';
import '../../core/constant/enum.dart';
import '../Server/http.dart';

class AppProvider{

  Future<Map> getAppVersion() async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.getVersion,
        {}, method: HttpMethod.GET,token:"");
    return RestApi.getMapFromResponse(response);
  }

}