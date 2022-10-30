import 'package:acoride/core/constant/dashboard_constant.dart';
import 'package:acoride/logic/states/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../../core/helper/helper_color.dart';
import '../../../core/helper/helper_style.dart';

class PanelListView extends StatelessWidget {
  const PanelListView({
    Key? key,
    required this.dashBoardState,
    this.onTap,
  }) : super(key: key);

  final DashBoardState? dashBoardState;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: historyModel.length,
        shrinkWrap: true,
        primary: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (BuildContext context,int index){
          return Column(
            children: [
              InkWell(
                child:ListTile(
                  contentPadding: const EdgeInsets.only(left: 20,right: 20),
                  minLeadingWidth : 10,
                  leading: Icon(LineAwesomeIcons.history,size: 20.sp,color: Colors.black,),
                  title: Text(historyModel[index].text ?? '',style: HelperStyle.textStyle(context, HelperColor.black, 16, FontWeight.w300),),
                ),
                onTap: (){

                },
              )
            ],
          );
        }
    );
  }
}