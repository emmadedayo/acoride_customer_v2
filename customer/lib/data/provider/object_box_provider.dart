import 'package:acoride/data/entities/ridedb_entities.dart';
import 'package:acoride/objectbox.g.dart';

import '../../main.dart';

class ObjectBoxProvider{

  Future<int> createRide(RideDetails rideDetails) async {
    var box = objectBox.store.box<RideDetails>();
    return box.put(rideDetails);
  }

  Future<RideDetails?> queryRide(int id) async {
    var box = objectBox.store.box<RideDetails>();
    return box.get(id);
  }

  Future<int> delete() async {
    var box = objectBox.store.box<RideDetails>();
    return box.removeAll();
  }

  Future<RideDetails?> getRideDetails() async {
    final query = (objectBox.store.box<RideDetails>().query(RideDetails_.hasRide.equals(true))).build();
    return query.findFirst();
  }

}