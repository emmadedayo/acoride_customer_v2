import 'package:acoride/data/model/UserModel.dart';
import 'package:flutter/material.dart';

class ChangePasswordState{
  bool isLoading;
  bool? hasError;
  String? message;
  bool verifyEmail = false;
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  ChangePasswordState({this.isLoading = false, this.message, this.hasError});
  ChangePasswordState copy() {
    ChangePasswordState copy = ChangePasswordState(isLoading: isLoading, message: message, hasError: hasError);
    copy.oldPassword = oldPassword;
    copy.newPassword = newPassword;
    copy.confirmPassword = confirmPassword;
    return copy;
  }
}