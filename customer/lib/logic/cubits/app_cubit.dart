import 'dart:async';

import 'package:acoride/core/constant/enum.dart';
import 'package:acoride/data/model/UserModel.dart';
import 'package:acoride/data/repositories/card_repository.dart';
import 'package:acoride/data/repositories/object_box_repository.dart';
import 'package:acoride/data/repositories/transaction_repository.dart';
import 'package:acoride/data/repositories/user_repository.dart';
import 'package:acoride/logic/states/app_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/app_repository.dart';

class AppCubit extends Cubit<AppState> {

  UserRepository repository = UserRepository();
  TransactionRepository transactionRepository = TransactionRepository();
  CardRepository cardRepository = CardRepository();
  ObjectBoxRepository objectBoxRepository = ObjectBoxRepository();
  AppRepository appRepository = AppRepository();

  AppCubit(AppState initialState) : super(initialState) {
    initData();
    getAppSettings();
  }

  Future initData() async {
    _initCloudMessaging();
    await initCurrentUser();
    //
  }

  getAppSettings() async {
    var result = await appRepository.getAppVersion();
    if(result.errorCode! == 200) {
      state.appSettings = result.result;
    }
    emit(state.copy());
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
    await repository.logout();
   // state.user = null;
    //emit(state.copy());
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