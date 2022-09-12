import 'package:acoride/core/constant/enum.dart';
import 'package:acoride/data/model/EmergencyModel.dart';
import 'package:flutter/material.dart';

class EmergencyState{
  CustomState customState;
  bool? hasError;
  bool isLoading;
  bool addEmergency;
  bool isUpdated;
  String? message;

  EmergencyModel? emergencyModel;
  List<EmergencyModel> emergency = [];

  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  EmergencyState({this.customState: CustomState.LOADING, this.message, this.hasError, this.emergencyModel,this.isLoading: true,this.addEmergency: false,this.isUpdated: false}){
    if(emergencyModel != null){
      phoneController.text = emergencyModel!.emergencyPhone!;
      nameController.text = emergencyModel!.emergencyName!;
      addressController.text = emergencyModel!.emergencyAddress!;
    }
  }
  EmergencyState copy() {
    EmergencyState copy = EmergencyState(customState: customState, message: message, hasError: hasError, emergencyModel: emergencyModel,isLoading: isLoading,addEmergency: addEmergency,isUpdated: isUpdated);
    copy.phoneController = phoneController;
    copy.nameController = nameController;
    copy.emergency = emergency;
    copy.addressController = addressController;
    return copy;
  }
}