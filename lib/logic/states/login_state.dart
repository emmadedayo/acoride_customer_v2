import 'package:acoride/data/model/UserModel.dart';
import 'package:flutter/material.dart';

class LoginState{
  bool isLoading;
  bool hasError;
  String? message;
  UserModel? user;
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginState({this.isLoading = false, this.message, this.hasError = false, this.user});
  LoginState copy() {
    LoginState copy = LoginState(isLoading: isLoading, message: message, hasError: hasError, user: user);
    copy.phoneController = phoneController;
    copy.passwordController = passwordController;
    return copy;
  }
}