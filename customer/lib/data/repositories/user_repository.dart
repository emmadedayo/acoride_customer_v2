import 'dart:async';

import 'package:acoride/data/model/app_settings.dart';
import 'package:acoride/data/model/dashboard_model.dart';
import 'package:acoride/data/provider/user_provider.dart';
import 'package:flutter/foundation.dart';

import '../../core/constant/constants.dart';
import '../Server/result_item.dart';
import '../model/UserModel.dart';

class UserRepository{
  UserProvider provider = UserProvider();

  Future<ResultItem<UserModel?>> signUp(maps) async {
    print('============================> $maps');
    UserModel? newUser;
    Map map = await provider.signUp(maps);
    int? statusCode = map[FIELD_STATUS_CODE];
    String message = map[FIELD_MESSAGE]?? '';
    if (map.isNotEmpty) {
      try {
        newUser = UserModel.fromMap(map[FIELD_DATA]);
      }
      catch(err) {
        if (kDebugMode) {
          print(err);
        }
      }
    }
    return ResultItem<UserModel?>(result: newUser, errorCode: statusCode, message: message);
  }

  Future<ResultItem<UserModel?>> verifyAccount(maps) async {
    UserModel? newUser;
    Map map = await provider.verifyAccount(maps);
    int? statusCode = map[FIELD_STATUS_CODE];
    String message = map[FIELD_MESSAGE]?? '';
    if (map.isNotEmpty) {
      try {
        newUser = UserModel.fromMap(map[FIELD_DATA]);
      }
      catch(err) {
        if (kDebugMode) {
          print(err);
        }
      }
    }
    return ResultItem<UserModel?>(result: newUser, errorCode: statusCode, message: message);
  }

  Future<ResultItem?> resendOtp(maps) async {
    print("==============================> $maps");
    Map map = await provider.resendOtp(maps).timeout(const Duration(seconds: 5));
    try {
      int? statusCode = map[FIELD_STATUS_CODE];
      String message = map[FIELD_MESSAGE]?? '';
      return ResultItem(result: null, errorCode: statusCode, message: message);

    } on TimeoutException catch (e) {
      return ResultItem(result: null, errorCode: 404, message: e.toString());
    } catch(err) {
      return ResultItem(result: null, errorCode: 404, message: err.toString());
    }
  }

  Future<ResultItem?> resetAccount(maps) async {
    print("==============================> $maps");
    Map map = await provider.resetPassword(maps).timeout(const Duration(seconds: 5));
    try {
      int? statusCode = map[FIELD_STATUS_CODE];
      String message = map[FIELD_MESSAGE]?? '';
      return ResultItem(result: null, errorCode: statusCode, message: message);

    } on TimeoutException catch (e) {
      return ResultItem(result: null, errorCode: 404, message: e.toString());
    } catch(err) {
      return ResultItem(result: null, errorCode: 404, message: err.toString());
    }
  }

  Future<ResultItem?> verifyResetAccount(maps) async {
    Map map = await provider.verifyResetPassword(maps).timeout(const Duration(seconds: 5));
    try {
      int? statusCode = map[FIELD_STATUS_CODE];
      String message = map[FIELD_MESSAGE]?? '';
      return ResultItem(result: null, errorCode: statusCode, message: message);

    } on TimeoutException catch (e) {
      return ResultItem(result: null, errorCode: 404, message: e.toString());
    } catch(err) {
      return ResultItem(result: null, errorCode: 404, message: err.toString());
    }
  }

  Future<ResultItem?> changePassword(maps) async {
    Map map = await provider.changePassword(maps).timeout(const Duration(seconds: 5));
    try {
      int? statusCode = map[FIELD_STATUS_CODE];
      String message = map[FIELD_MESSAGE]?? '';
      return ResultItem(result: null, errorCode: statusCode, message: message);

    } on TimeoutException catch (e) {
      return ResultItem(result: null, errorCode: 404, message: e.toString());
    } catch(err) {
      return ResultItem(result: null, errorCode: 404, message: err.toString());
    }
  }

