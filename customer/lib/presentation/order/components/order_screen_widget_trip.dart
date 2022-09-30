import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_config.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/data/model/ride_request_model.dart';
import 'package:acoride/logic/states/ride_request_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../components/buttonWidget.dart';


class OrderTripScreenWidget extends StatelessWidget {
  final RideRequestModel rideRequestModel;
  final RideRequestState mapState;
  final ScrollController scrollController;
  final PanelController? panelController;
  final VoidCallback? onCancel;

  const OrderTripScreenWidget({Key? key, required this.mapState,required this.rideRequestModel, required this.scrollController, this.panelController, this.onCancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child:Column(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child:Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Arriving in ${mapState.duration}", style: HelperStyle.textStyleTwo(context, HelperColor.black, 18.sp, FontWeight.w600),),
                      SizedBox(height: 10.h,),
                      Text(rideRequestModel.user?.acorideId ?? '', style: HelperStyle.textStyleTwo(context, HelperColor.black, 14, FontWeight.normal),),
                    ],
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                                child: SizedBox(
                                  height: 50,
                                  child: CachedNetworkImage(
                                    imageUrl: rideRequestModel.user?.kyc?.profileImage ?? "",
                                    placeholder: (context, url) => const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                )
                            ),
                            const SizedBox(height: 5,),
                            Text(HelperConfig.splitName(rideRequestModel.user?.name ?? ''),style: HelperStyle.textStyle(context, HelperColor.black, 14, FontWeight.w400),),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              onPressed: () {
                                HelperConfig.makePhoneCall('tel:${rideRequestModel.user?.phoneNumber ?? ''}');
                              },
                              elevation: 0,
                              color: HelperColor.black.withOpacity(0.3),
                              textColor: Colors.white,
                              padding: const EdgeInsets.all(15),
                              shape: const CircleBorder(),
                              child: const Icon(
                                Iconsax.call,
                                size: 24,
                              ),
                            ),
                            const SizedBox(height: 5,),
                            Text('',style: HelperStyle.textStyle(context, HelperColor.black, 14, FontWeight.w400),),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              onPressed: () {

                              },
                              elevation: 0,
                              color: HelperColor.black.withOpacity(0.3),
                              textColor: Colors.white,
                              padding: const EdgeInsets.all(15),
                              shape: const CircleBorder(),
                              child: const Icon(
                                Iconsax.security_safe,
                                size: 24,
                              ),
                            ),
                            const SizedBox(height: 5,),
                            Text('',style: HelperStyle.textStyle(context, HelperColor.black, 14, FontWeight.w400),),
                          ],
                        ),

                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 8),
                    child:Row(
                      children: [
                        const Icon(Iconsax.money, color: Colors.green,),
                        const SizedBox(width: 16,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Payment Type", style: HelperStyle.textStyleTwo(context, HelperColor.black, 15, FontWeight.w600),),
                            const SizedBox(height: 5,),
                            Text('${rideRequestModel.paymentType}', style: HelperStyle.textStyleTwo(context, HelperColor.black, 14, FontWeight.normal),),
                          ],
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("₦ ${rideRequestModel.estimatedPrice}", style: HelperStyle.textStyleTwo(context, HelperColor.black, 15, FontWeight.w600),),
                            const SizedBox(height: 5,),
                            Text("", style: HelperStyle.textStyleTwo(context, HelperColor.black, 14, FontWeight.normal),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5, top: 20),
                    child:Row(
                      children: [
                        const Icon(Icons.location_searching),
                        const SizedBox(width: 16,),
                        Expanded(child: Text("${rideRequestModel.passengerDestinationAddress}", style: HelperStyle.textStyleTwo(context, HelperColor.black, 15, FontWeight.normal),),)
                      ],
                    ),
                  ),
                  mapState.fireStoreModel?.startTrip == false?
                  Column(
                    children: [
                      SizedBox(height: 10.h,),
                      ButtonWidget(
                        buttonTextSize: 20,
                        containerHeight: 47.h,
                        containerWidth: MediaQuery.of(context).size.width,
                        buttonText: "Cancel",
                        color: HelperColor.redColor,
                        textColor: HelperColor.primaryLightColor,
                        onTap:onCancel!,
                        radius: 30,
                      ),
                    ],
                  ):
                  Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget dragHandle() => GestureDetector(
      onTap:togglePanel,
      child: Center(
        child: Container(
          height: 5,
          width: 50,
          decoration: BoxDecoration(
            color: HelperColor.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      )
  );

  void togglePanel() => panelController!.isPanelOpen ? panelController?.close() : panelController?.open();
}

