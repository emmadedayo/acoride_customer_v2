import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:acoride/core/helper/helper_config.dart';
import 'package:acoride/data/model/placeItem.dart';

class PlaceService {
  static Future<List<PlaceItemRes>> searchPlace(String keyword) async {
    String language = 'en';
    String region = 'NG';
    String apiKey = HelperConfig.apiKey;
    String url = "https://maps.googleapis.com/maps/api/place/textsearch/json?key=$apiKey&language=$language&region=$region&input=${Uri.encodeQueryComponent(keyword)}";
    HttpClient client = HttpClient();
    HttpClientRequest request = await client.getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    if (response.statusCode == 200) {
      return PlaceItemRes.fromJson(json.decode(responseBody));
    } else {
      return PlaceItemRes.fromJson(json.decode(responseBody));
    }
  }
}
