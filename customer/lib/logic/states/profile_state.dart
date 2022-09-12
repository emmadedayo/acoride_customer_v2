import 'package:acoride/data/model/UserModel.dart';
import 'package:flutter/material.dart';

class ProfileState{
  bool isLoading;
  bool? hasError;
  String? message;
  UserModel? user;
  bool verifyEmail = false;
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  ProfileState({this.isLoading = false, this.message, this.hasError, this.user, this.verifyEmail = false}){
    if(user != null){
      phoneController.text = user!.phoneNumber!;
      nameController.text = user!.name!;
      emailController.text = user!.email!;
    }
  }
  ProfileState copy() {
    ProfileState copy = ProfileState(isLoading: isLoading, message: message, hasError: hasError, user: user);
    copy.phoneController = phoneController;
    copy.nameController = nameController;
    copy.emailController = emailController;
    return copy;
  }
}