  Future<ResultItem<UserModel?>> auth(maps) async {
    debugPrint('============================> $maps');
    UserModel? user;
    Map map = await provider.login(maps);
    int? statusCode = map[FIELD_STATUS_CODE];
    String message = map[FIELD_MESSAGE]?? '';
    if (map.isNotEmpty && map[FIELD_DATA] != null) {
      try {
        user = UserModel.fromMap(map[FIELD_DATA]['user']);
        await setToken(map[FIELD_DATA]['token']);
      }
      catch(err) {
        return ResultItem<UserModel?>(result: null, errorCode: 404, message: 'Error: $err');
      }
    }
    return ResultItem<UserModel?>(result: user, errorCode: statusCode, message: message);
  }

  Future<UserModel?> getCurrentUser() async {
    UserModel? user;

    Map<String, dynamic> map = await provider.getCurrentUser();
    if (map.isNotEmpty) {
      try {
        user = UserModel.fromMap(map);
      }
      catch(err) {
        if (kDebugMode) {
          print(err);
        }
      }
    }
    return user;
  }

  Future<ResultItem<UserModel?>> updateProfile(maps,token) async {
    debugPrint('$token');
    UserModel? newUser;
    Map map = await provider.updateProfile(maps,token);
    int? statusCode = map[FIELD_STATUS_CODE];
    String message = map[FIELD_MESSAGE]?? '';
    if (map.isNotEmpty) {
      try {
        newUser = UserModel.fromMap(map[FIELD_DATA]);
      }
      catch(err) {
        if (kDebugMode) {
          print(err);
        }
      }
    }
    return ResultItem<UserModel?>(result: newUser, errorCode: statusCode, message: message);
  }

  Future<ResultItem<UserModel?>> verifyEmail(maps,token) async {
    debugPrint('$token');
    UserModel? newUser;
    Map map = await provider.verifyEmail(maps,token);
    int? statusCode = map[FIELD_STATUS_CODE];
    String message = map[FIELD_MESSAGE]?? '';
    debugPrint("message: $message");
    if (map.isNotEmpty) {
      try {
        newUser = UserModel.fromMap(map[FIELD_DATA]);
      }
      catch(err) {
        if (kDebugMode) {
          print(err);
        }
      }
    }
    return ResultItem<UserModel?>(result: newUser, errorCode: statusCode, message: message);
  }

  Future<ResultItem?> changePasswordAuth(maps) async {
    Map map = await provider.changePasswordAuth(maps,await getToken()).timeout(const Duration(seconds: 5));
    print("object $map");
    try {
      int? statusCode = map[FIELD_STATUS_CODE];
      String message = map[FIELD_MESSAGE]?? '';
      return ResultItem(result: null, errorCode: statusCode, message: message);

    } on TimeoutException catch (e) {
      return ResultItem(result: null, errorCode: 404, message: e.toString());
    } catch(err) {
      return ResultItem(result: null, errorCode: 404, message: err.toString());
    }
  }

  Future<ResultItem<DashBoardModel?>> getDashboard() async {
    DashBoardModel? dashBoardModel;
    Map map = await provider.getDashboard(await getToken());
    print("object $map");
    int? statusCode = map[FIELD_STATUS_CODE];
    String message = map[FIELD_MESSAGE]?? '';
    if (map.isNotEmpty && map[FIELD_DATA] != null) {
      try {
        dashBoardModel = DashBoardModel.fromMap(map[FIELD_DATA]);
      }
      catch(err) {
        return ResultItem<DashBoardModel?>(result: null, errorCode: 404, message: 'Error: $err');
      }
    }
    return ResultItem<DashBoardModel?>(result: dashBoardModel, errorCode: statusCode, message: message);
  }

  Future<ResultItem<UserModel?>> getMe() async {
    UserModel? user;
    Map map = await provider.getMe(await getToken());
    print("object $map");
    int? statusCode = map[FIELD_STATUS_CODE];
    String message = map[FIELD_MESSAGE]?? '';
    if (map.isNotEmpty && map[FIELD_DATA] != null) {
      try {
        user = UserModel.fromMap(map[FIELD_DATA]);
      }
      catch(err) {
        return ResultItem<UserModel?>(result: null, errorCode: 404, message: 'Error: $err');
      }
    }
    return ResultItem<UserModel?>(result: user, errorCode: statusCode, message: message);
  }

  Future getToken() async {
    return await provider.getCurrentToken();
  }

  Future setToken(data) async {
    await provider.setToken(data);
  }

  Future setCurrentUser(UserModel userModel) async {
    await provider.setCurrentUser(userModel);
  }

  Future logout() async {
    await provider.logout();
  }

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