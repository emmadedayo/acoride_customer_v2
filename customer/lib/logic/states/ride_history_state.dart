import 'package:acoride/data/model/UserModel.dart';
import 'package:acoride/data/model/ride_request_model.dart';
import 'package:flutter/material.dart';


class RideHistoryState{
  UserModel? userModel;
  String? message;
  bool isLoading,isLoadingCard;
  TextEditingController comment = TextEditingController();
  List<RideRequestModel> history = [];
  String dateFrom;
  String dateTo;

  RideHistoryState({this.isLoading = false, this.isLoadingCard = false,this.userModel,this.dateFrom = '00/00/0000',this.dateTo = '00/00/0000'});

  RideHistoryState copy() {
    RideHistoryState copy = RideHistoryState(
      isLoading: isLoading,
      userModel: userModel,
      isLoadingCard: isLoadingCard,
    );

    copy.dateFrom = dateFrom;
    copy.dateTo = dateTo;
    copy.history = history;
    copy.comment = comment;
    copy.message = message;
    return copy;
  }
}