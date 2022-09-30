import 'package:acoride/data/model/UserModel.dart';
import 'package:flutter/material.dart';

class VerifyPhoneState{
  bool isLoading;
  bool? hasError;
  String? message;
  UserModel? user;
  String phone;
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  VerifyPhoneState({this.isLoading = false, this.message, this.hasError, required this.phone, this.user});

  VerifyPhoneState copy() {
    VerifyPhoneState copy = VerifyPhoneState(isLoading: isLoading, message: message, hasError: hasError, phone: phone);
    copy.phoneController = phoneController;
    copy.otpController = otpController;
    copy.passwordController = passwordController;
    copy.user = user;
    return copy;
  }
}