import 'package:acoride/core/helper/helper_color.dart';
import 'package:flutter/material.dart';
import '../../core/helper/helper_style.dart';

class WalletCard extends StatelessWidget {
  final String name;
  final String acno;
  final String bal;

  const WalletCard({Key? key, required this.name, required this.acno, required this.bal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                const Icon(Icons.account_balance_wallet, color: HelperColor.primaryColor, size: 30),
                Text(name, 
                  style: HelperStyle.textStyleTwo(
                    context, HelperColor.kTextColorAccent, 16, FontWeight.normal,letterSpacing: 1.0
                  ),
                ),
                const Icon(Icons.info, color: HelperColor.primaryColor, size: 20)
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Account Number", style: HelperStyle.textStyleTwo(
                  context, HelperColor.kTextColorAccent, 16, FontWeight.normal,letterSpacing: 1.0),
              ),
              Text(acno, style: HelperStyle.textStyleTwo(
                  context, HelperColor.kTextColorAccent, 16, FontWeight.normal,letterSpacing: 1.0),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Balance", style: HelperStyle.textStyleTwo(
                  context, HelperColor.kTextColorAccent, 16, FontWeight.normal,letterSpacing: 1.0),),
              Text(bal, style: HelperStyle.textStyleTwo(
                  context, HelperColor.kTextColorAccent, 16, FontWeight.normal,letterSpacing: 1.0),
              ),
            ],
          )
        ],
      ),
    );
  }
}