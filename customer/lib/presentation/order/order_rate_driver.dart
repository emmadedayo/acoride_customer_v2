import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/logic/cubits/map_cubit.dart';
import 'package:acoride/logic/states/map_state.dart';
import 'package:acoride/presentation/components/buttonWidget.dart';
import 'package:acoride/presentation/order/order_receipt_screen.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/constant/enum.dart';
import '../../core/helper/helper_style.dart';

class OrderRateDriver extends StatefulWidget {

  final List<Map<String, dynamic>> dataFrom;
  final List<Map<String, dynamic>> dataTo;

  const OrderRateDriver({Key? key,required this.dataFrom, required this.dataTo}) : super(key: key);

  @override
  State<OrderRateDriver> createState() => _OrderRateDriverState();
}

class _OrderRateDriverState extends State<OrderRateDriver> {

  String paymentType = 'Wallet';
  double value = 3.5;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MapCubit>(
      create: (context) => MapCubit(MapState(dataFrom: widget.dataFrom, dataTo: widget.dataTo)),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<MapCubit, MapState>(
            builder: (context, state) {
              return BlurryModalProgressHUD(
                inAsyncCall: state.positionLoading == CustomState.LOADING,
                child: BlocListener<MapCubit, MapState>(
                  listener: (context, state) async {
                    // if (state.isSuccess) {
                    //   Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => const BaseAuthController(),
                    //     ),
                    //   );
                    // }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Stack(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height - 380.h,
                            child:state.position == null?
                            const CircularProgressIndicator(
                              color: Colors.red,
                            ):
                            GoogleMap(
                              onMapCreated: (GoogleMapController controller) {
                                context.read<MapCubit>().onMapCreated(controller);
                              },
                              markers: state.markers,
                              polylines: state.polyLines,
                              zoomControlsEnabled: false,
                              myLocationButtonEnabled: false,
                              myLocationEnabled: true,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                    state.position != null ? state.position!.latitude : state.lastKnownPositions!.latitude ?? state.position!.latitude,
                                    state.position != null ? state.position!.longitude : state.lastKnownPositions!.longitude ?? state.position!.longitude),
                                zoom: 17,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                          child: Container(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              padding: const EdgeInsets.all(20.0),
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white.withOpacity(0.9),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Rate Driver", style: HelperStyle.textStyleTwo(context, HelperColor.black, 17, FontWeight.w600),),
                                          const SizedBox(height: 10,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Amount", style: HelperStyle.textStyleTwo(context, HelperColor.black, 16, FontWeight.w600),),
                                              Text("NGN 500", style: HelperStyle.textStyleTwo(context, HelperColor.black, 20, FontWeight.w600),),
                                            ],
                                          ),
                                        ],
                                      )
                                  ),
                                  const SizedBox(height: 10,),
                                  const Divider(),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
                                    child: Row(
                                      children: [

                                        const CircleAvatar(
                                          radius: 25.0,
                                          backgroundImage: AssetImage('assets/images/passport.jpg'),
                                          backgroundColor: Colors.transparent,
                                        ),
                                        const SizedBox(width: 15,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('Kahman Adewale Obi ',style: HelperStyle.textStyle(context, HelperColor.black, 12, FontWeight.w400),),
                                            const SizedBox(height: 2,),
                                            Text('OG89938',style: HelperStyle.textStyle(context, HelperColor.black.withOpacity(0.5), 11, FontWeight.w400),),
                                            const SizedBox(height: 2,),
                                            Text('Trips: 983',style: HelperStyle.textStyle(context, HelperColor.black.withOpacity(0.5), 11, FontWeight.w400),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  const SizedBox(height: 10,),
                                  Text("How is your Driver?", style: HelperStyle.textStyleTwo(context, HelperColor.black, 17, FontWeight.w600,letterSpacing: 0.8),),
                                  const SizedBox(height: 3,),
                                  Text("Please rate your driver ..", style: HelperStyle.textStyleTwo(context, HelperColor.black, 11, FontWeight.normal),),
                                  const SizedBox(height: 10,),

                                  const SizedBox(height: 5,),
                                  RatingStars(
                                    value: value,
                                    onValueChanged: (v) {
                                      //
                                      setState(() {
                                        value = v;
                                      });
                                    },
                                    starBuilder: (index, color) => Icon(
                                      Icons.star_border,
                                      color: color,
                                    ),
                                    starCount: 5,
                                    starSize: 35,
                                    valueLabelColor: const Color(0xff9b9b9b),
                                    valueLabelTextStyle: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 12.0),
                                    valueLabelRadius: 10,
                                    maxValue: 5,
                                    starSpacing: 2,
                                    maxValueVisibility: true,
                                    valueLabelVisibility: false,
                                    animationDuration: const Duration(milliseconds: 1000),
                                    valueLabelPadding:
                                    const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                                    valueLabelMargin: const EdgeInsets.only(right: 8),
                                    starOffColor: const Color(0xffe7e8ea),
                                    starColor: HelperColor.primaryColor,
                                  ),
                                  const SizedBox(height: 20,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ButtonWidget(
                                        buttonTextSize: 20,
                                        containerHeight: 47.h,
                                        containerWidth: 150,
                                        buttonText: "Cancel",
                                        color: HelperColor.black.withOpacity(0.7),
                                        textColor: HelperColor.primaryLightColor,
                                        onTap: (){
                                          Navigator.of(context).push(MaterialPageRoute(
                                            builder: (context) => OrderReceiptScreen(
                                              dataFrom: widget.dataFrom,
                                              dataTo: widget.dataTo,
                                            ),
                                          ));
                                        },
                                        radius: 30,
                                      ),

                                      ButtonWidget(
                                        buttonTextSize: 20,
                                        containerHeight: 47.h,
                                        containerWidth: 150,
                                        buttonText: "Submit",
                                        color: HelperColor.primaryColor,
                                        textColor: HelperColor.primaryLightColor,
                                        onTap: (){
                                          context.read<MapCubit>().loadingAndWaitingForDriver();
                                        },
                                        radius: 30,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                      )
                    ],
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