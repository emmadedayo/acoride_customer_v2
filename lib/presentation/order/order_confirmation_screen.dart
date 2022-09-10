import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/logic/cubits/map_cubit.dart';
import 'package:acoride/logic/states/map_state.dart';
import 'package:acoride/presentation/components/buttonWidget.dart';
import 'package:acoride/presentation/order/order_rate_driver.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:share_plus/share_plus.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import '../../core/constant/enum.dart';
import '../../core/helper/helper_style.dart';
import 'order_payment_screen.dart';

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
                            height: MediaQuery.of(context).size.height - 250.h,
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
                        child: Column(
                          children: [
                            Visibility(
                              visible: false,
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
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("Distance: ", style: HelperStyle.textStyleTwo(context, HelperColor.black, 14, FontWeight.w600),),

                                          Text(state.distance, style: HelperStyle.textStyleTwo(context, HelperColor.black, 14, FontWeight.normal),),
                                        ],
                                      ),
                                      const Divider(),
                                      Container(
                                        padding: const EdgeInsets.all(15),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(Icons.location_searching),
                                                const SizedBox(width: 30,),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text("My Current Location", style: HelperStyle.textStyleTwo(context, HelperColor.black, 15, FontWeight.w600),),
                                                    const SizedBox(height: 5,),
                                                    Text(state.dataFrom[0]['name'], style: HelperStyle.textStyleTwo(context, HelperColor.black, 14, FontWeight.normal),),
                                                  ],
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 20,),
                                            Row(
                                              children: [
                                                const Icon(Icons.location_searching),
                                                const SizedBox(width: 30,),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text("My Drop Off Location", style: HelperStyle.textStyleTwo(context, HelperColor.black, 15, FontWeight.w600),),
                                                    const SizedBox(height: 5,),
                                                    Text(state.dataFrom[0]['name'], style: HelperStyle.textStyleTwo(context, HelperColor.black, 14, FontWeight.normal),),
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
                                         context.read<MapCubit>().loadingAndWaitingForDriver();
                                        },
                                        radius: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              //state.confirmToOrder
                              visible: false,
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Connecting you to a driver...", style: HelperStyle.textStyleTwo(context, HelperColor.black, 16.sp, FontWeight.w600),),
                                      const Divider(),
                                      Container(
                                        padding: const EdgeInsets.all(15),
                                        height: 120,
                                        child: RippleAnimation(
                                            repeat: true,
                                            color: HelperColor.primaryColor,
                                            minRadius: 30,
                                            ripplesCount: 6,
                                            child: Container()
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      Center(
                                        child: Text("We are looking for a nearby driver to accept your ride. Once accepted, you can ride with us!  \n We value your patience.", style: HelperStyle.textStyleTwo(context, HelperColor.black, 13.sp, FontWeight.normal),textAlign: TextAlign.center,),
                                      ),
                                      const SizedBox(height: 20,),
                                      ButtonWidget(
                                        buttonTextSize: 20,
                                        containerHeight: 47.h,
                                        containerWidth: MediaQuery.of(context).size.width - 20,
                                        buttonText: "Cancel",
                                        color: HelperColor.primaryColor,
                                        textColor: HelperColor.primaryLightColor,
                                        onTap: (){
                                          // Navigator.push(
                                          //   context,
                                          //   MaterialPageRoute(
                                          //     builder: (context) => const RegisterScreenController(),
                                          //   ),
                                          // );
                                        },
                                        radius: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: false,
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: Container(
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
                                          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                                          margin: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Driver Found", style: HelperStyle.textStyleTwo(context, HelperColor.black, 17, FontWeight.w600),),

                                              Text(state.distance, style: HelperStyle.textStyleTwo(context, HelperColor.black, 14, FontWeight.normal),),
                                            ],
                                          )
                                      ),
                                      const Divider(),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
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
                                      Container(
                                        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ButtonWidget(
                                              buttonTextSize: 20,
                                              containerHeight: 47.h,
                                              containerWidth: 140,
                                              buttonText: "Confirm",
                                              color: HelperColor.primaryColor,
                                              textColor: HelperColor.primaryLightColor,
                                              onTap: (){
                                                context.read<MapCubit>().loadingAndWaitingForDriver();
                                              },
                                              radius: 30,
                                            ),

                                            MaterialButton(
                                              onPressed: () {},
                                              color: HelperColor.primaryColor.withOpacity(0.7),
                                              textColor: Colors.white,
                                              padding: const EdgeInsets.all(16),
                                              shape: const CircleBorder(),
                                              child: const Icon(
                                                Iconsax.call,
                                                size: 24,
                                              ),
                                            ),

                                            MaterialButton(
                                              onPressed: () {},
                                              color: HelperColor.redColor.withOpacity(0.9),
                                              textColor: Colors.white,
                                              padding: const EdgeInsets.all(16),
                                              shape: const CircleBorder(),
                                              child: const Icon(
                                                Icons.cancel,
                                                size: 24,
                                              ),
                                            )
                                          ],
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: false,
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: Container(
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
                                          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                                          margin: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Driver is Arriving ....", style: HelperStyle.textStyleTwo(context, HelperColor.black, 17, FontWeight.w600),),

                                              Text('3 mins', style: HelperStyle.textStyleTwo(context, HelperColor.black, 14, FontWeight.normal),),
                                            ],
                                          )
                                      ),
                                      const Divider(),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
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
                                      Container(
                                        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [

                                            ButtonWidget(
                                              buttonTextSize: 20,
                                              containerHeight: 47.h,
                                              containerWidth: 140,
                                              buttonText: "Cancel",
                                              color: HelperColor.redColor.withOpacity(0.9),
                                              textColor: HelperColor.primaryLightColor,
                                              onTap: (){
                                                context.read<MapCubit>().loadingAndWaitingForDriver();
                                              },
                                              radius: 30,
                                            ),

                                            MaterialButton(
                                              onPressed: () {},
                                              color: HelperColor.lightGreen,
                                              textColor: Colors.white,
                                              padding: const EdgeInsets.all(16),
                                              shape: const CircleBorder(),
                                              child: const Icon(
                                                Iconsax.call,
                                                size: 24,
                                              ),
                                            ),

                                            MaterialButton(
                                              onPressed: () {},
                                              color: HelperColor.lightGreen,
                                              textColor: Colors.white,
                                              padding: const EdgeInsets.all(16),
                                              shape: const CircleBorder(),
                                              child: const Icon(
                                                Iconsax.share,
                                                size: 24,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: true,
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: Container(
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
                                          margin: const EdgeInsets.all(10.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Arriving in ", style: HelperStyle.textStyleTwo(context, HelperColor.black, 17, FontWeight.w600),),

                                              Text('3 mins', style: HelperStyle.textStyleTwo(context, HelperColor.black, 14, FontWeight.normal),),
                                            ],
                                          )
                                      ),
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
                                      Container(
                                        padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [

                                            ButtonWidget(
                                              buttonTextSize: 20,
                                              containerHeight: 47.h,
                                              containerWidth: MediaQuery.of(context).size.width -140.w,
                                              buttonText: "Home",
                                              color: HelperColor.black.withOpacity(0.9),
                                              textColor: HelperColor.primaryLightColor,
                                              onTap: (){
                                                Navigator.of(context).push(MaterialPageRoute(
                                                  builder: (context) => OrderRateDriver(
                                                    dataFrom: widget.dataFrom,
                                                    dataTo: widget.dataTo,
                                                  ),
                                                ));
                                              },
                                              radius: 30,
                                            ),

                                            MaterialButton(
                                              onPressed: () {
                                                Share.share('check out my website https://example.com');
                                              },
                                              color: HelperColor.lightGreen,
                                              textColor: Colors.white,
                                              padding: const EdgeInsets.all(16),
                                              shape: const CircleBorder(),
                                              child: const Icon(
                                                Iconsax.share,
                                                size: 24,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
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