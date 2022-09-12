import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/logic/cubits/map_cubit.dart';
import 'package:acoride/logic/states/map_state.dart';
import 'package:acoride/presentation/components/buttonWidget.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/constant/enum.dart';
import '../../core/helper/helper_style.dart';

class OrderReceiptScreen extends StatefulWidget {

  final List<Map<String, dynamic>> dataFrom;
  final List<Map<String, dynamic>> dataTo;

  const OrderReceiptScreen({Key? key,required this.dataFrom, required this.dataTo}) : super(key: key);

  @override
  State<OrderReceiptScreen> createState() => _OrderReceiptScreenState();
}

class _OrderReceiptScreenState extends State<OrderReceiptScreen> {

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
                            height: MediaQuery.of(context).size.height - 390.h,
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Ride Receipt", style: HelperStyle.textStyleTwo(context, HelperColor.black, 17, FontWeight.w600),),
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Pick Up Address", style: HelperStyle.textStyleTwo(context, HelperColor.black, 14, FontWeight.w600),),
                                    Text("Ride Receipt", style: HelperStyle.textStyleTwo(context, HelperColor.black, 11, FontWeight.normal),),
                                    const SizedBox(height: 10,),
                                    Text("Destination Address", style: HelperStyle.textStyleTwo(context, HelperColor.black, 14, FontWeight.w600),),
                                    Text("Ride Receipt", style: HelperStyle.textStyleTwo(context, HelperColor.black, 11, FontWeight.normal),),
                                    const SizedBox(height: 6,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Payment Type", style: HelperStyle.textStyleTwo(context, HelperColor.black, 14, FontWeight.w600),),
                                        Text("Cash", style: HelperStyle.textStyleTwo(context, HelperColor.black, 11, FontWeight.normal),),
                                      ],
                                    ),
                                    const SizedBox(height: 6,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Amount", style: HelperStyle.textStyleTwo(context, HelperColor.black, 14, FontWeight.w600),),
                                        Text("500", style: HelperStyle.textStyleTwo(context, HelperColor.black, 11, FontWeight.normal),),
                                      ],
                                    ),
                                    const SizedBox(height: 6,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Distance Cover", style: HelperStyle.textStyleTwo(context, HelperColor.black, 14, FontWeight.w600),),
                                        Text("500", style: HelperStyle.textStyleTwo(context, HelperColor.black, 11, FontWeight.normal),),
                                      ],
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20,),
                                ButtonWidget(
                                  buttonTextSize: 20,
                                  containerHeight: 47.h,
                                  containerWidth: MediaQuery.of(context).size.width - 50,
                                  buttonText: "Continue",
                                  color: HelperColor.primaryColor,
                                  textColor: HelperColor.fillColor,
                                  onTap: (){
                                    context.read<MapCubit>().loadingAndWaitingForDriver();
                                  },
                                  radius: 30,
                                ),
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