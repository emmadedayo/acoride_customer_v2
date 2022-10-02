import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/logic/states/bills_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/helper/helper_color.dart';
import '../../../components/buttonWidget.dart';

class DataConfirmation extends StatelessWidget {
  final BillState billState;
  final VoidCallback onTap, onCancel;
  const DataConfirmation({
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

                                  Text("₦ ${billState.amount.text}",
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
                  buttonText: "Buy Data",
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