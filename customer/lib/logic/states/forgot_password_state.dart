import 'package:acoride/data/model/UserModel.dart';
import 'package:flutter/material.dart';

class ForgotPasswordState{
  bool isLoading;
  bool? hasError;
  String? message;
  UserModel? user;
  String? phone;


  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  ForgotPasswordState({this.isLoading = false, this.message, this.hasError, this.phone, this.user});

  ForgotPasswordState copy() {
    ForgotPasswordState copy = ForgotPasswordState(isLoading: isLoading, message: message, hasError: hasError, phone: phone);
    copy.phoneController = phoneController;
    copy.otpController = otpController;
    copy.passwordController = passwordController;
    copy.confirmPasswordController = confirmPasswordController;
    copy.user = user;
    return copy;
  }
}