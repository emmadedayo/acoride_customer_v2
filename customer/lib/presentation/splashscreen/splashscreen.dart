import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../logic/states/app_state.dart';

class SplashScreen extends StatefulWidget {
  final AppState? appState;
  const SplashScreen({
    required this.appState,
    Key? key,
  }) : super(key: key);

  @override
  SuccessFullScreenState createState() => SuccessFullScreenState();
}


class SuccessFullScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
        backgroundColor: HelperColor.primaryColor,
        body: WillPopScope(
          onWillPop: () async => false,
          child: SafeArea(
            child: Center(
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText('Acoride',
                        textStyle: HelperStyle.textStyle(context,HelperColor.whiteColor,30*2,FontWeight.w600,letterSpacing: 1.6),
                      ),
                    ],
                    isRepeatingAnimation: false,
                    onTap: () {
                      print("Tap Event");
                    },
                  ),
                ],
              )
            )
          ),
        )
    );
  }
}