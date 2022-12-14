class FireStoreModel {
  int? driverID;
  int? passengerID;
  bool? deleteTrip;
  bool? endTrip;
  String? rideID;
  String? rideType;
  bool? sendTrip;
  bool? startTrip;
  bool? confirmTrip;
  int? amount;
  String? time;
  String? distance;

  FireStoreModel({
    required this.driverID,
    required this.passengerID,
    required this.deleteTrip,
    required this.endTrip,
    required this.rideID,
    required this.sendTrip,
    required this.rideType,
    required this.startTrip,
    required this.amount,
    this.time = "1 min",
    required this.distance,
  });

  FireStoreModel.fromJson(json) {
    driverID = json['driver_id'];
    passengerID = json['passenger_id'];
    deleteTrip = json['delete_trip'];
    endTrip = json['end_trip'];
    rideID = json['ride_id'];
    sendTrip = json['send_request'];
    startTrip = json['start_trip'];
    amount = json['trip_amount'];
    confirmTrip = json['confirm_trip'];
    time = json['time'] ?? "1 min";
    rideType = json['ride_type'];
    distance = json['distance'];
  }

  Map<String, dynamic> toMap() {
    return {
      'driver_id': driverID,
      'passenger_id': passengerID,
      'delete_trip': deleteTrip,
      'end_trip': endTrip,
      'ride_id': rideID,
      'send_request': sendTrip,
      'start_trip': startTrip,
      'trip_amount': amount,
      'confirm_trip': confirmTrip,
      'time': time,
      'distance': distance,
      'ride_type': rideType,
    };
  }
}