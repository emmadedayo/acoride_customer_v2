import 'dart:convert';

import 'package:acoride/map_component/google_direction_model.dart';
import 'package:http/http.dart' as http;

class GoogleWebService{

  Future getTransaction(String userLatitudeFrom,String userLongitudeFrom,String userLatitudeTo,String userLongitudeTo,) async {
    String url = "https://maps.googleapis.com/maps/api/directions/json?origin=$userLatitudeFrom,$userLongitudeFrom&destination=$userLatitudeTo,$userLongitudeTo&key=AIzaSyDsA3mNfc1hvz1ThjAj6z0qehiCpoQCQj4";
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