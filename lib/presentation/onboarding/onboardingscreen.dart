import 'package:acoride/core/helper/helper_config.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboard/flutter_onboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/helper/helper_color.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final PageController _pageController = PageController();

  late SharedPreferences prefs;

  @override
  void initState() {
    // TODO: implement initState
    getSharedPreferences();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  getSharedPreferences () async
  {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    var sizeWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: OnBoard(
        pageController: _pageController,
        // Either Provide onSkip Callback or skipButton Widget to handle skip state
        onSkip: () {
          // print('skipped');
        },
        // Either Provide onDone Callback or nextButton Widget to handle done state
        onDone: () {
          // print('done tapped');
        },
        onBoardData: onBoardData,
        descriptionStyles: HelperStyle.textStyle(
            context, Colors.black, 25, FontWeight.normal),
        pageIndicatorStyle: const PageIndicatorStyle(
          width: 100,
          inactiveColor: HelperColor.black,
          activeColor: HelperColor.primaryColor,
          inactiveSize: Size(8, 8),
          activeSize: Size(12, 12),
        ),
        // Either Provide onSkip Callback or skipButton Widget to handle skip state
        skipButton: TextButton(
          onPressed: () {
            // print('skipButton pressed');
          },
          child: Text(
            "Skip",
            style: HelperStyle.textStyle(
                context, Colors.black, 17, FontWeight.normal),
          ),
        ),
        // Either Provide onDone Callback or nextButton Widget to handle done state
        nextButton: OnBoardConsumer(
          builder: (context, ref, child) {
            final state = ref.watch(onBoardStateProvider);
            return InkWell(
              onTap: () => _onNextTap(state),
              child: Container(
                width: sizeWidth - 50,
                height: 55,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: HelperColor.black,
                ),
                child: Text(
                  state.isLastPage ? "Continue" : "Next",
                  style:const TextStyle(
                    color: HelperColor.primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onNextTap(OnBoardState onBoardState) {
    if (!onBoardState.isLastPage) {
      _pageController.animateToPage(
        onBoardState.page + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOutSine,
      );
    } else {
      //prefs.setString("ONBOARDING", 'true');
      // Navigator.push(
      //   context,
      //   CupertinoPageRoute(
      //     builder: (context) => const BaseAuthController(),
      //   ),
      // );
    }
  }
}

final List<OnBoardModel> onBoardData = [
   OnBoardModel(
    title: "",
    description:
    "We provide profession bike-hailing services for you",
    imgUrl: HelperConfig.getPngImage('sliderOne')
  ),
  OnBoardModel(
    title: "",
    description:"Your Safety is our priority",
    imgUrl: HelperConfig.getPngImage('sliderOne')
  ),
  OnBoardModel(
    title: "",
    description:"Let's make your day great with Acoride bike-hailing services",
    imgUrl: HelperConfig.getPngImage('sliderOne')
  ),
];