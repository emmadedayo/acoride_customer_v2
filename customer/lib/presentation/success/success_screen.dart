import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../components/buttonWidget.dart';

class SuccessScreen extends StatelessWidget {
  final String message;
  final bool hasButton;
  final VoidCallback? onPressed;
  const SuccessScreen({
    Key? key,
    required this.message,
    this.hasButton = false,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child:Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 80.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Lottie.asset('assets/json/success.json',
                      height: 250,
                      width: 300,
                    ),
                  ],
                ),


                SizedBox(height: ScreenUtil().screenHeight * 0.03),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                        child: Text(
                          message,
                          style: HelperStyle.textStyle(context,HelperColor.black,20.sp,FontWeight.normal),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: ScreenUtil().screenHeight * 0.03),
                ButtonWidget(
                    buttonTextSize: 15,
                    containerHeight: 42.h,
                    containerWidth: MediaQuery.of(context).size.width - 50,
                    radius: 60,
                    buttonText: "Continue",
                    color: HelperColor.primaryColor,
                    textColor: Colors.white,
                    onTap: onPressed!
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
