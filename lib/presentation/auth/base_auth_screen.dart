import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_config.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/screen_utils.dart';
import '../components/buttonWidget.dart';

class BaseAuthScreen extends StatefulWidget {
  const BaseAuthScreen({Key? key}) : super(key: key);

  @override
  BaseAuthScreenState createState() => BaseAuthScreenState();
}


class BaseAuthScreenState extends State<BaseAuthScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return PlatformScaffold(
      iosContentPadding: false,
      iosContentBottomPadding: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(
                HelperConfig.getPngImage('landing'),
                fit: BoxFit.cover,
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(
                    20,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Welcome to Acoride',
                            style: HelperStyle.textStyleTwo(
                                context, HelperColor.black, 35, FontWeight.w600),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    const Spacer(),
                    Text(
                      'On-Demand Ride hailing Service is an online ride hailing service with efficiency, safety and affordability as its bedrock of service',
                      style: HelperStyle.textStyleTwo(
                          context, HelperColor.kTextColorAccent, 16, FontWeight.normal,letterSpacing: 1.0
                      ),
                    ),
                    const Spacer(),
                    ButtonWidget(
                      buttonTextSize: 20,
                      containerHeight: 50.h,
                      containerWidth: 341.w,
                      buttonText: "Get Started",
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
                      radius: 8,

                    ),
                    const Spacer(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}