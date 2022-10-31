import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../core/helper/helper_color.dart';

class NotFoundCard extends StatelessWidget {
  final String? text;
  final double height;
  const NotFoundCard(
      {Key? key,
        this.text,this.height = 200})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/no_data_found.jpg', fit: BoxFit.fill,height: height,),

          Center(
            child: Text(text!),
          ),
        ],
      ),
    );
  }
}

class NotFoundCardTwo extends StatelessWidget {
  final String? text;
  const NotFoundCardTwo(
      {Key? key,
        this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HelperColor.slightWhiteColor,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/images/no_data_found.jpg', fit: BoxFit.fill,height: 200,),

          Center(
            child: Text(text!),
          ),
        ],
      ),
    );
  }
}


class NotFoundLottie extends StatelessWidget {
  const NotFoundLottie(
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HelperColor.slightWhiteColor,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(10),
      child: Lottie.asset('assets/json/no-data-preview.json',
        height: 250,
        width: 300,
      )
    );
  }
}