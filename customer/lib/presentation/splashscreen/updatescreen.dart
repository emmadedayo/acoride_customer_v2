import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/presentation/components/buttonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:launch_review/launch_review.dart';
import 'package:lottie/lottie.dart';

class AppUpdateScreen extends StatefulWidget {
  const AppUpdateScreen({
    Key? key,
  }) : super(key: key);

  @override
  SuccessFullScreenState createState() => SuccessFullScreenState();
}


class SuccessFullScreenState extends State<AppUpdateScreen> {


  @override
  void initState() {
    // TODO: implement initState
   // displayText();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        body:WillPopScope(
          onWillPop: () async => false,
          child: SafeArea(
            child: ListView(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child:Column(
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).size.height * 0.2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Lottie.asset('assets/json/upgrade_app.json',
                            height: 250,
                            width: 300,
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                      Text(
                          'Update App',
                          style: HelperStyle.textStyle(context, Colors.black, 22.h, FontWeight.w500)
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        child:Text(
                            'There is a new version of the app available. Please update the app to continue using it.',
                            textAlign: TextAlign.center,
                            style:HelperStyle.textStyle(context, Colors.black, 16, FontWeight.normal)
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                      Padding(
                        padding: const EdgeInsets.only(left: 15,right: 15),
                        child: ButtonWidget(
                          buttonTextSize: 16,
                          containerHeight: 50.h,
                          containerWidth: 341.w,
                          buttonText: "Update Now",
                          color: HelperColor.primaryColor,
                          textColor: Colors.white,
                          onTap: () async {
                            LaunchReview.launch(androidAppId: "com.acoride.customer", iOSAppId: "");
                          }, radius: 30,
                        ),
                      )

                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}