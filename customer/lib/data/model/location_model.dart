class FireStoreLocationModel {
  double? accuracy;
  String? rideID;
  double? suppliedHeading;
  double? suppliedLatitude;
  double? suppliedLongitude;

  FireStoreLocationModel({
    required this.accuracy,
    required this.rideID,
    required this.suppliedHeading,
    required this.suppliedLatitude,
    required this.suppliedLongitude,
  });

  FireStoreLocationModel.fromJson(json) {
    accuracy = json['accuracy'];
    rideID = json['map_id'];
    suppliedHeading = json['supplied_heading'];
    suppliedLatitude = json['supplied_latitude'];
    suppliedLongitude = json['supplied_longitude'];
  }

  Map<String, dynamic> toMap() {
    return {
      'accuracy': accuracy,
      'map_id': rideID,
      'supplied_heading': suppliedHeading,
      'supplied_latitude': suppliedLatitude,
      'supplied_longitude': suppliedLongitude,
    };
  }
}