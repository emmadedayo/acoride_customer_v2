import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../core/helper/helper_color.dart';
import '../../core/helper/helper_style.dart';
import '../components/buttonWidget.dart';
import '../router/router_constant.dart';


class TripDeleteScreen extends StatefulWidget {
  const TripDeleteScreen({
    Key? key,
  }) : super(key: key);

  @override
  TripDeleteScreenState createState() => TripDeleteScreenState();
}
class TripDeleteScreenState extends State<TripDeleteScreen> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        body: WillPopScope(
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
                          Lottie.asset('assets/json/sad.json',
                            height: 250,
                            width: 300,
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                              child: Text(
                                'Your trip was cancelled',
                                style: HelperStyle.textStyle(context,HelperColor.black,20,FontWeight.normal),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.10),
                      ButtonWidget(
                        buttonTextSize: 15,
                        containerHeight: 42.h,
                        containerWidth: MediaQuery.of(context).size.width - 50,
                        radius: 60,
                        buttonText: "Continue",
                        color: HelperColor.primaryColor,
                        textColor: Colors.white,
                        onTap: () async {
                          Navigator.of(context).pushNamedAndRemoveUntil(pageHome, (route) => false);
                        },
                      ),
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