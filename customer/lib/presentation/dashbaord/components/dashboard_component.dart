import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../../core/constant/dashboard_constant.dart';
import '../../../logic/states/dashboard_state.dart';
import '../../router/router_constant.dart';

class DashboardMenuWidget extends StatelessWidget {
  const DashboardMenuWidget({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.icons,
    this.context,
    this.onTap,
  }) : super(key: key);


  final BuildContext? context;
  final String title;
  final String subTitle;
  final IconData icons;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: const BoxDecoration(
            color: HelperColor.fillColor,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      color: HelperColor.primaryColor,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Icon(icons,color: HelperColor.secondaryColor,size: 20,),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Text(
                title,
                style: HelperStyle.textStyle(context, HelperColor.black, 18, FontWeight.normal),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                subTitle,
                style: HelperStyle.textStyle(context, HelperColor.black, 11, FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashBoardAirtimeWidget extends StatelessWidget {
  final DashBoardState dashBoardState;
  const DashBoardAirtimeWidget({Key? key,required this.dashBoardState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          //padding: const EdgeInsets.all(15.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(13)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: HelperColor.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,top: 10,bottom: 10),
                child: Text("Select Type",
                    textAlign: TextAlign.left,
                    style: HelperStyle.textStyle(context, HelperColor.black, 20.sp, FontWeight.w500)
                ),
              ),
              ListView.builder(
                  itemCount: billModel.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context,int index){
                    return Column(
                      children: [
                        InkWell(
                          child:ListTile(
                            contentPadding: const EdgeInsets.only(left: 20,right: 20),
                            title: Text(billModel[index].text ?? '',style: HelperStyle.textStyle(context, HelperColor.black, 16, FontWeight.w300),),
                            trailing:const Icon(LineAwesomeIcons.arrow_right,color: Colors.black,size: 20,),
                          ),
                          onTap: (){
                            if(index == 0) {
                              Navigator.of(context).pushNamed(airtimeScreen);
                            }else if(index == 1) {
                              Navigator.of(context).pushNamed(dataScreen);
                            }else{

                            }
                          },
                        )
                      ],
                    );
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DashBoardDataWidget extends StatelessWidget {
  final DashBoardState dashBoardState;
  const DashBoardDataWidget({Key? key,required this.dashBoardState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          //padding: const EdgeInsets.all(15.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(13)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: HelperColor.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,top: 10,bottom: 10),
                child: Text("Select Type",
                    textAlign: TextAlign.left,
                    style: HelperStyle.textStyle(context, HelperColor.black, 20.sp, FontWeight.w500)
                ),
              ),
              ListView.builder(
                  itemCount: dataModel.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context,int index){
                    return Column(
                      children: [
                        InkWell(
                          child:ListTile(
                            contentPadding: const EdgeInsets.only(left: 20,right: 20),
                            title: Text(dataModel[index].text ?? '',style: HelperStyle.textStyle(context, HelperColor.black, 16, FontWeight.w300),),
                            trailing:const Icon(LineAwesomeIcons.arrow_right,color: Colors.black,size: 20,),
                          ),
                          onTap: (){
                            if(index == 0) {
                              Navigator.of(context).pushNamed(cableScreen);
                            }else if(index == 1) {
                              Navigator.of(context).pushNamed(electricityScreen);
                            }else {

                            }
                          },
                        )
                      ],
                    );
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}