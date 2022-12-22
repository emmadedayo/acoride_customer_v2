import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/data/model/ride_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helper/helper_config.dart';


class RideRequestWidget extends StatelessWidget {
  final RideRequestModel? rideRequestModel;
  final VoidCallback? onTap;
  const RideRequestWidget({Key? key, required this.rideRequestModel, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: LayoutBuilder(
        builder: (context, constraints) {
          if(rideRequestModel?.deletedAt != null){
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 15, right: 15, top: 7, bottom: 4).r,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12)
              ),
              padding: const EdgeInsets.all(15),
              child:Row(
                children: [
                  ClipOval(
                    child: Material(
                      color: HelperColor.black.withOpacity(0.03),
                      elevation: 0,
                      child: const SizedBox(width: 40, height: 40, child: Icon(Icons.directions_bike_rounded, color: HelperColor.black,),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${rideRequestModel?.passengerDestinationAddress}',
                          style: HelperStyle.textStyle(
                              context, HelperColor.black, 12, FontWeight.w400),
                        ),
                        SizedBox(height: 5.h,),
                        Text(
                          HelperConfig.shortHistory(rideRequestModel?.createdAt ?? ''),
                          style: HelperStyle.textStyle(
                              context,
                              HelperColor.black.withOpacity(0.5),
                              11,
                              FontWeight.w400),
                        ),
                      ],
                    ),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Cancelled',
                        style: HelperStyle.textStyle(
                            context,
                            HelperColor.redColor.withOpacity(0.8),
                            11,
                            FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            );
          }else{
            return Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 15, right: 15, top: 7, bottom: 4).r,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12)
              ),
              padding: const EdgeInsets.all(15),
              child:Row(
                children: [
                  ClipOval(
                    child: Material(
                      color: HelperColor.black.withOpacity(0.03), // Bu
                      elevation: 0,
                      child: const SizedBox(width: 40, height: 40, child: Icon(Icons.directions_bike_rounded, color: HelperColor.black,),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5,),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${rideRequestModel?.passengerDestinationAddress}',
                          style: HelperStyle.textStyle(
                              context, HelperColor.black, 12, FontWeight.w400),
                        ),
                        SizedBox(height: 5.h,),
                        rideRequestModel?.completedStatusTime == null?
                        Text(
                          HelperConfig.shortHistory(rideRequestModel?.createdAt ?? ''),
                          style: HelperStyle.textStyle(
                              context,
                              HelperColor.black.withOpacity(0.5),
                              11,
                              FontWeight.w400),
                        ):
                        Text(
                          HelperConfig.shortHistory(rideRequestModel?.completedStatusTime ?? ''),
                          style: HelperStyle.textStyle(
                              context,
                              HelperColor.black.withOpacity(0.5),
                              11,
                              FontWeight.w400),
                        )
                      ],
                    ),
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${HelperConfig.currencyFormat(rideRequestModel?.tripAmountRequest?.total ?? '0')}',
                        style: HelperStyle.textStyle(
                            context, HelperColor.black, 12, FontWeight.w400),
                      ),
                      SizedBox(height: 5.h,),
                      rideRequestModel?.completedStatusTime == null?
                      Text(
                        'OnGoing',
                        style: HelperStyle.textStyle(
                            context,
                            HelperColor.primaryColor.withOpacity(0.8),
                            11,
                            FontWeight.bold),
                      ):
                      Text(
                        'Completed',
                        style: HelperStyle.textStyle(
                            context,
                            HelperColor.primaryColor.withOpacity(0.8),
                            11,
                            FontWeight.bold),
                      )
                    ],
                  )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

class TripDetailsHeadingWidget extends StatelessWidget {
  final RideRequestModel? rideRequestModel;
  const TripDetailsHeadingWidget({Key? key, required this.rideRequestModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 15,right: 15,top: 10),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(12)
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
          child: Row(
            children: [
              Image.asset('assets/images/bike_image_small.png',height: 70.h,),
              const SizedBox(width: 15,),
              Expanded(
                child: Column(
                  children: [
                    Text('Your trip with ${HelperConfig.splitName(rideRequestModel?.user?.name ?? 'AA')}',style: HelperStyle.textStyle(
                        context, HelperColor.black, 20, FontWeight.w400)),
                    // Spacer(),

                    rideRequestModel?.deletedAt != null ?
                    Text(HelperConfig.shortHistory(rideRequestModel?.deletedAt ?? ''),style: HelperStyle.textStyle(
                        context, HelperColor.black, 14, FontWeight.normal)) :
                    Text(HelperConfig.shortHistory(rideRequestModel?.completedStatusTime ?? ''),style: HelperStyle.textStyle(
                        context, HelperColor.black, 14, FontWeight.normal)),

                    Text('',style: HelperStyle.textStyle(
                        context, HelperColor.black.withOpacity(0.5), 11, FontWeight.w400),),
                  ],
                ),)
            ],
          ),
        )
    );
  }
}

class TripDetailsWidget extends StatelessWidget {
  final RideRequestModel? rideRequestModel;
  const TripDetailsWidget({Key? key, required this.rideRequestModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(left: 15,right: 15),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5)
        ),
        child:Padding(
          padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8,top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TripColumnWidget(
                title: 'Ride Type',
                value: rideRequestModel?.rideType == "delivery" ? 'Delivery' : rideRequestModel?.rideType == "instant" ? 'Bike' : 'Bike',
              ),
              const Divider(),
              TripColumnWidget(
                title: 'Pick Up Address',
                value: rideRequestModel?.passengerPickupAddress ?? '',
              ),
              const Divider(),
              TripColumnWidget(
                title: 'Drop Off Address',
                value: rideRequestModel?.passengerDestinationAddress ?? '',
              ),
              const Divider(),
              TripColumnWidget(
                title: 'Duration',
                value: rideRequestModel?.duration ?? '',
              ),
              const Divider(),
              TripColumnWidget(
                title: 'Payment Type',
                value: rideRequestModel?.paymentType ?? '',
              ),
            ],
          ),
        )
    );
  }
}

class TripColumnWidget extends StatelessWidget {
  final String? title, value;
  const TripColumnWidget({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title!,style: HelperStyle.textStyle(context,HelperColor.black,14.sp,FontWeight.normal),),
        const SizedBox(height: 8,),
        Text(value!,style: HelperStyle.textStyle(context,Colors.black,15.sp,FontWeight.w500),),
      ],
    );
  }
}
