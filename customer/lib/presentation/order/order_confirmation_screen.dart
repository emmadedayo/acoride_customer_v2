import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/data/model/UserModel.dart';
import 'package:acoride/logic/cubits/app_cubit.dart';
import 'package:acoride/logic/cubits/map_cubit.dart';
import 'package:acoride/logic/states/map_state.dart';
import 'package:acoride/presentation/components/buttonWidget.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';

import '../../core/constant/enum.dart';
import '../../core/helper/helper_style.dart';
import 'order_payment_screen.dart';
import 'order_trip_screen.dart';

class ConfirmRideDetails extends StatefulWidget {

  final List<Map<String, dynamic>> dataFrom;
  final List<Map<String, dynamic>> dataTo;

  const ConfirmRideDetails({Key? key,required this.dataFrom, required this.dataTo}) : super(key: key);

  @override
  State<ConfirmRideDetails> createState() => _ConfirmRideDetailsState();
}

class _ConfirmRideDetailsState extends State<ConfirmRideDetails> {

  String paymentType = 'Wallet';


  @override
  Widget build(BuildContext context) {
    UserModel user = context.read<AppCubit>().state.user!;
    return BlocProvider<MapCubit>(
      create: (context) => MapCubit(MapState(dataFrom: widget.dataFrom, dataTo: widget.dataTo,userModel: user)),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<MapCubit, MapState>(
            builder: (mapContext, mapState) {
              return BlurryModalProgressHUD(
                inAsyncCall: mapState.positionLoading == CustomState.LOADING,
                child: BlocListener<MapCubit, MapState>(
                  listener: (cubit, states) async {
                    if (mapState.rideRequestModel != null) {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => OrderTripScreen(
                              rideRequestModel: mapState.rideRequestModel!,
                            ),
                          ));
                    }
                  },
                  child:BlocBuilder<MapCubit, MapState>(
                    builder: (mapContext, mapState) {
                      return ListView(
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height - 340.h,
                                child:mapState.position == null?
                                const Center(
                                  child: CircularProgressIndicator(),
                                ):
                                GoogleMap(
                                  onMapCreated: (GoogleMapController controller) {
                                    context.read<MapCubit>().onMapCreated(controller);
                                  },
                                  markers: mapState.markers,
                                  polylines: mapState.polyLines,
                                  zoomControlsEnabled: false,
                                  myLocationButtonEnabled: false,
                                  myLocationEnabled: true,
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(
                                        mapState.position != null ? mapState.position!.latitude : mapState.lastKnownPositions!.latitude ?? mapState.position!.latitude,
                                        mapState.position != null ? mapState.position!.longitude : mapState.lastKnownPositions!.longitude ?? mapState.position!.longitude),
                                    zoom: 17,
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
                          SingleChildScrollView(
                            child: Container(
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
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text("My Current Location", style: HelperStyle.textStyleTwo(context, HelperColor.black, 12, FontWeight.normal),),
                                                            const SizedBox(height: 5,),
                                                            Text(mapState.dataFrom[0]['name'], style: HelperStyle.textStyleTwo(context, HelperColor.black, 15, FontWeight.w500),),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                    const SizedBox(height: 20,),
                                                    Row(
                                                      children: [
                                                        const Icon(Icons.location_searching),
                                                        const SizedBox(width: 20,),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Text("My Drop Off Location", style: HelperStyle.textStyleTwo(context, HelperColor.black, 12, FontWeight.normal),),
                                                            const SizedBox(height: 5,),
                                                            Text(mapState.dataTo[0]['name'], style: HelperStyle.textStyleTwo(context, HelperColor.black, 15, FontWeight.w500),),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const Divider(),
                                              const SizedBox(height: 10,),
                                              InkWell(
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
                                                        Text(paymentType, style: HelperStyle.textStyleTwo(context, HelperColor.black, 14, FontWeight.normal),),
                                                      ],
                                                    ),
                                                    const Spacer(),
                                                    const Icon(Icons.arrow_forward_ios, color: Colors.black,),
                                                  ],
                                                ),
                                                onTap: () async {
                                                  var result = await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => const SelectPaymentScreen(),
                                                    ),
                                                  );
                                                  if(result != null){
                                                    setState(() {
                                                      paymentType = result;
                                                    });
                                                    print("object $paymentType");
                                                  }
                                                },
                                              ),
                                              const SizedBox(height: 20,),
                                              ButtonWidget(
                                                buttonTextSize: 20,
                                                containerHeight: 47.h,
                                                containerWidth: MediaQuery.of(context).size.width - 20,
                                                buttonText: "Continue to Order",
                                                color: HelperColor.primaryColor,
                                                textColor: HelperColor.primaryLightColor,
                                                onTap: (){
                                                  mapContext.read<MapCubit>().loadingAndWaitingForDriver();
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
                          )
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}