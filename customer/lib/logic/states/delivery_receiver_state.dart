import 'package:acoride/data/model/UserModel.dart';
import 'package:acoride/data/model/category_model.dart';
import 'package:acoride/data/model/delivery_user_request.dart';
import 'package:acoride/data/model/ride_request_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../core/constant/enum.dart';

class DeliveryReceiverState{
  UserModel? userModel;
  UserModel? myAuth;
  UserModel? driver;
  List<CategoryModel>? categoryModel;
  CategoryModel? selectedCategory;
  CustomState positionLoading = CustomState.LOADING;
  DeliveryUserRequest? deliveryUserRequest;
  List<Map<String, dynamic>> dataFrom = [];
  List<Map<String, dynamic>> dataTo = [];
  String? message;
  bool isLoading;
  RideRequestModel? rideRequestModel;
  bool? hasError;
  bool? showLoader;
  TextEditingController amount = TextEditingController();
  TextEditingController fullUsername = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController paymentMethod = TextEditingController();
  TextEditingController categoryMethod = TextEditingController();
  TextEditingController whoIsPaying = TextEditingController();

  DeliveryReceiverState({this.categoryModel = const [],this.selectedCategory,this.positionLoading: CustomState.LOADING,this.rideRequestModel,this.isLoading = false, this.showLoader = false, this.deliveryUserRequest,this.myAuth,this.userModel,this.driver,this.hasError,this.dataFrom:const [], this.dataTo:const [],});

  DeliveryReceiverState copy() {
    DeliveryReceiverState copy = DeliveryReceiverState(
      isLoading: isLoading,
      userModel: userModel,
      myAuth: myAuth,
      categoryModel: categoryModel,
      showLoader: showLoader,
      driver: driver,
      positionLoading: positionLoading,
      deliveryUserRequest: deliveryUserRequest,
      hasError: hasError,
      dataFrom: dataFrom,
      dataTo: dataTo,
    );
    copy.selectedCategory = selectedCategory;
    copy.amount = amount;
    copy.rideRequestModel = rideRequestModel;
    copy.fullUsername = fullUsername;
    copy.phoneNumber = phoneNumber;
    copy.categoryMethod = categoryMethod;
    copy.paymentMethod = paymentMethod;
    copy.whoIsPaying = whoIsPaying;
    copy.message = message;
    return copy;
  }
}