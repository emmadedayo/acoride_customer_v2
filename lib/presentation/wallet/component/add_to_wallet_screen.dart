import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:flutter/material.dart';

class AddToWalletScreenWidget extends StatelessWidget {
  final String image;
  final String title;
  final String subTitle;
  final VoidCallback? onTap;

  const AddToWalletScreenWidget({Key? key, required this.image , required this.title, required this.subTitle, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: HelperColor.slightWhiteColor,
              boxShadow: [
                BoxShadow(
                    color: HelperColor.black.withOpacity(0.01),
                    spreadRadius: 20,
                    blurRadius: 10,
                    offset:const Offset(0, 10)
                )
              ],
              borderRadius: BorderRadius.circular(12)
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(image)),
                  ),
                ),
                const SizedBox(width: 15,),
                SizedBox(
                  height: 55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,style: HelperStyle.textStyle(
                          context, HelperColor.black, 12, FontWeight.w400)
                        ,),
                      Text(subTitle,style: HelperStyle.textStyle(
                          context, HelperColor.black.withOpacity(0.5), 11, FontWeight.w400),),
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
