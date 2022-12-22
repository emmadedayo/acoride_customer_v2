import 'dart:async';

import 'package:acoride/data/model/app_settings.dart';

import '../../core/constant/constants.dart';
import '../Server/result_item.dart';
import '../provider/app_provider.dart';

class AppRepository{
  AppProvider provider = AppProvider();
  
  Future<ResultItem<AppSettings?>> getAppVersion() async {
    AppSettings? appSettings;
    Map map = await provider.getAppVersion();
    print("object $map");
    int? statusCode = map[FIELD_STATUS_CODE];
    String message = map[FIELD_MESSAGE]?? '';
    if (map.isNotEmpty && map[FIELD_DATA] != null) {
      try {
        appSettings = AppSettings.fromJson(map[FIELD_DATA]);
      }
      catch(err) {
        return ResultItem<AppSettings?>(result: null, errorCode: 404, message: 'Error: $err');
      }
    }
    return ResultItem<AppSettings?>(result: appSettings, errorCode: statusCode, message: message);
  }
}