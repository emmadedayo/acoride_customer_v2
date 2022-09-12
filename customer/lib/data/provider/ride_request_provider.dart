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

  Future<Map> createTrip(Map<String,dynamic> map,token) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.createTrip,
        map, method: HttpMethod.POST_WITH_AUTH,token:token);
    return RestApi.getMapFromResponse(response);
  }
}