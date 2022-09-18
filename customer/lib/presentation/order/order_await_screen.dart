import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_config.dart';
import 'package:acoride/data/model/ride_request_model.dart';
import 'package:acoride/logic/cubits/ride_request_cubit.dart';
import 'package:acoride/logic/states/ride_request_state.dart';
import 'package:acoride/presentation/cancellation/cancellation_screen.dart';
import 'package:acoride/presentation/components/buttonWidget.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import '../../core/constant/enum.dart';
import '../../core/helper/helper_style.dart';

class OrderAwaitScreen extends StatefulWidget {
  final RideRequestModel rideRequestModel;
  const OrderAwaitScreen({Key? key,required this.rideRequestModel}) : super(key: key);

  @override
  State<OrderAwaitScreen> createState() => OrderAwaitScreenState();
}

class OrderAwaitScreenState extends State<OrderAwaitScreen> {

  String paymentType = 'Wallet';

  @override
  void initState() {
    print("objectobjects ${widget.rideRequestModel.toMap()}");
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RideRequestCubit>(
      create: (context) => RideRequestCubit(RideRequestState(rideRequestModel: widget.rideRequestModel)),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<RideRequestCubit, RideRequestState>(
            builder: (mapContext, mapState) {
              return BlurryModalProgressHUD(
                inAsyncCall: mapState.positionLoading == CustomState.LOADING,
                child: BlocListener<RideRequestCubit, RideRequestState>(
                  listener: (cubit, state) async {
                    if (mapState.fireStoreModel != null) {
                     if(mapState.fireStoreModel!.deleteTrip!){
                       FlutterRingtonePlayer.play(
                         fromAsset: 'assets/sounds/beep.mp3',
                         looping: false, // Android only - API >= 28
                         volume: 0.1, // Android only - API >= 28
                         asAlarm: false, // Android only - all APIs
                       );
                       AwesomeDialog(
                           context: context,
                           dialogType: DialogType.error,
                           animType: AnimType.topSlide,
                           title: 'Warning',
                           desc: 'Your trip has been canceled by the driver',
                           dismissOnBackKeyPress: false,
                           btnOkText: 'Go Back',
                           titleTextStyle: HelperStyle.textStyle(context, HelperColor.black, 15, FontWeight.w500),
                           descTextStyle: HelperStyle.textStyle(context, HelperColor.black, 14, FontWeight.w400),
                           dismissOnTouchOutside: false,
                           barrierColor: Colors.black.withOpacity(0.2),
                           btnCancelColor: HelperColor.primaryColor,
                           btnOkOnPress: () {
                             FlutterRingtonePlayer.stop();
                           }).show();
                     }
                    }
                  },
                  child:ListView(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height/2,
                            child:mapState.position == null?
                            const Center(
                              child: CircularProgressIndicator(),
                            ):
                            GoogleMap(
                              onMapCreated: (GoogleMapController controller) {
                                mapContext.read<RideRequestCubit>().onMapCreated(controller);
                              },
                              markers: mapState.markers,
                              compassEnabled: false,
                              polylines: mapState.polyLines,
                              zoomControlsEnabled: false,
                              myLocationButtonEnabled: false,
                              scrollGesturesEnabled: true,
                              gestureRecognizers:
                              <Factory<OneSequenceGestureRecognizer>>{
                                Factory<OneSequenceGestureRecognizer>(
                                      () => EagerGestureRecognizer(),
                                ),
                              },
                              myLocationEnabled: true,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                    mapState.position != null ? mapState.position!.latitude : mapState.lastKnownPositions!.latitude ?? mapState.position!.latitude,
                                    mapState.position != null ? mapState.position!.longitude : mapState.lastKnownPositions!.longitude ?? mapState.position!.longitude),
                                zoom: 10,
                                //tilt: 10
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              margin: EdgeInsets.only(top: 20.h),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(left: 20.w),
                                      child: const Icon(
                                        Iconsax.arrow_left_2,
                                        color: Colors.black,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 20.w),
                                    child: const Icon(
                                      Iconsax.share,
                                      color: Colors.black,
                                      size: 25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.bottomCenter,
                        color: Colors.transparent,
                        child:SingleChildScrollView(
                          child: Column(
                            children: [
                              Visibility(
                                visible: true,
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
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("Awaiting Approval", style: HelperStyle.textStyleTwo(context, HelperColor.black, 14, FontWeight.w600),),

                                            Text(mapState.distance, style: HelperStyle.textStyleTwo(context, HelperColor.black, 14, FontWeight.normal),),
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
                                                          imageUrl: widget.rideRequestModel.user?.kyc?.profileImage ?? "",
                                                          placeholder: (context, url) => const CircularProgressIndicator(),
                                                          errorWidget: (context, url, error) => const Icon(Icons.error),
                                                        ),
                                                      )
                                                  ),
                                                  const SizedBox(height: 5,),
                                                  Text(HelperConfig.splitName(widget.rideRequestModel.user?.name ?? ''),style: HelperStyle.textStyle(context, HelperColor.black, 14, FontWeight.w400),),
                                                ],
                                              ),

                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  MaterialButton(
                                                    onPressed: () {
                                                      HelperConfig.makePhoneCall('tel:${widget.rideRequestModel.user?.phoneNumber ?? ''}');
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
                                                  Text('${widget.rideRequestModel.paymentType}', style: HelperStyle.textStyleTwo(context, HelperColor.black, 14, FontWeight.normal),),
                                                ],
                                              ),
                                              const Spacer(),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  Text("₦ ${widget.rideRequestModel.estimatedPrice}", style: HelperStyle.textStyleTwo(context, HelperColor.black, 15, FontWeight.w600),),
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
                                              Expanded(child: Text("${widget.rideRequestModel.passengerDestinationAddress}", style: HelperStyle.textStyleTwo(context, HelperColor.black, 15, FontWeight.normal),),)
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 16,),
                                        ButtonWidget(
                                          buttonTextSize: 20,
                                          containerHeight: 47.h,
                                          containerWidth: MediaQuery.of(context).size.width - 20,
                                          buttonText: "Cancel Ride",
                                          color: HelperColor.black,
                                          textColor: HelperColor.primaryLightColor,
                                          onTap: (){
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => CancellationScreen(
                                              rideRequestModel: widget.rideRequestModel,
                                              currentPosition: mapState.position!,
                                            )));
                                          },
                                          radius: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}