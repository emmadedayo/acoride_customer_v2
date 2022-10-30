import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/logic/states/map_state.dart';
import 'package:acoride/presentation/components/shimmerWidget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../core/helper/helper_config.dart';
import '../../components/buttonWidget.dart';

class ConfirmationWidget extends StatelessWidget {
  final MapState mapState;
  final ScrollController scrollController;
  final PanelController? panelController;
  final VoidCallback? selectPayment,onContinue;

  const ConfirmationWidget({Key? key, required this.mapState, required this.scrollController, this.panelController, this.selectPayment, this.onContinue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child:Column(
        children: [
          Visibility(
            visible: mapState.loadingView,
            child: Column(
              children: [
                Visibility(
                  visible: mapState.amountLoading == false,
                  child: Container(
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:const EdgeInsets.only(left: 13,right: 13).r,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Estimated Total: ", style: HelperStyle.textStyleTwo(context, HelperColor.black, 20.sp, FontWeight.w600),),

                                Text('${HelperConfig.currencyFormat(mapState.userRideRequest?.estimatedPrice.toString() ?? '000')}', style: HelperStyle.textStyleTwo(context, HelperColor.black, 16.sp, FontWeight.w500),),
                              ],
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Padding(
                            padding:const EdgeInsets.only(left: 13,right: 13).r,
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Estimated Distance: ", style: HelperStyle.textStyleTwo(context, HelperColor.black, 13.sp, FontWeight.w600),),

                                Text(mapState.distance, style: HelperStyle.textStyleTwo(context, HelperColor.black, 12.sp, FontWeight.normal),),
                              ],
                            ),
                          ),
                          const Divider(),
                          Container(
                            padding: const EdgeInsets.all(13).r,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Image.asset('assets/images/start_marker.png', width: 20, height: 20,),
                                    const SizedBox(width: 20,),
                                    Expanded(child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Pick Up Location", style: HelperStyle.textStyleTwo(context, HelperColor.black, 12.sp, FontWeight.normal),),
                                        const SizedBox(height: 5,),
                                        Text(mapState.dataFrom[0]['name'], style: HelperStyle.textStyleTwo(context, HelperColor.black, 14.sp, FontWeight.w500),),
                                      ],
                                    ))
                                  ],
                                ),
                                const SizedBox(height: 20,),
                                Row(
                                  children: [
                                    Image.asset('assets/images/end_marker.png', width: 20, height: 20,),
                                    const SizedBox(width: 20,),
                                    Expanded(child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Drop Off Location", style: HelperStyle.textStyleTwo(context, HelperColor.black, 12.sp, FontWeight.normal),),
                                        const SizedBox(height: 5,),
                                        Text(mapState.dataTo[0]['name'], style: HelperStyle.textStyleTwo(context, HelperColor.black, 14.sp, FontWeight.w500),),
                                      ],
                                    ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          SizedBox(height: 5.h,),
                          InkWell(
                              onTap:selectPayment,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 13).r,
                                child: Row(
                                  children: [
                                    const Icon(Iconsax.wallet_search5, color: Colors.green,),
                                    const SizedBox(width: 30,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Payment Type", style: HelperStyle.textStyleTwo(context, HelperColor.black, 15, FontWeight.w600),),
                                        const SizedBox(height: 5,),
                                        Text(mapState.paymentType ?? 'Wallet', style: HelperStyle.textStyleTwo(context, HelperColor.black, 14, FontWeight.normal),),
                                      ],
                                    ),
                                    const Spacer(),
                                    const Icon(Icons.arrow_forward_ios, color: Colors.black,),
                                  ],
                                ),
                              )
                          ),
                          const SizedBox(height: 4,),
                          const Divider(),
                          const SizedBox(height: 20,),
                          ButtonWidget(
                            buttonTextSize: 20,
                            containerHeight: 47.h,
                            containerWidth: MediaQuery.of(context).size.width - 20,
                            buttonText: "Continue to Order",
                            color: HelperColor.primaryColor,
                            textColor: HelperColor.primaryLightColor,
                            onTap: onContinue!,
                            radius: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Visibility(
                  visible: mapState.amountLoading == true,
                  child:Container(
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
                      child: ShimmerWidget(
                        childWidget: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:const EdgeInsets.only(left: 13,right: 13).r,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Estimated Total: ", style: HelperStyle.textStyleTwo(context, HelperColor.black, 20.sp, FontWeight.w600),),

                                  Text('₦0000', style: HelperStyle.textStyleTwo(context, HelperColor.black, 16.sp, FontWeight.w500),),
                                ],
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Padding(
                              padding:const EdgeInsets.only(left: 13,right: 13).r,
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Estimated Distance: ", style: HelperStyle.textStyleTwo(context, HelperColor.black, 13.sp, FontWeight.w600),),

                                  Text(mapState.distance, style: HelperStyle.textStyleTwo(context, HelperColor.black, 12.sp, FontWeight.normal),),
                                ],
                              ),
                            ),
                            const Divider(),
                            Container(
                              padding: const EdgeInsets.all(13).r,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset('assets/images/start_marker.png', width: 20, height: 20,),
                                      const SizedBox(width: 20,),
                                      Expanded(child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("Pick Up Location", style: HelperStyle.textStyleTwo(context, HelperColor.black, 12.sp, FontWeight.normal),),
                                          const SizedBox(height: 5,),
                                          Text(mapState.dataFrom[0]['name'], style: HelperStyle.textStyleTwo(context, HelperColor.black, 14.sp, FontWeight.w500),),
                                        ],
                                      ))
                                    ],
                                  ),
                                  const SizedBox(height: 20,),
                                  Row(
                                    children: [
                                      Image.asset('assets/images/end_marker.png', width: 20, height: 20,),
                                      const SizedBox(width: 20,),
                                      Expanded(child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("Drop Off Location", style: HelperStyle.textStyleTwo(context, HelperColor.black, 12.sp, FontWeight.normal),),
                                          const SizedBox(height: 5,),
                                          Text(mapState.dataTo[0]['name'], style: HelperStyle.textStyleTwo(context, HelperColor.black, 14.sp, FontWeight.w500),),
                                        ],
                                      ))
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            SizedBox(height: 5.h,),
                            InkWell(
                                onTap:selectPayment,
                                child: Row(
                                  children: [
                                    const Icon(Iconsax.money, color: Colors.green,),
                                    const SizedBox(width: 30,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text("Payment Type", style: HelperStyle.textStyleTwo(context, HelperColor.black, 15, FontWeight.w600),),
                                        const SizedBox(height: 5,),
                                        Text(mapState.paymentType ?? 'Wallet', style: HelperStyle.textStyleTwo(context, HelperColor.black, 14, FontWeight.normal),),
                                      ],
                                    ),
                                    const Spacer(),
                                    const Icon(Icons.arrow_forward_ios, color: Colors.black,),
                                  ],
                                )
                            ),
                            const SizedBox(height: 4,),
                            const Divider(),
                            const SizedBox(height: 20,),
                            ButtonWidget(
                              buttonTextSize: 20,
                              containerHeight: 47.h,
                              containerWidth: MediaQuery.of(context).size.width - 20,
                              buttonText: "Continue to Order",
                              color: HelperColor.primaryColor,
                              textColor: HelperColor.primaryLightColor,
                              onTap: onContinue!,
                              radius: 30,
                            ),
                          ],
                        ),
                      )
                    ),
                  ),
                ),
              ],
            )
          ),
          Visibility(
            visible: mapState.loadingView2,
            child: Container(
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Ride Request", style: HelperStyle.textStyleTwo(context, HelperColor.black, 17.sp, FontWeight.w600),),
                    SizedBox(height: 10.h,),
                    const LinearProgressIndicator(
                      minHeight: 5,
                      backgroundColor: HelperColor.primaryColor,
                      valueColor: AlwaysStoppedAnimation<Color>(HelperColor.primaryLightColor),
                    ),
                    SizedBox(height: 10.h,),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5, top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text("Looking for nearby driver", style: HelperStyle.textStyleTwo(context, HelperColor.black, 25.sp, FontWeight.normal),),),
                          Image.asset('assets/images/bike_image.png', width: 100.w,fit: BoxFit.cover,)
                        ],
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 0).r,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Image.asset('assets/images/start_marker.png', width: 20, height: 20,),
                              const SizedBox(width: 20,),
                              Expanded(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Pick Up Location", style: HelperStyle.textStyleTwo(context, HelperColor.black, 12.sp, FontWeight.normal),),
                                  const SizedBox(height: 5,),
                                  Text(mapState.dataFrom[0]['name'], style: HelperStyle.textStyleTwo(context, HelperColor.black, 14.sp, FontWeight.w500),),
                                ],
                              ))
                            ],
                          ),
                          const SizedBox(height: 20,),
                          Row(
                            children: [
                              Image.asset('assets/images/end_marker.png', width: 20, height: 20,),
                              const SizedBox(width: 20,),
                              Expanded(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Drop Off Location", style: HelperStyle.textStyleTwo(context, HelperColor.black, 12.sp, FontWeight.normal),),
                                  const SizedBox(height: 5,),
                                  Text(mapState.dataTo[0]['name'], style: HelperStyle.textStyleTwo(context, HelperColor.black, 14.sp, FontWeight.w500),),
                                ],
                              ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
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

