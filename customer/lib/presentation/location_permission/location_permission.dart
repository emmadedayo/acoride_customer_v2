import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/helper/helper_color.dart';
import '../../core/helper/helper_config.dart';
import '../../core/helper/helper_style.dart';
import '../../utils/screen_utils.dart';
import '../components/buttonWidget.dart';
import '../router/router_constant.dart';

class LocationPermission extends StatefulWidget {
  const LocationPermission({Key? key}) : super(key: key);

  @override
  LocationPermissionState createState() => LocationPermissionState();
}


class LocationPermissionState extends State<LocationPermission> {
  @override
  Widget build(BuildContext context) {
    ScreenUtils().init(context);
    return PlatformScaffold(
      iosContentPadding: false,
      iosContentBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: PlatformAppBar(
        backgroundColor: Colors.white,
        material: (_, __) => MaterialAppBarData(
          elevation: 0,
          iconTheme: const IconThemeData(
            color: HelperColor.black,
          ),
        ),
        title: Text(
          '',
          style: HelperStyle.textStyleTwo(
              context, HelperColor.black, 18, FontWeight.w500),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: SizedBox(
                height: ScreenUtil().screenHeight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 40.h),
                    Padding(
                      padding: const EdgeInsets.only(left: 15,right: 15).r,
                      child: Image.asset(
                        HelperConfig.getPngImage('location'),
                        fit: BoxFit.cover,
                        height: 250.h,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(30).r,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Enabling your location',
                              style: HelperStyle.textStyleTwo(
                                  context, HelperColor.black, 22.sp, FontWeight.w600),
                            ),
                            const SizedBox(height: 30),
                            Text(
                              'Acoride will like to use your location services to find you a nearby driver.',
                              textAlign: TextAlign.center,
                              style: HelperStyle.textStyleTwo(
                                  context, HelperColor.black, 18.sp, FontWeight.normal),
                            ),
                            SizedBox(height: 30.h),
                            ButtonWidget(
                              buttonTextSize: 20,
                              containerHeight: 50.h,
                              containerWidth: 341.w,
                              buttonText: "Continue",
                              color: HelperColor.primaryColor,
                              textColor: HelperColor.primaryLightColor,
                              onTap: () async {
                                if(await HelperConfig.determinePosition()){
                                  Navigator.of(context).pushNamedAndRemoveUntil(baseAuthScreen, (route) => false);
                                }else{

                                }
                              },
                              radius: 8,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
          )
      ),
    );
  }
}