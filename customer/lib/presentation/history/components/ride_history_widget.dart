import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/data/model/ride_request_model.dart';
import 'package:flutter/material.dart';

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
      child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: HelperColor.fillColor,
              borderRadius: BorderRadius.circular(12)
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                ClipOval(
                  child: Material(
                    color: HelperColor.black.withOpacity(0.03), // Button color
                    child: const SizedBox(width: 50, height: 50, child: Icon(Icons.directions_bike_rounded, color: HelperColor.black,),
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
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
                      Text(
                        '${rideRequestModel?.completedStatusTime}',
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${rideRequestModel?.amountPaid}',
                      style: HelperStyle.textStyle(
                          context, HelperColor.black, 12, FontWeight.w400),
                    ),
                    Text(
                      '${rideRequestModel?.completedStatus}',
                      style: HelperStyle.textStyle(
                          context,
                          HelperColor.black.withOpacity(0.5),
                          11,
                          FontWeight.w400),
                    ),
                  ],
                )
              ],
            ),

          )
      ),
    );
  }
}
