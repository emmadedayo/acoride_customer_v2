import 'package:acoride/data/entities/firebase_ride_model.dart';
import 'package:acoride/remote/firebase_remote_data_source.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class FirebaseProvider implements FirebaseAbstract {
  final FirebaseFirestore fireStore;

  FirebaseProvider(this.fireStore);


  @override
  Future<void> addToStore(FireStoreModel myChatEntity) {
    // TODO: implement addToStore
    throw UnimplementedError();
  }

  @override
  Stream<FireStoreModel> getAllUsers(String uid) {
    // TODO: implement getAllUsers
    final rideCollection = fireStore.collection("ride_request");
    return rideCollection.doc(uid).snapshots().map((snap) => FireStoreModel.fromJson(snap.data()));
  }

}
