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
                        Text(
                          HelperConfig.shortHistory(rideRequestModel?.completedStatusTime ?? ''),
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
                        '${HelperConfig.currencyFormat(rideRequestModel?.amountPaid ?? '0')}',
                        style: HelperStyle.textStyle(
                            context, HelperColor.black, 12, FontWeight.w400),
                      ),
                      SizedBox(height: 5.h,),
                      Text(
                        'Completed',
                        style: HelperStyle.textStyle(
                            context,
                            HelperColor.primaryColor.withOpacity(0.8),
                            11,
                            FontWeight.bold),
                      ),
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
