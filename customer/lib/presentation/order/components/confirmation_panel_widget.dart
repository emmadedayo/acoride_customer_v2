import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/logic/states/map_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Distance: ", style: HelperStyle.textStyleTwo(context, HelperColor.black, 14, FontWeight.w600),),

                      Text(mapState.distance, style: HelperStyle.textStyleTwo(context, HelperColor.black, 14, FontWeight.normal),),
                    ],
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
                            const Icon(Icons.location_searching),
                            const SizedBox(width: 20,),
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("My Current Location", style: HelperStyle.textStyleTwo(context, HelperColor.black, 12, FontWeight.normal),),
                                const SizedBox(height: 5,),
                                Text(mapState.dataFrom[0]['name'], style: HelperStyle.textStyleTwo(context, HelperColor.black, 15, FontWeight.w500),),
                              ],
                            ))
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            const Icon(Icons.location_searching),
                            const SizedBox(width: 20,),
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("My Drop Off Location", style: HelperStyle.textStyleTwo(context, HelperColor.black, 12, FontWeight.normal),),
                                const SizedBox(height: 5,),
                                Text(mapState.dataTo[0]['name'], style: HelperStyle.textStyleTwo(context, HelperColor.black, 15, FontWeight.w500),),
                              ],
                            ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 10,),
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
                  const SizedBox(height: 10,),
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

