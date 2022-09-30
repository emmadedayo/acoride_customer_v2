import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/logic/cubits/ride_history_cubit.dart';
import 'package:acoride/logic/states/ride_history_state.dart';
import 'package:acoride/presentation/components/noWidgetFound.dart';
import 'package:acoride/presentation/components/progressive_loading.dart';
import 'package:acoride/presentation/history/components/ride_history_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:icons_plus/icons_plus.dart';

import 'components/calendar.dart';


class RideHistoryScreen extends StatefulWidget {
  const RideHistoryScreen({Key? key}) : super(key: key);

  @override
  RideHistoryScreenState createState() => RideHistoryScreenState();
}

class RideHistoryScreenState extends State<RideHistoryScreen> {



  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return BlocProvider<RideHistoryCubit>(
      create: (context) => RideHistoryCubit(RideHistoryState(),),
      child: BlocListener<RideHistoryCubit, RideHistoryState>(
        listener: (context, state) {

        },
        child: BlocBuilder<RideHistoryCubit, RideHistoryState>(
          builder: (contextCubit, emeState) {

            return Scaffold(
                backgroundColor: Colors.white,
                body:SafeArea(
                    child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(bottom: 10).r,
                              width: MediaQuery.of(context).size.width,
                              color: HelperColor.primaryColor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(left: 20,right: 20,top: 20,bottom: 7).r,
                                      child:Text("Ride History",style: HelperStyle.textStyle(context,Colors.white,25.sp,FontWeight.w500),)
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.only(left: 20,right: 20,top: 7,bottom: 7).r,
                                    height: 60,
                                    padding: const EdgeInsets.only(left: 20,right: 20,top: 7,bottom: 7).r,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: HelperColor.slightWhiteColor
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              const Icon(Bootstrap.calendar2,color: HelperColor.black,),
                                              const SizedBox(width: 10,),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("From",style: HelperStyle.textStyle(context,HelperColor.black,13.sp,FontWeight.w200)),

                                                  Text(emeState.dateFrom,style: HelperStyle.textStyle(context,HelperColor.black,13.sp,FontWeight.normal)),
                                                ],
                                              ),
                                            ],
                                          ),
                                          onTap: (){
                                            CalendarShift().calender(context).then((value) {
                                              if(value != null){
                                                contextCubit.read<RideHistoryCubit>().startDate(value);
                                                print("objectobject ${value}");
                                              }
                                            });
                                          },
                                        ),
                                        const VerticalDivider(
                                          color: Colors.black,
                                        ),
                                        InkWell(
                                          onTap: (){
                                            CalendarShift().calender(context).then((value) {
                                              if(value != null){
                                                contextCubit.read<RideHistoryCubit>().endDate(value);
                                                print("objectobject ${value}");
                                              }
                                            });
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              const Icon(Bootstrap.calendar2,color: HelperColor.black,),
                                              const SizedBox(width: 10,),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text("To",style: HelperStyle.textStyle(context,HelperColor.black,13.sp,FontWeight.w200)),

                                                  Text(emeState.dateTo,style: HelperStyle.textStyle(context,HelperColor.black,13.sp,FontWeight.normal)),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            ProgressiveLoading(
                              color: HelperColor.black,
                              inAsyncCall: emeState.isLoading,
                            ),
                            emeState.history.isEmpty ?
                            const NotFoundCard(text: 'No Order Found',height: 100,)
                                : ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: emeState.history.length,
                                  itemBuilder: (context, index) {
                                    return RideRequestWidget(
                                      rideRequestModel: emeState.history[index],
                                      onTap: () async {

                                      },
                                    );
                                  },
                            ),
                            SizedBox(height: 30.h,),
                          ],
                        )
                    )
                )
            );
          },
        ),
      ),
    );

  }
}