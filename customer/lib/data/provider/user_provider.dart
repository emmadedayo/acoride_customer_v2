import 'dart:convert';

import 'package:acoride/data/Server/api_url.dart';
import 'package:acoride/data/model/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constant/constants.dart';
import '../../core/constant/enum.dart';
import '../Server/http.dart';

class UserProvider{



  Future<Map> signUp(Map<String,dynamic> map) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.userRegistration,
        map, method: HttpMethod.POST);
    return RestApi.getMapFromResponse(response);
  }

  Future<Map> verifyAccount(Map<String,dynamic> map) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.verifyRegistration,
        map, method: HttpMethod.POST);

    return RestApi.getMapFromResponse(response);
  }

  Future<Map> resendOtp(Map<String,dynamic> map) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.resetAccount,
        map, method: HttpMethod.POST);

    return RestApi.getMapFromResponse(response);
  }

  Future<Map> resetPassword(Map<String,dynamic> map) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.resetAccount,
        map, method: HttpMethod.POST);

    return RestApi.getMapFromResponse(response);
  }

  Future<Map> verifyResetPassword(Map<String,dynamic> map) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.verifyResetAccount,
        map, method: HttpMethod.POST);

    return RestApi.getMapFromResponse(response);
  }

  Future<Map> changePassword(Map<String,dynamic> map) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.changePassword,
        map, method: HttpMethod.POST);

    return RestApi.getMapFromResponse(response);
  }


  Future<Map> login(Map<String,dynamic> map) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.login,
        map, method: HttpMethod.POST);
    return RestApi.getMapFromResponse(response);
  }

  Future<Map> getMe(token) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.getMe,
        {}, method: HttpMethod.GET_WITH_AUTH,token:token);
    return RestApi.getMapFromResponse(response);
  }

  Future<Map> getDashboard(token) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.getDashboard,
        {}, method: HttpMethod.GET_WITH_AUTH,token:token);
    return RestApi.getMapFromResponse(response);
  }

  Future<Map> getAppVersion() async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.getVersion,
        {}, method: HttpMethod.GET,token:"");
    return RestApi.getMapFromResponse(response);
  }

  ////////////////////////////////////////////////////////////////Session Here \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\


  Future<Map> changePasswordAuth(Map<String,dynamic> map,String token) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.changePasswordAuth,
        map, method: HttpMethod.POST_WITH_AUTH,token:token);

    return RestApi.getMapFromResponse(response);
  }

  Future<Map> updateProfile(Map<String,dynamic> map,String token) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.updateProfile,
        map, method: HttpMethod.POST_WITH_AUTH, token: token);
    return RestApi.getMapFromResponse(response);
  }

  Future<Map> verifyEmail(Map<String,dynamic> map,String token) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.verifyEmail,
        map, method: HttpMethod.POST_WITH_AUTH, token: token);
    return RestApi.getMapFromResponse(response);
  }


  Future<Map<String, dynamic>> getCurrentUser() async {
    Map<String, dynamic> result = {};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userString = prefs.getString(PREF_CURRENT_USER);
    if (userString != null) {
      try {
        result = json.decode(userString);
      }
      catch (e) {
        debugPrint('==============Failed to get current user: $e');
      }
    }
    return result;
  }

  Future<String?> getCurrentToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token =  prefs.getString(USER_TOKEN);
    return token;
  }

  Future setCurrentUser(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_CURRENT_USER, json.encode(user.toMap()));
  }

  Future setToken(String data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(USER_TOKEN, data);
  }

  Future logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(PREF_CURRENT_USER, json.encode({}));
    await prefs.setString(USER_TOKEN, '');
  }

}