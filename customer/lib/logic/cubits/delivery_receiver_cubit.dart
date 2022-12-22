import 'package:acoride/data/repositories/delivery_repository.dart';
import 'package:acoride/data/repositories/misc_repository.dart';
import 'package:acoride/logic/states/delivery_receiver_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/constant/enum.dart';
import '../../core/helper/helper_config.dart';


class DeliveryReceiverCubit extends Cubit<DeliveryReceiverState> {

  DeliveryRepository deliveryRepository = DeliveryRepository();
  MiscRepository miscRepository = MiscRepository();

  DeliveryReceiverCubit(DeliveryReceiverState initialState) : super(initialState) {
    initState();
  }


  initState() async {
    state.isLoading = true;
    emit(state.copy());
    state.categoryModel = await miscRepository.getCategory();
    state.isLoading = false;
    emit(state.copy());
  }


  verifyUser(phoneNumber) async {
    state.isLoading = true;
    emit(state.copy());
    var result = await deliveryRepository.resolveAccount({
      'phone_number': phoneNumber,
      'passenger_pickup_latitude': state.dataFrom[0]['lat'],
      'passenger_pickup_longitude': state.dataFrom[0]['long'],
      'passenger_destination_latitude': state.dataTo[0]['lat'],
      'passenger_destination_longitude': state.dataTo[0]['long'],
    });
    if (result.errorCode! >= 400) {
      state.hasError = true;
      state.isLoading = false;
      state.message = result.message;
    } else {
      state.isLoading = false;
      state.hasError = false;
      state.message = result.message;
      state.deliveryUserRequest = result.result;
      state.userModel = result.result?.receiver;
      state.driver = result.result?.driver;
      state.fullUsername = TextEditingController(text: result.result!.receiver?.name);
      state.amount = TextEditingController(text: state.deliveryUserRequest?.estimatedPrice.toString());
    }
    state.isLoading = false;
    emit(state.copy());
  }

  searchDriver() async {
    state.positionLoading = CustomState.LOADING;
    emit(state.copy());
    state.showLoader = true;
    if(state.driver?.userID.toString() == null){
      state.showLoader = false;
      state.hasError = true;
      state.message = 'All acoride drivers are busy at the moment, please try again later';
    }else{
      Future.delayed(const Duration(seconds: 10), () async {
        var result = await deliveryRepository.getDriver(
            {
              "ride_id":HelperConfig.uuid(),
              "driver_id":state.driver?.userID.toString(),
              "passenger_id": state.myAuth?.userID.toString(),
              "receiver_id": state.userModel?.userID.toString(),
              "passenger_pickup_address":state.dataFrom[0]['name'],
              "passenger_pickup_latitude":state.dataFrom[0]['lat'],
              "passenger_pickup_longitude":state.dataFrom[0]['long'],
              "passenger_destination_address":state.dataTo[0]['name'],
              "passenger_destination_latitude":state.dataTo[0]['lat'],
              "passenger_destination_longitude":state.dataTo[0]['long'],
              "delivery_paying_id": state.whoIsPaying.text == "Sender"?state.myAuth?.userID.toString():state.userModel?.userID.toString(),
              "duration": 0,
              "distance":0,
              "ride_type":"delivery",
              "delivery_category_id":state.selectedCategory?.id,
              "km":0,
              "km_in_time":0,
              "payment_type":state.paymentMethod.text.toLowerCase(),
              "payer":state.whoIsPaying.text,
              "card_id":"",
              "estimated_price":state.deliveryUserRequest?.estimatedPrice,
              "on_going": "1",
            }
        );
        if (result.errorCode! >= 400) {
          state.showLoader = false;
          state.hasError = true;
          state.message = result.message;
        } else {
          state.hasError = false;
          state.message = result.message;
          state.rideRequestModel = result.result;
          //objectBoxRepository.createRide(RideDetails(hasRide: true, rideId: result.result?.rideId ?? '', rideType: 'CREATE_RIDE'));
          state.positionLoading = CustomState.DONE;
        }
        emit(state.copy());
      });
    }
    state.positionLoading = CustomState.DONE;
    emit(state.copy());
  }

  setStateName(value) {
    state.paymentMethod = TextEditingController(text: value);
    emit(state.copy());
  }

  setStateCategory(value) {
    state.selectedCategory = value;
    state.categoryMethod = TextEditingController(text: state.selectedCategory?.category);
    emit(state.copy());
  }

  setPaymentStateName(value) {
    state.whoIsPaying = TextEditingController(text: value);
    emit(state.copy());
  }
}