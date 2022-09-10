import 'package:acoride/data/model/UserModel.dart';

class RideRequestModel {
  int? id;
  int? driverId;
  double? userLatitude;
  double? userLongitude;
  bool? available;
  double? distance;
  int? estimatedPrice;
  UserModel? user;

  RideRequestModel(
      {this.id,
        this.driverId,
        this.userLatitude,
        this.userLongitude,
        this.available,
        this.distance,
        this.estimatedPrice,
        this.user});

  RideRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    driverId = json['driver_id'];
    userLatitude = json['user_latitude'];
    userLongitude = json['user_longitude'];
    available = json['available'];
    distance = json['distance'];
    estimatedPrice = json['estimated_price'];
    user = json['driver'] != null ? UserModel.fromMap(json['driver']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['driver_id'] = driverId;
    data['user_latitude'] = userLatitude;
    data['user_longitude'] = userLongitude;
    data['available'] = available;
    data['distance'] = distance;
    data['estimated_price'] = estimatedPrice;
    if (user != null) {
      data['driver'] = user!.toMap();
    }
    return data;
  }
}