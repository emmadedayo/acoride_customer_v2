import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/data/model/EmergencyModel.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class EmergencyWidget extends StatelessWidget {
  final EmergencyModel emergencyModel;
  final VoidCallback? onTap,deleteTap;

  const EmergencyWidget({Key? key, required this.emergencyModel, this.onTap, this.deleteTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.all(4),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
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
                Expanded(
                  flex: 8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${emergencyModel.emergencyName}',style: HelperStyle.textStyle(
                          context, HelperColor.black, 12, FontWeight.w400)
                        ,),
                      Text(emergencyModel.emergencyPhone!,style: HelperStyle.textStyle(
                          context, HelperColor.black.withOpacity(0.5), 11, FontWeight.w400),),
                      Text(emergencyModel.emergencyAddress!,style: HelperStyle.textStyle(
                          context, HelperColor.black.withOpacity(0.5), 11, FontWeight.w400),),
                    ],
                  ),),
                const Spacer(),
                InkWell(
                  onTap: deleteTap,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                        color: HelperColor.black,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: const Icon(Iconsax.trash,color: HelperColor.slightWhiteColor,size: 20,),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}