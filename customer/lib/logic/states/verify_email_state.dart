import 'package:acoride/data/model/UserModel.dart';
import 'package:flutter/material.dart';

class VerifyEmailState{
  bool isLoading;
  bool? hasError;
  String? message;
  UserModel? user;
  String email;
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  VerifyEmailState({this.isLoading = false, this.message, this.hasError, this.user,  required this.email}){
    if(user != null){
      phoneController.text = user!.phoneNumber!;
      nameController.text = user!.name!;
      emailController.text = email;
    }
  }
  VerifyEmailState copy() {
    VerifyEmailState copy = VerifyEmailState(isLoading: isLoading, message: message, hasError: hasError, user: user, email: email);
    copy.phoneController = phoneController;
    copy.nameController = nameController;
    copy.otpController = otpController;
    copy.emailController = emailController;
    return copy;
  }
}