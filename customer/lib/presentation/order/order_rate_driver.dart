import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_config.dart';
import 'package:acoride/data/model/ride_request_model.dart';
import 'package:acoride/logic/cubits/rate_cubit.dart';
import 'package:acoride/logic/states/rate_state.dart';
import 'package:acoride/presentation/components/buttonWidget.dart';
import 'package:acoride/presentation/components/form_widget_screen.dart';
import 'package:acoride/presentation/home/bottom_screen.dart';
import 'package:acoride/utils/blurry_modal_profress_hud.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/helper/helper_style.dart';

class OrderRateDriver extends StatefulWidget {

  final RideRequestModel rideRequestModel;
  final int amountToPay;
  const OrderRateDriver({Key? key,required this.rideRequestModel,required this.amountToPay}) : super(key: key);

  @override
  State<OrderRateDriver> createState() => _OrderRateDriverState();
}

class _OrderRateDriverState extends State<OrderRateDriver> {

  String paymentType = 'Wallet';
  double value = 3.5;

  @override
  void initState() {
    print("objectobject ${widget.rideRequestModel.passengerId}");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RateCubit>(
      create: (context) => RateCubit(RateState(rideRequestModel: widget.rideRequestModel)),
      child: Scaffold(
        backgroundColor: HelperColor.primaryColor,
        body: SafeArea(
          child: BlocBuilder<RateCubit, RateState>(
            builder: (rideContext, rateState) {
              return BlurryModalProgressHUD(
                inAsyncCall: rateState.isLoading,
                child: BlocListener<RateCubit, RateState>(
                  listener: (context, state) async {
                    if (rateState.hasError!) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RootBottom(),
                        ),
                      );
                    }
                  },
                  child: ListView(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).size.height * 0.4,
                                child:Container(
                                  color: HelperColor.primaryColor,
                                  child: Center(
                                    child: Text(
                                        'Thank You For Riding With Us',
                                        textAlign: TextAlign.center,
                                        style: HelperStyle.textStyleTwo(context, HelperColor.slightWhiteColor, 35, FontWeight.w600)
                                    ),
                                  ),
                                )
                              ),
                            ],
                          ),
                          SingleChildScrollView(
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              decoration: const BoxDecoration(
                                color: HelperColor.slightWhiteColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25),
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(20.0),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.only(left: 10, right: 10, top: 5),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text("How was your ride?", style: HelperStyle.textStyleTwo(context, HelperColor.black, 17, FontWeight.w600),),
                                            SizedBox(height: 20.h,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text("Amount", style: HelperStyle.textStyleTwo(context, HelperColor.black, 16, FontWeight.w600),),
                                                Text("${HelperConfig.currencyFormat(widget.amountToPay.toString())}", style: HelperStyle.textStyleTwo(context, HelperColor.black, 20, FontWeight.w600),),
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
                                          ClipOval(
                                              child: SizedBox(
                                                height: 50,
                                                child: CachedNetworkImage(
                                                  imageUrl: rateState.rideRequestModel?.user?.name ?? '',
                                                  placeholder: (context, url) => const CircularProgressIndicator(),
                                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                                ),
                                              )
                                          ),
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
                                              Text('${rateState.rideRequestModel?.user?.name} ',style: HelperStyle.textStyle(context, HelperColor.black, 12, FontWeight.w400),),
                                              const SizedBox(height: 2,),
                                              Text('${rateState.rideRequestModel?.user?.rate}',style: HelperStyle.textStyle(context, HelperColor.black.withOpacity(0.5), 11, FontWeight.w400),),
                                              const SizedBox(height: 2,),
                                              Text('Trips: ${rateState.rideRequestModel?.user?.totalRide}',style: HelperStyle.textStyle(context, HelperColor.black.withOpacity(0.5), 11, FontWeight.w400),),
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
                                      value: rateState.rating ?? 0.0,
                                      onValueChanged: (v) {
                                        rideContext.read<RateCubit>().selectRating(v);
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
                                    FormTextPrefixWithValidation(
                                      hintText: 'A little Comment',
                                      textInputType: TextInputType.text,
                                      controller:rateState.commentController,
                                      decoration:  InputDecoration(
                                        filled: true,
                                        fillColor: HelperColor.fillColor,
                                        border: const OutlineInputBorder(),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(color: HelperColor.primaryLightColor, width: 1)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: HelperColor.primaryLightColor, width: 1.0),
                                        ),
                                        // contentPadding: const EdgeInsets.all(5),
                                      ),
                                    ),
                                    const SizedBox(height: 20,),
                                    ButtonWidget(
                                      buttonTextSize: 20,
                                      containerHeight: 47.h,
                                      containerWidth: MediaQuery.of(context).size.width,
                                      buttonText: "Continue",
                                      color: HelperColor.primaryColor,
                                      textColor: HelperColor.primaryLightColor,
                                      onTap: (){
                                        rideContext.read<RateCubit>().rate();
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