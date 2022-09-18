import 'package:acoride/data/provider/firebase_ride_provider.dart';
import '../entities/firebase_ride_model.dart';

class FirebaseRepository{
  final FirebaseProvider repository;

  FirebaseRepository({required this.repository});

  Stream<FireStoreModel> call(String uid){
    return repository.getAllUsers(uid);
  }
}