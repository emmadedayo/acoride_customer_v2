import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/logic/states/delivery_receiver_state.dart';
import 'package:acoride/logic/states/map_state.dart';
import 'package:acoride/presentation/components/shimmerWidget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../../core/helper/helper_config.dart';
import '../../components/buttonWidget.dart';
import 'delivery_constant.dart';

class ConfirmationDeliveryWidget extends StatelessWidget {
  final MapState mapState;
  final ScrollController scrollController;
  final PanelController? panelController;
  final VoidCallback? onContinue;

  const ConfirmationDeliveryWidget({Key? key, required this.mapState, required this.scrollController, this.panelController, this.onContinue})
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
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Estimated Time: ", style: HelperStyle.textStyleTwo(context, HelperColor.black, 15.sp, FontWeight.w600),),

                                  Text(mapState.duration, style: HelperStyle.textStyleTwo(context, HelperColor.black, 14.sp, FontWeight.normal),),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Padding(
                              padding:const EdgeInsets.only(left: 13,right: 13).r,
                              child:Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Distance: ", style: HelperStyle.textStyleTwo(context, HelperColor.black, 15.sp, FontWeight.w600),),

                                  Text(mapState.distance, style: HelperStyle.textStyleTwo(context, HelperColor.black, 14.sp, FontWeight.normal),),
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
                            SizedBox(height: 15.h,),
                            ButtonWidget(
                              buttonTextSize: 20,
                              containerHeight: 47.h,
                              containerWidth: MediaQuery.of(context).size.width - 20,
                              buttonText: "Continue",
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
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("ETA: ", style: HelperStyle.textStyleTwo(context, HelperColor.black, 15.sp, FontWeight.w600),),

                                      Text(mapState.duration, style: HelperStyle.textStyleTwo(context, HelperColor.black, 14.sp, FontWeight.normal),),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10,),
                                Padding(
                                  padding:const EdgeInsets.only(left: 13,right: 13).r,
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Distance: ", style: HelperStyle.textStyleTwo(context, HelperColor.black, 15.sp, FontWeight.w600),),

                                      Text(mapState.distance, style: HelperStyle.textStyleTwo(context, HelperColor.black, 14.sp, FontWeight.normal),),
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
                                const SizedBox(height: 29,),
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


class DeliveryPaymentWidget extends StatelessWidget {
  final VoidCallback? voidCallback;
  const DeliveryPaymentWidget({Key? key,this.voidCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: voidCallback,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            //padding: const EdgeInsets.all(15.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(13)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: HelperColor.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 10,bottom: 10),
                  child: Text("Select Type",
                      textAlign: TextAlign.left,
                      style: HelperStyle.textStyle(context, HelperColor.black, 20.sp, FontWeight.w500)
                  ),
                ),
                ListView.builder(
                    itemCount: paymentMethod.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context,int index){
                      return Column(
                        children: [
                          InkWell(
                            child:ListTile(
                              contentPadding: const EdgeInsets.only(left: 20,right: 20),
                              title: Text(paymentMethod[index].method ?? '',style: HelperStyle.textStyle(context, HelperColor.black, 16, FontWeight.w300),),
                              trailing:const Icon(LineAwesomeIcons.arrow_right,color: Colors.black,size: 20,),
                            ),
                            onTap: (){
                              Navigator.pop(context, paymentMethod[index].method);
                            },
                          )
                        ],
                      );
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DeliveryPayingAccountWidget extends StatelessWidget {
  final VoidCallback? voidCallback;
  const DeliveryPayingAccountWidget({Key? key,this.voidCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: voidCallback,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            //padding: const EdgeInsets.all(15.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(13)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    height: 5,
                    width: 50,
                    decoration: BoxDecoration(
                      color: HelperColor.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 10,bottom: 10),
                  child: Text("Select Type",
                      textAlign: TextAlign.left,
                      style: HelperStyle.textStyle(context, HelperColor.black, 20.sp, FontWeight.w500)
                  ),
                ),
                ListView.builder(
                    itemCount: deliveryPayer.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context,int index){
                      return Column(
                        children: [
                          InkWell(
                            child:ListTile(
                              contentPadding: const EdgeInsets.only(left: 20,right: 20),
                              title: Text(deliveryPayer[index].paying ?? '',style: HelperStyle.textStyle(context, HelperColor.black, 16, FontWeight.w300),),
                              trailing:const Icon(LineAwesomeIcons.arrow_right,color: Colors.black,size: 20,),
                            ),
                            onTap: (){
                              Navigator.pop(context, deliveryPayer[index].paying);
                            },
                          )
                        ],
                      );
                    }
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ConfirmDeliveryDetails extends StatelessWidget {
  final DeliveryReceiverState? deliveryReceiverState;
  final VoidCallback? voidCallback;
  const ConfirmDeliveryDetails({Key? key,this.voidCallback,this.deliveryReceiverState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: const BoxDecoration(
            color:HelperColor.slightWhiteColor,
            borderRadius: BorderRadius.all(
                Radius.circular(13)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: HelperColor.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,top: 10,bottom: 10),
                child: Text("Confirm Selection",
                    textAlign: TextAlign.left,
                    style: HelperStyle.textStyle(context, HelperColor.black, 20.sp, FontWeight.w500)
                ),
              ),
              DeliveryAddressDetailsWidget(
                deliveryReceiverState: deliveryReceiverState!,
              ),
              const SizedBox(
                height: 10,
              ),
              DeliveryDetailsWidget(
                deliveryReceiverState: deliveryReceiverState!,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
                child:ButtonWidget(
                  buttonTextSize: 18,
                  containerHeight: 47.h,
                  containerWidth: 341.w,
                  buttonText: "Find Driver",
                  color: HelperColor.primaryColor,
                  textColor:HelperColor.slightWhiteColor,
                  onTap:voidCallback!,
                  radius: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DeliveryAddressDetailsWidget extends StatelessWidget {
  final DeliveryReceiverState deliveryReceiverState;

  const DeliveryAddressDetailsWidget({Key? key, required this.deliveryReceiverState})
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
              DeliveryColumnWidget(
                title: 'Pick Up Address',
                value: deliveryReceiverState.dataFrom[0]['name'] ?? '',
              ),
              const Divider(),
              DeliveryColumnWidget(
                title: 'Drop Off Address',
                value: deliveryReceiverState.dataTo[0]['name'] ?? '',
              ),
            ],
          ),
        )
    );
  }
}

class DeliveryDetailsWidget extends StatelessWidget {
  final DeliveryReceiverState deliveryReceiverState;

  const DeliveryDetailsWidget({Key? key, required this.deliveryReceiverState})
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
              DeliveryColumnWidget(
                title: 'Receiver Name',
                value: deliveryReceiverState.userModel?.name ?? '',
              ),
              const Divider(),
              DeliveryColumnWidget(
                title: 'Receiver Phone Number',
                value: deliveryReceiverState.userModel?.phoneNumber ?? '',
              ),
              const Divider(),
              DeliveryColumnWidget(
                title: 'Category',
                value: deliveryReceiverState.categoryMethod.text ?? '',
              ),
              const Divider(),
              DeliveryColumnWidget(
                title: 'Payment Method',
                value: deliveryReceiverState.paymentMethod.text ,
              ),
              const Divider(),
              DeliveryColumnWidget(
                title: 'Payment By',
                value: deliveryReceiverState.whoIsPaying.text ,
              ),
              const Divider(),
              DeliveryColumnWidget(
                title: 'Amount',
                value: HelperConfig.currencyFormat(deliveryReceiverState.deliveryUserRequest?.estimatedPrice.toString() ?? ''),
              ),
              const SizedBox(height: 10,)
            ],
          ),
        )
    );
  }
}

class DeliveryColumnWidget extends StatelessWidget {
  final String? title, value;
  const DeliveryColumnWidget({Key? key, required this.title, required this.value})
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


class DeliveryLoadingScreen extends StatelessWidget {
  final VoidCallback? voidCallback;
  final DeliveryReceiverState? deliveryReceiverState;
  const DeliveryLoadingScreen({Key? key,this.voidCallback,this.deliveryReceiverState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: voidCallback,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            //padding: const EdgeInsets.all(15.0),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(13)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child:Lottie.asset('assets/json/find_driver.json',
                    height: 200,
                    width: 200,
                  ),
                ),
                SizedBox(height: 20.h),
                Text("Looking for dispatch riders around you",style: HelperStyle.textStyle(context, Colors.black, 13.sp, FontWeight.bold)),
                const SizedBox(height: 4,),
                Text("Scanning for nearby dispatch riders",style: HelperStyle.textStyle(context, Colors.black, 12, FontWeight.w300),),
                const SizedBox(height: 10,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}