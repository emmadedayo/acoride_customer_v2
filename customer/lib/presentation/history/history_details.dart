import 'package:acoride/presentation/history/components/ride_history_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/helper/helper_color.dart';
import '../../core/helper/helper_config.dart';
import '../../core/helper/helper_style.dart';
import '../../data/model/ride_request_model.dart';
import '../../logic/cubits/history_details_cubit.dart';
import '../../logic/states/history_details_state.dart';

class HistoryDetailsScreen extends StatefulWidget {
  final RideRequestModel rideRequestModel;
  const HistoryDetailsScreen({Key? key,required this.rideRequestModel}) : super(key: key);

  @override
  RideHistoryScreenState createState() => RideHistoryScreenState();
}

class RideHistoryScreenState extends State<HistoryDetailsScreen> {



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider<HistoryDetailsCubit>(
      create: (context) => HistoryDetailsCubit(HistoryDetailsState(rideRequestModel: widget.rideRequestModel),),
      child: BlocListener<HistoryDetailsCubit, HistoryDetailsState>(
        listener: (context, state) {

        },
        child: BlocBuilder<HistoryDetailsCubit, HistoryDetailsState>(
          builder: (contextCubit, emeState) {
            return Scaffold(
              backgroundColor: HelperColor.slightWhiteColor,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                automaticallyImplyLeading: true,
                title: Text("Trip Details",style: HelperStyle.textStyle(context,Colors.black,18.sp,FontWeight.w500),),
              ),
              body:SafeArea(
                child: ListView(
                  children: [
                    SizedBox(height: 5.h,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TripDetailsHeadingWidget(
                          rideRequestModel: emeState.rideRequestModel,
                        ),
                        SizedBox(height: 20.h,),
                        Padding(
                          padding: const EdgeInsets.only(left: 14,right: 14,),
                          child: Text("Trip Summary",style: HelperStyle.textStyle(context,Colors.black,16.sp,FontWeight.w500),),
                        ),
                        SizedBox(height: 20.h,),
                        TripDetailsWidget(
                          rideRequestModel: emeState.rideRequestModel,
                        ),
                        SizedBox(height: 20.h,),
                         Center(
                           child: Text("Total: ${HelperConfig.currencyFormat(emeState.rideRequestModel.tripAmountRequest?.total ?? '0')}",style: HelperStyle.textStyle(context,Colors.black,20.sp,FontWeight.w500),),
                         )
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}