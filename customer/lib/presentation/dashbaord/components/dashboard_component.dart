import 'package:acoride/core/helper/helper_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/dashboard_constant.dart';

class DashboardWidget extends StatelessWidget {
  final DashBoardModel dashBoardModel;
  final VoidCallback? onTap,deleteTap;

  const DashboardWidget({Key? key, required this.dashBoardModel, this.onTap, this.deleteTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.only(left: 10,right: 10).r,
          margin: const EdgeInsets.only(left: 10,right: 10,).r,
          width: double.infinity,
          child:Column(
            children: [
              ListTile(
               minVerticalPadding: 2,
                leading: Image.asset(dashBoardModel.image!,height: 25,width: 25,),
                title: Text(dashBoardModel.text!,style: HelperStyle.textStyleTwo(context, Colors.black, 16, FontWeight.normal),),
              ),
              const Divider(

              ),
            ],
          )
      ),
    );
  }
}



class BillsWidget extends StatelessWidget {
  final BillsModel billsModel;
  final VoidCallback? onTap,deleteTap;

  const BillsWidget({Key? key, required this.billsModel, this.onTap, this.deleteTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child:  Container(
          margin: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10).r,
          child:Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Image.asset(billsModel.image!,height: 25,width: 25,),
              const SizedBox(height: 10,),
              Text(billsModel.text!, style: HelperStyle.textStyleTwo(context, Colors.black, 12, FontWeight.normal),),
            ],
          )
      ),
    );
  }
}