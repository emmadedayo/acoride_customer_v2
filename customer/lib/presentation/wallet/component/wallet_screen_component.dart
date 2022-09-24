import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/data/model/TransactionModel.dart';
import 'package:flutter/material.dart';

class TransactionWalletWidget extends StatelessWidget {
  final TransactionModel transactionModel;

  const TransactionWalletWidget({Key? key, required this.transactionModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Opacity(
                  opacity: 0.75,
                  child: Text('${transactionModel.createdAt}',
                      style: HelperStyle.textStyle(
                          context, HelperColor.black, 12, FontWeight.w400)),
                ),

                const SizedBox(
                  height: 5,
                ),
                Text(
                  "${transactionModel.remark}",
                  style: HelperStyle.textStyle(
                      context, HelperColor.black, 12, FontWeight.w400),
                ),
                const SizedBox(
                  height: 5,
                ),
                Opacity(
                  opacity: 0.75,
                  child: Text('${transactionModel.paymentRef}',
                      style: HelperStyle.textStyle(
                          context, HelperColor.black, 12, FontWeight.w400)),
                ),
              ],
            ),),
            Padding(
              padding: const EdgeInsets.only(right: 3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('₦ ${transactionModel.amount}',
                      style: HelperStyle.textStyle(
                          context, HelperColor.black, 12, FontWeight.w400)),
                  const SizedBox(
                    height: 20,
                  ),
                  // Icon(
                  //   Icons.arrow_forward_ios,
                  //   size: 15,
                  // )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
