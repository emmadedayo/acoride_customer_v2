import 'package:acoride/data/entities/firebase_ride_model.dart';

abstract class FirebaseAbstract {
 
  Stream<FireStoreModel> getAllUsers(String uid);

  Future<void> addToStore(FireStoreModel myChatEntity);
  
}