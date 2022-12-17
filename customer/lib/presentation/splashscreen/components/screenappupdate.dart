import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/presentation/components/buttonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:launch_review/launch_review.dart';


class ForceScreenUpdate extends StatelessWidget {
  final VoidCallback update;
  const ForceScreenUpdate({Key? key, required this.update})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
              margin: const EdgeInsets.only(top: 6, left: 5, right: 5),
              padding: const EdgeInsets.all(15.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(13)),
              ),
              child: Column(
                children: [
                  Center(
                    child: Text(
                        'Update Available',
                        style: HelperStyle.textStyle(context, Colors.black, 18.sp, FontWeight.w500)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                        'To continue to use FlipEx app, you must update to the latest version.',
                        style: HelperStyle.textStyle(context, const Color(0xff696F79), 14.sp, FontWeight.w300)),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ButtonWidget(
                        buttonTextSize: 16,
                        containerHeight: 50.h,
                        containerWidth: 341.w,
                        buttonText: "Update Now",
                        color: HelperColor.primaryColor,
                        textColor: Colors.white,
                        onTap: () async {
                          LaunchReview.launch(androidAppId: "com.app.flipex",
                              iOSAppId: "");
                        }, radius: 30,
                      ),
                      SizedBox(height: 20.sp),
                    ],
                  ),
                ],
              )),
        ));
  }
}

class SoftScreenUpdate extends StatelessWidget {
  final VoidCallback update,cancel;
  const SoftScreenUpdate({Key? key, required this.update, required this.cancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
              margin: const EdgeInsets.only(top: 6, left: 5, right: 5),
              padding: const EdgeInsets.all(15.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(13)),
              ),
              child: Column(
                children: [
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     Text(
                         'Update Available',
                         textAlign: TextAlign.center,
                         style: HelperStyle.textStyle(context, Colors.black, 18.sp, FontWeight.w500)),
                   ],
                 ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                        'To continue to use Acoride app, you must update to the latest version.',
                        textAlign: TextAlign.center,
                        style: HelperStyle.textStyle(context, const Color(0xff696F79), 14.sp, FontWeight.w300)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ButtonWidget(
                        buttonTextSize: 16,
                        containerHeight: 50.h,
                        containerWidth: 341.w,
                        buttonText: "Update Now",
                        color: HelperColor.primaryColor,
                        textColor: Colors.white,
                        onTap: update,
                        radius: 30,
                      ),
                      SizedBox(height: 10.sp),
                      GestureDetector(
                        onTap: cancel,
                        child: Text("Update Later",style: HelperStyle.textStyle(context, Colors.black, 14.sp, FontWeight.w400),),
                      )
                    ],
                  ),
                ],
              )),
        ));
  }
}

class AppMaintenance extends StatelessWidget {
  final VoidCallback update;
  const AppMaintenance({Key? key, required this.update})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
              margin: const EdgeInsets.only(top: 6, left: 5, right: 5),
              padding: const EdgeInsets.all(15.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(13)),
              ),
              child: Column(
                children: [
                  Center(
                    child: Text(
                        'Update Available',
                        style: HelperStyle.textStyle(context, Colors.black, 18.sp, FontWeight.w500)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                        'To continue to use FlipEx app, you must update to the latest version.',
                        style: HelperStyle.textStyle(context, const Color(0xff696F79), 14.sp, FontWeight.w300)),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ButtonWidget(
                        buttonTextSize: 16,
                        containerHeight: 50.h,
                        containerWidth: 341.w,
                        buttonText: "Update Now",
                        color: HelperColor.primaryColor,
                        textColor: Colors.white,
                        onTap:update,
                        radius: 30,
                      ),
                      SizedBox(height: 20.sp),
                    ],
                  ),
                ],
              )),
        ));
  }
}