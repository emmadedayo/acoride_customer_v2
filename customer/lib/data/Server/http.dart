import 'dart:convert';
import 'package:acoride/core/constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../core/constant/enum.dart';


class RestApi {

  static Future<http.Response?> getDataFromServer(String url, Map<String,dynamic> mapParams,
      {HttpMethod method: HttpMethod.POST,
    List<Map<String,dynamic>>? listParams, String token = ""}) async {
    http.Response? response;

    var params = listParams?? mapParams;

    try{
      //debugPrint('=======$url====$method===${jsonEncode(params)}');

      if (method == HttpMethod.POST) {
        response = await http.post(
            Uri.parse(url),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(params)
        );
      }
      else if (method == HttpMethod.PUT) {
        response = await http.put(
            Uri.parse(url),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(params)
        );
      }
      else if (method == HttpMethod.DELETE) {
        response = await http.delete(
            Uri.parse(url),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(params)
        );
      }
      else if (method == HttpMethod.POST_WITH_AUTH) {
        response = await http.post(
            Uri.parse(url),
            headers: {
              "Accept": "application/json",
              "Content-type": "application/json",
              "Authorization": "Bearer " + token
            },
            body: jsonEncode(params)
        );
      }else if (method == HttpMethod.GET_WITH_AUTH) {
        response = await http.get(
            Uri.parse(url),
            headers: {
              "Accept": "application/json",
              "Content-type": "application/json",
              "Authorization": "Bearer " + token
            },
        );
      }else if (method == HttpMethod.DELETE_WITH_AUTH) {
        response = await http.delete(
            Uri.parse(url),
            headers: {
              "Accept": "application/json",
              "Content-type": "application/json",
              "Authorization": "Bearer " + token
            },
            body: jsonEncode(params)
        );
      }else if (method == HttpMethod.POST_WITH_AUTH) {
        response = await http.put(
            Uri.parse(url),
            headers: {
              "Accept": "application/json",
              "Content-type": "application/json",
              "Authorization": "Bearer " + token
            },
            body: jsonEncode(params)
        );
      }
      else {
        response = await http.get(
          Uri.parse(url),
          headers: {"Content-Type": "application/json"},
        );
      }

      //debugPrint('=========Response: ${response.body}');
    }
    catch(e) {
      debugPrint('=========Error http: $e');
    }

    return response;
  }

  static Future<bool> uploadFile({required String url, required String filePath,
    required Map<String, dynamic> params, required String fieldName, HttpMethod method: HttpMethod.POST,}) async {
    bool result = false;

    try {
      var request = http.MultipartRequest(method.name.toUpperCase(), Uri.parse(url),);
      params.forEach((key, value) {
        request.fields[key] = value;
      });
      request.files.add(await http.MultipartFile.fromPath(fieldName, filePath));

      var response = await request.send();
      result = response.statusCode == 200;

      //debugPrint('==$url====File uploaded: ${response.statusCode}');
    }
    catch (err) {
      debugPrint('=========Failed to upload file: $err');
    }

    return result;
  }

  static Map getMapFromResponse(http.Response? response) {
    Map map = {};

    if (response != null) {
      try {
        map = jsonDecode(response.body);
        map[FIELD_STATUS_CODE] = response.statusCode;
      }
      catch (err) {
        debugPrint('=======Err $err');
      }
    }

    return map;
  }

  static List getListFromResponse(http.Response? response) {
    List list = [];

    if (response != null) {
      try {
        list = jsonDecode(response.body)[FIELD_DATA];
      }
      catch (err) {
        debugPrint('=======Err $err');
      }
    }

    return list;
  }

}