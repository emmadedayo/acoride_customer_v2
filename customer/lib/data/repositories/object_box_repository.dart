import 'package:acoride/data/entities/ridedb_entities.dart';
import 'package:acoride/data/provider/object_box_provider.dart';

class ObjectBoxRepository {

  ObjectBoxProvider provider = ObjectBoxProvider();

  Future<int> createRide(RideDetails rideDetails) async {
    int result = await provider.createRide(rideDetails);
    return result;
  }

  Future<RideDetails> updateRideType(String type) async {
    RideDetails? rideDetails = await provider.getRideDetails();
    rideDetails?.rideType = type;
    await provider.createRide(rideDetails!);
    return rideDetails;
  }

  Future<RideDetails> updateRideStatus(bool type) async {
    RideDetails? rideDetails = await provider.getRideDetails();
    rideDetails?.hasRide = type;
    await provider.createRide(rideDetails!);
    return rideDetails;
  }

  Future<RideDetails?> readObject() async {
    RideDetails? rideDetails = await provider.getRideDetails();
    return rideDetails;
  }

  Future<int> deleteRide() async {
    int res =  await provider.delete();
    return res;
  }
}