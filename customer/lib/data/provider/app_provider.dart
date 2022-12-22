import 'package:acoride/data/Server/api_url.dart';
import 'package:http/http.dart';

import '../../core/constant/enum.dart';
import '../Server/http.dart';

class AppProvider{

  Future<Map> getAppVersion() async {
    Response? response = await RestApi.getDataFromServer(ApiUrl.getVersion,
        {}, method: HttpMethod.GET,token:"");
    return RestApi.getMapFromResponse(response);
  }

}