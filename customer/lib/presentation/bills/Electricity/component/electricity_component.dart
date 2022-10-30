import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/data/model/bill_model.dart';
import 'package:acoride/logic/states/bills_state.dart';
import 'package:acoride/presentation/components/buttonWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/helper/helper_config.dart';

class ShimmersWidget extends StatelessWidget {
  const ShimmersWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade200,
      highlightColor: Colors.white.withAlpha(50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            height: 80,
            width: 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: 'https://i1.wp.com/www.slntechnologies.com/wp-content/uploads/2017/08/ef3-placeholder-image.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AirtimeWidget extends StatelessWidget {
  final BillModel billModel;
  final VoidCallback onTap;
  final int? value,selected;
  const AirtimeWidget({
    Key? key,
    required this.billModel,
    this.value,
    this.selected,
    required this.onTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                color: value == selected?Colors.black:Colors.transparent,
                width: value == selected?2:5,
              ),
            ),
            height: 65,
            width: 65,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: CachedNetworkImage(
                imageUrl: billModel.image!,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                const SpinKitRing(
                  color: Color(0xFF2EA445),
                  lineWidth: 1.0,
                  size: 50.0,
                ),
                errorWidget: (context, url, error) =>
                const Icon(Icons.error),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ElectricityComponent extends StatelessWidget {
  final BillState billState;
  final VoidCallback onTap, onCancel;
  const ElectricityComponent({
    Key? key,
    required this.billState,
    required this.onTap,
    required this.onCancel,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child:SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            margin: const EdgeInsets.only(top: 6,left: 5,right: 5),
            padding: const EdgeInsets.all(15.0),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Transaction Summary',
                      textAlign: TextAlign.center,
                      style: HelperStyle.textStyle(
                          context, Colors.black, 14, FontWeight.bold),
                    ),

                    GestureDetector(
                        onTap: onCancel,
                        child: const Icon(Icons.cancel,size: 25,)
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                Container(
                  // padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Color(0xffe6efbc),
                      borderRadius: BorderRadius.all(Radius.circular(8))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child:Column(
                            children: [
                              const SizedBox(height: 20,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Network',
                                    style: HelperStyle.textStyle(
                                        context, const Color(0xff696F79), 14.sp, FontWeight.w400),
                                  ),

                                  Text('${billState.selectedBill!.name}',
                                    style: HelperStyle.textStyle(
                                        context, const Color(0xff3F4B69), 12, FontWeight.w400),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Name',
                                    style: HelperStyle.textStyle(
                                        context, const Color(0xff696F79), 14.sp, FontWeight.w400),
                                  ),

                                  Text(billState.smartCardName ?? '',
                                    style: HelperStyle.textStyle(
                                        context, const Color(0xff3F4B69), 12, FontWeight.w400),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Meter Card Number',
                                    style: HelperStyle.textStyle(
                                        context, const Color(0xff696F79), 14.sp, FontWeight.w400),
                                  ),

                                  Text(billState.smartNumber.text,
                                    style: HelperStyle.textStyle(
                                        context, const Color(0xff3F4B69), 12, FontWeight.w400),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Phone Number',
                                    style: HelperStyle.textStyle(
                                        context, const Color(0xff696F79), 14.sp, FontWeight.w400),
                                  ),

                                  Text(billState.phone.text,
                                    style: HelperStyle.textStyle(
                                        context, const Color(0xff3F4B69), 12, FontWeight.w400),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Amount',
                                    style: HelperStyle.textStyle(
                                        context, const Color(0xff696F79), 14.sp, FontWeight.w400),
                                  ),

                                  Text("${HelperConfig.currencyFormat(billState.amount.text.toString())}",
                                    style: HelperStyle.textStyle(
                                        context, const Color(0xff3F4B69), 12, FontWeight.w400),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10,),
                            ],
                          )
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                ButtonWidget(
                  buttonTextSize: 18,
                  containerHeight: 47.h,
                  containerWidth: 341.w,
                  buttonText: "Buy Electricity",
                  color: HelperColor.primaryColor,
                  textColor:HelperColor.slightWhiteColor,
                  onTap: onTap,
                  radius: 30,

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}