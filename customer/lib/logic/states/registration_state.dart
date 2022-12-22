import 'package:acoride/data/model/state_model.dart';
import 'package:flutter/material.dart';

class RegistrationState{
  bool isLoading;
  bool? hasError;
  String? message;
  bool stateLoading;
  bool? success;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController referralController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  List<StateModel> stateModel;
  String name;
  StateModel? selectedState;


  RegistrationState({this.isLoading = false, this.message, this.hasError,this.stateModel = const [],this.stateLoading = false,this.selectedState,this.name: '',this.success});
  RegistrationState copy() {
    RegistrationState copy = RegistrationState(isLoading: isLoading, message: message, hasError: hasError,stateLoading: stateLoading,success: success,selectedState: selectedState);
    copy.nameController = nameController;
    copy.emailController = emailController;
    copy.stateModel = stateModel;
    copy.phoneController = phoneController;
    copy.referralController = referralController;
    copy.passwordController = passwordController;
    copy.stateController = stateController;
    copy.confirmPasswordController = confirmPasswordController;
    copy.name = name;
    return copy;
  }
}