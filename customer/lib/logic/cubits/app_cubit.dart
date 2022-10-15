import 'dart:async';
import 'package:acoride/core/constant/enum.dart';
import 'package:acoride/data/model/UserModel.dart';
import 'package:acoride/data/repositories/card_repository.dart';
import 'package:acoride/data/repositories/object_box_repository.dart';
import 'package:acoride/data/repositories/transaction_repository.dart';
import 'package:acoride/data/repositories/user_repository.dart';
import 'package:acoride/logic/states/app_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../data/model/notification_item.dart';

class AppCubit extends Cubit<AppState> {

  UserRepository repository = UserRepository();
  TransactionRepository transactionRepository = TransactionRepository();
  CardRepository cardRepository = CardRepository();
  ObjectBoxRepository objectBoxRepository = ObjectBoxRepository();

  AppCubit(AppState initialState) : super(initialState) {
    initData();
  }

  Future initData() async {
    _initCloudMessaging();
    await initCurrentUser();
    //
  }


  initCurrentUser() async {
    state.customState = CustomState.LOADING;
    emit(state.copy());

    state.token = await repository.getToken();

    if(state.token != null){
      var result = await repository.getMe();
      if(result.errorCode! == 200) {
        repository.setCurrentUser(result.result!);
        state.transactions = await transactionRepository.getTransaction();
        state.cards = await cardRepository.getAll();
        state.user = result.result;
        state.userInitialized = true;
      }
    }

   // // state.user = await repository.setCurrentUser((await repository.getMe()).result!);
   //  state.user = await repository.getMe();
   //  state.token = await repository.getToken();
   //  state.rideDetails = await objectBoxRepository.readObject();
   //  if (state.user != null) {
   //    state.userInitialized = true;
   //    state.transactions = await transactionRepository.getTransaction();
   //    state.cards = await cardRepository.getAll();
   //    //
   //  }

    state.customState = CustomState.DONE;
    emit(state.copy());
  }

  setSelectedBottomMenuItem(int index) {
   // state.selectedBottomMenuItem = index;
    emit(state.copy());
  }

  setCurrentUser(UserModel? user) {
    state.user = user;

    if (state.user != null) {
      state.userInitialized = true;
      // if (state.notificationToken != null) {
      //     repository.pushToken('${state.user!.id}', state.notificationToken!);
      // }
    }

    emit(state.copy());
  }

  Future logout() async {
    repository.logout();
    state.user = null;
  }


  ///############################################### NOTIFICATION #####################################################


  Future _initCloudMessaging() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    emit(state.copy());
  }

///################################################ Notification End ################################################


}