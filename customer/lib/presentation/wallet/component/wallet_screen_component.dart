import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_config.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/data/model/TransactionModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';

class TransactionWalletWidget extends StatelessWidget {
  final TransactionModel transactionModel;

  const TransactionWalletWidget({Key? key, required this.transactionModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8)
        ),
        margin: const EdgeInsets.only(bottom: 8,left: 5,right: 5).r,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Row(
          children: <Widget>[
            transactionModel.effect == "cr"?
            Image.asset("assets/images/incoming-call.png", height: 20,):
            Image.asset("assets/images/outgoing-call.png", height: 20,),
            const SizedBox(width: 14,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:<Widget>[
                Text("${HelperConfig.paymentReformat(transactionModel.paymentFor ?? '')}", style: HelperStyle.textStyle(
                    context, HelperColor.black, 15, FontWeight.w400),
                ),
                const SizedBox(height: 5,),
                Text("${transactionModel.createdAt}",
                  style:HelperStyle.textStyle(
                      context, HelperColor.black, 12, FontWeight.w400),

                ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:<Widget>[
                Text("${HelperConfig.currencyFormat('${transactionModel.amount ?? 0}')}",
                  style:HelperStyle.textStyle(
                      context, transactionModel.effect == "cr"?HelperColor.greenColor:HelperColor.redColor, 12, FontWeight.w400),

                ),
                Text("",
                  style:HelperStyle.textStyle(
                      context, HelperColor.black, 12, FontWeight.w400),

                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
