import 'package:acoride/core/helper/helper_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/helper/helper_style.dart';

class DashBoardDelivery extends StatelessWidget {
  final VoidCallback? onTap;
  const DashBoardDelivery({Key? key,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 80,
        padding: const EdgeInsets.all(10).r,
        margin: const EdgeInsets.only(left: 10,right: 20).r,
        decoration: BoxDecoration(
          color: HelperColor.primaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child:ListTile(
          leading: Image.asset('assets/images/van.png'),
          title: Text(
            'Delivery',
            style: HelperStyle.textStyleTwo(context, Colors.black, 16, FontWeight.w400),
          ),
          subtitle: Text(
              'Get your delivery in 30 minutes',
              style: HelperStyle.textStyleTwo(context, Colors.black, 13, FontWeight.normal)
          ),
        ),
      )
    );
  }
}