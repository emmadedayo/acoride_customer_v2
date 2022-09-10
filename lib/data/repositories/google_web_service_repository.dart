import 'dart:convert';

import 'package:acoride/map_component/google_direction_model.dart';
import 'package:http/http.dart' as http;

class GoogleWebService{

  Future getTransaction(String userLatitudeFrom,String userLongitudeFrom,String userLatitudeTo,String userLongitudeTo,) async {
    const String url = "https://maps.googleapis.com/maps/api/directions/json?origin=7.3680661,3.7943167&destination=7.2750175,5.2911003&key=AIzaSyD0fzc0Kgy_W1y3TxXOLy9AiNrbF4HUQHM";
    try {
      Uri uri = Uri.parse(url);
      final response = await http.get(uri);
      final responseDecoded = json.decode(response.body);
      return GoogleDirectionModel.fromMap(responseDecoded);
    } catch (e) {
      return "Address can't be calculated";
    }
  }

}