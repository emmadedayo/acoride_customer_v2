import 'package:acoride/core/helper/helper_color.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.discreteCircle(
      color: HelperColor.primaryColor,
      secondRingColor: HelperColor.fillColor,
      thirdRingColor: HelperColor.secondaryColor,
      size: 50,
    );
  }
}