import 'package:acoride/data/repositories/user_repository.dart';
import 'package:http/http.dart';

import '../../core/constant/enum.dart';
import '../Server/api_url.dart';
import '../Server/http.dart';

class CardProvider{

  UserRepository userRepository = UserRepository();

  Future<Map> saveCard(Map<String,dynamic> map) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.saveCard,
        map, method: HttpMethod.POST_WITH_AUTH, token: await userRepository.getToken());
    return RestApi.getMapFromResponse(response);
  }

  Future<List> getCard() async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.getCard, {}, method:
    HttpMethod.GET_WITH_AUTH, token: await userRepository.getToken());
    return RestApi.getListFromResponse(response);
  }

  Future<Map> deleteCard(Map<String,dynamic> map) async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.deleteCard,
        map, method: HttpMethod.DELETE_WITH_AUTH, token: await userRepository.getToken());
    return RestApi.getMapFromResponse(response);
  }
}