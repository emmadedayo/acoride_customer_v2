
import 'package:acoride/data/Server/api_url.dart';
import 'package:acoride/data/repositories/user_repository.dart';
import 'package:http/http.dart';
import '../../core/constant/enum.dart';
import '../Server/http.dart';

class EmergencyProvider{

  UserRepository userRepository = UserRepository();

  Future<List> getEmergency() async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.getEmergency, {}, method:
    HttpMethod.GET_WITH_AUTH, token: await userRepository.getToken());
    return RestApi.getListFromResponse(response);
  }

  Future<Map> addEmergency(Map<String,dynamic> map) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.addEmergency,
        map, method: HttpMethod.POST_WITH_AUTH, token: await userRepository.getToken());
    return RestApi.getMapFromResponse(response);
  }

  Future<Map> updateEmergency(Map<String,dynamic> map) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.updateEmergency,
        map, method: HttpMethod.POST_WITH_AUTH, token: await userRepository.getToken());
    return RestApi.getMapFromResponse(response);
  }

  Future<Map> deleteEmergency(Map<String,dynamic> map) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.deleteEmergency,
        map, method: HttpMethod.DELETE_WITH_AUTH, token: await userRepository.getToken());
    return RestApi.getMapFromResponse(response);
  }
}