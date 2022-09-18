import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/data/model/cancellation_model.dart';
import 'package:flutter/material.dart';

class CancellationWidget extends StatelessWidget {
  final CancellationModel cancellationModel;
  final int? index,widgetIndex;
  final VoidCallback? onTap,deleteTap;

  const CancellationWidget({Key? key, required this.cancellationModel, this.onTap, this.deleteTap,required this.index,required this.widgetIndex})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          margin: const EdgeInsets.all(4),
          width: double.infinity,
          decoration: BoxDecoration(
              color: HelperColor.fillColor,
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
                Icon(index == widgetIndex?Icons.radio_button_on_outlined:Icons.radio_button_off,color: index == widgetIndex?HelperColor.primaryColor:HelperColor.black,size: 20,),
                const SizedBox(width: 10,),
                Expanded(
                  flex: 8,
                  child:  Text('${cancellationModel.note}',style: HelperStyle.textStyle(
                      context, HelperColor.black, 12, FontWeight.w400)
                    ,),
                ),
              ],
            ),
          )
      ),
    );
  }
}