import 'package:acoride/data/model/UserModel.dart';

class DeliveryUserRequest {
  int? id;
  int? driverId;
  double? userLatitude;
  double? userLongitude;
  bool? available;
  double? distance;
  int? estimatedPrice;
  UserModel? receiver;
  UserModel? driver;

  DeliveryUserRequest(
      {this.id,
        this.driverId,
        this.userLatitude,
        this.userLongitude,
        this.available,
        this.distance,
        this.estimatedPrice,
        this.receiver,
        this.driver});

  DeliveryUserRequest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    driverId = json['driver_id'];
    userLatitude = json['user_latitude'];
    userLongitude = json['user_longitude'];
    available = json['available'];
    distance = json['distance'];
    estimatedPrice = json['estimated_price'];
    receiver = json['receiver'] != null
        ? UserModel.fromMap(json['receiver'])
        : null;
    driver =
    json['driver'] != null ? UserModel.fromMap(json['driver']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['driver_id'] = this.driverId;
    data['user_latitude'] = this.userLatitude;
    data['user_longitude'] = this.userLongitude;
    data['available'] = this.available;
    data['distance'] = this.distance;
    data['estimated_price'] = this.estimatedPrice;
    final receiver = this.receiver;
    if (receiver != null) {
      data['receiver'] = receiver.toMap();
    }
    final driver = this.driver;
    if (driver != null) {
      data['driver'] = driver.toMap();
    }
    return data;
  }
}
