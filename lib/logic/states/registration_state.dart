import 'package:flutter/material.dart';

class RegistrationState{
  bool isLoading;
  bool hasError;
  String? message;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RegistrationState({this.isLoading = false, this.message, this.hasError = false});
  RegistrationState copy() {
    RegistrationState copy = RegistrationState(isLoading: isLoading, message: message, hasError: hasError);
    copy.nameController = nameController;
    copy.emailController = emailController;
    copy.phoneController = phoneController;
    copy.passwordController = passwordController;
    copy.confirmPasswordController = confirmPasswordController;
    return copy;
  }
}