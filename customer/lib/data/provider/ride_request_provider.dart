import 'package:http/http.dart';

import '../../core/constant/enum.dart';
import '../Server/api_url.dart';
import '../Server/http.dart';


class RideRequestProvider{

  Future<Map> getDriver(Map<String,dynamic> map,token) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.requestRide,
        map, method: HttpMethod.POST_WITH_AUTH,token:token);
    return RestApi.getMapFromResponse(response);
  }

  Future<Map> getDeliveryDriver(Map<String,dynamic> map,token) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.getDeliveryDriver,
        map, method: HttpMethod.POST_WITH_AUTH,token:token);
    return RestApi.getMapFromResponse(response);
  }

  Future<Map> getTripAmount(Map<String,dynamic> map,token) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.getTripAmount,
        map, method: HttpMethod.POST_WITH_AUTH,token:token);
    return RestApi.getMapFromResponse(response);
  }

  Future<Map> createTrip(Map<String,dynamic> map,token) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.createTrip,
        map, method: HttpMethod.POST_WITH_AUTH,token:token);
    return RestApi.getMapFromResponse(response);
  }

  Future<Map> getTrip(rideID,token) async {
    Response? response = await RestApi.getDataFromServer('${ApiUrl.getTrip}/?id=$rideID', {},
        method: HttpMethod.GET_WITH_AUTH,token:token);
    return RestApi.getMapFromResponse(response);
  }

  Future<Map> cancelTrip(Map<String,dynamic> map,token) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.cancelTrip,
        map, method: HttpMethod.DELETE_WITH_AUTH,token:token);
    return RestApi.getMapFromResponse(response);
  }

  Future<Map> deliveryRate(Map<String,dynamic> map,token) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.deliveryRate,
        map, method: HttpMethod.POST_WITH_AUTH,token:token);
    return RestApi.getMapFromResponse(response);
  }

  Future<Map> rateRide(Map<String,dynamic> map,token) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.rate,
        map, method: HttpMethod.POST_WITH_AUTH,token:token);
    return RestApi.getMapFromResponse(response);
  }

  Future<Map> emergencyAlert(Map<String,dynamic> map,token) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.emergencyAlert,
        map, method: HttpMethod.POST_WITH_AUTH,token:token);
    return RestApi.getMapFromResponse(response);
  }

  Future<List> getRideHistory(String token) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.getPassengerHistory, {}, method:
    HttpMethod.GET_WITH_AUTH, token: token);
    return RestApi.getListFromResponse(response);
  }
}