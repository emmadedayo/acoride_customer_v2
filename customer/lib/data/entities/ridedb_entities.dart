import 'package:objectbox/objectbox.dart';

@Entity()
class RideDetails {
  bool hasRide;
  String rideId;
  String rideType;
  int? id;

  RideDetails({required this.hasRide, required this.rideId, required this.rideType});
}