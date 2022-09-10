import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileWidgetOne extends StatelessWidget {
  const ProfileWidgetOne({
    Key? key,

    required this.firstIcon,
    required this.lastIcon,
    this.hasLastIcon = false,
    required this.text,
    this.lastText = '',
    this.onTap
  }) : super(key: key);

  final IconData? firstIcon;
  final IconData lastIcon;
  final bool hasLastIcon;
  final String text;
  final String lastText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            firstIcon,
            size: 20,
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child:Text(text,
                style:HelperStyle.textStyleTwo(
                    context, HelperColor.black, 15.sp, FontWeight.normal
                ),
              )
          ),
          const SizedBox(
            width: 20,
          ),
          hasLastIcon ?
          Icon(
            lastIcon,
            size: 20,
          ):
          Text(lastText,
            style:HelperStyle.textStyleTwo(
                context, HelperColor.black, 15.sp, FontWeight.normal
            ),
          )
        ],
      ),
    );
  }
}
