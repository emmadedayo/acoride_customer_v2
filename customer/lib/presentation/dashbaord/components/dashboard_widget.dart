import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/logic/states/app_state.dart';
import 'package:acoride/logic/states/dashboard_state.dart';
import 'package:acoride/presentation/order/order_trip_screen.dart';
import 'package:badges/badges.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../core/helper/helper_config.dart';
import '../../../utils/conimage.dart';
import '../../components/noWidgetFound.dart';
import '../../router/router_constant.dart';
import '../../wallet/component/wallet_screen_component.dart';
import 'dashboard_component.dart';

class DashboardAppState extends StatelessWidget {
  const DashboardAppState({
    Key? key,
    required this.appState,
  }) : super(key: key);

  final AppState appState;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 23,right: 23,bottom: 17).r,
            child:Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(HelperConfig.greeting(),
                        style: HelperStyle.textStyleTwo(context, HelperColor.black.withOpacity(0.7), 16.sp, FontWeight.w500,letterSpacing: -0.5)
                    ),

                    Text('${appState.user?.name}',
                      style: HelperStyle.textStyleTwo(context, Colors.black, 16.sp, FontWeight.w500),
                    ),
                  ],
                ),
                const Spacer(),

                GestureDetector(
                  child: Badge(
                      badgeContent:Text('0',style:  HelperStyle.textStyleTwo(context, HelperColor.fillColor, 8.sp, FontWeight.normal),),
                      child:const Icon(Iconsax.notification1,color: Color(0xff5A5A5A),size: 23,)
                  ),
                  onTap: (){
                    //Navigator.push(context,MaterialPageRoute(builder: (context) =>  const NotificationIndexScreen()));
                  },
                ),
              ],
            )
        ),
        Padding(
          padding: const EdgeInsets.only(left: 13,right: 13).r,
          child: CarouselSlider(
            options: CarouselOptions(height: 130.0.h,autoPlay: true,autoPlayInterval: const Duration(seconds: 6),viewportFraction:1,),
            items: Imagechoices.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white, width: 2),
                      image: DecorationImage(
                        image: NetworkImage(
                          i.image ?? '',
                        ),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.rectangle,
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 15,),
        Container(
          margin: const EdgeInsets.only(left: 23,right: 23,bottom: 5).r,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  DashboardMenuWidget(
                    context: context,
                    title: 'Order Ride',
                    subTitle: 'Get a ride in minutes',
                    icons: LineAwesomeIcons.motorcycle,
                    onTap: (){
                      Navigator.of(context).pushNamed(mainMapScreen);
                    },
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  DashboardMenuWidget(
                      onTap: (){

                      },
                      context: context,
                      title: 'Delivery',
                      subTitle: 'Deliver your goods in minutes',
                      icons: LineAwesomeIcons.truck
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  DashboardMenuWidget(
                      onTap: () async {

                      },
                      context: context,
                      title: 'Airtime',
                      subTitle: 'Buy airtime for yourself and others',
                      icons: LineAwesomeIcons.wifi
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  DashboardMenuWidget(
                      onTap: () async {

                      },
                      context: context,
                      title: 'Bills',
                      subTitle: 'Pay your bills without stress',
                      icons: LineAwesomeIcons.television
                  ),
                ],
              ),

            ],
          ),
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 23,right: 23,bottom: 17).r,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Transactions',
                style: HelperStyle.textStyleTwo(context, Colors.black, 16.sp, FontWeight.w500),
              ),
              GestureDetector(
                onTap: (){
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionScreen()));
                },
                child: Text('View All',
                  style: HelperStyle.textStyleTwo(context, HelperColor.secondaryColor, 16.sp, FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DashboardFullState extends StatelessWidget {
  const DashboardFullState({
    Key? key,
    required this.dashBoardState,
  }) : super(key: key);

  final DashBoardState dashBoardState;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 23,right: 23,bottom: 17).r,
            child:Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(HelperConfig.greeting(),
                        style: HelperStyle.textStyleTwo(context, HelperColor.black.withOpacity(0.7), 16.sp, FontWeight.w500,letterSpacing: -0.5)
                    ),

                    Text(dashBoardState.dashBoardModel?.user?.name ?? "",
                      style: HelperStyle.textStyleTwo(context, Colors.black, 16.sp, FontWeight.w500),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  child: Badge(
                      badgeContent:Text('${dashBoardState.dashBoardModel?.notification}',style:  HelperStyle.textStyleTwo(context, HelperColor.fillColor, 8.sp, FontWeight.normal),),
                      child:const Icon(Iconsax.notification1,color: Color(0xff5A5A5A),size: 23,)
                  ),
                  onTap: (){
                    //Navigator.push(context,MaterialPageRoute(builder: (context) =>  const NotificationIndexScreen()));
                  },
                ),
              ],
            )
        ),
        Padding(
          padding: const EdgeInsets.only(left: 13,right: 13).r,
          child: CarouselSlider(
            options: CarouselOptions(height: 130.0.h,autoPlay: true,autoPlayInterval: const Duration(seconds: 6),viewportFraction:1,),
            items: dashBoardState.advert.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: (){
                      if(i.advertUrl != null){
                        //Navigator.push(context, MaterialPageRoute(builder: (context) => WebViewScreen(url: i.link,)));
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white, width: 2),
                        image: DecorationImage(
                          image: NetworkImage(
                            i.advertImage ?? '',
                          ),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.rectangle,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 15,),
        Container(
          margin: const EdgeInsets.only(left: 23,right: 23,bottom: 5).r,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  dashBoardState.dashBoardModel?.user?.rideID != '0'?
                  DashboardShimmerMenuWidget(
                    context: context,
                    title: 'Continue Ride',
                    subTitle: 'Click to continue your ride',
                    icons: LineAwesomeIcons.motorcycle,
                    onTap: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => OrderTripScreen(rideRequestModel: dashBoardState.rideRequestModel!),), (route) => false);
                    },
                  ):
                  DashboardMenuWidget(
                    context: context,
                    title: 'Order Ride',
                    subTitle: 'Get a ride in minutes',
                    icons: LineAwesomeIcons.motorcycle,
                    onTap: (){
                      Navigator.of(context).pushNamed(mainMapScreen);
                    },
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  DashboardMenuWidget(
                      onTap: (){

                      },
                      context: context,
                      title: 'Delivery',
                      subTitle: 'Deliver your goods in minutes',
                      icons: LineAwesomeIcons.truck
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  DashboardMenuWidget(
                      onTap: () async {
                        await showModalBottomSheet(
                          enableDrag: true,
                          isDismissible: true,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              )),
                          context: context,
                          builder: (context) {
                            return DashBoardAirtimeWidget(dashBoardState: dashBoardState,);
                          },
                        ).then((value){
                          if(value.toString().isNotEmpty || value.toString()!=null){
                            //contextCubit.read<AppCubit>().changeTempOption(value);
                          }
                        });
                      },
                      context: context,
                      title: 'Airtime',
                      subTitle: 'Buy airtime for yourself and others',
                      icons: LineAwesomeIcons.wifi
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  DashboardMenuWidget(
                      onTap: () async {
                        await showModalBottomSheet(
                          enableDrag: true,
                          isDismissible: true,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                              )),
                          context: context,
                          builder: (context) {
                            return DashBoardDataWidget(dashBoardState: dashBoardState,);
                          },
                        ).then((value){
                          if(value.toString().isNotEmpty || value.toString()!=null){
                            //contextCubit.read<AppCubit>().changeTempOption(value);
                          }
                        });
                      },
                      context: context,
                      title: 'Bills',
                      subTitle: 'Pay your bills without stress',
                      icons: LineAwesomeIcons.television
                  ),
                ],
              ),

            ],
          ),
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.only(left: 23,right: 23,bottom: 17).r,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Recent Transactions',
                style: HelperStyle.textStyleTwo(context, Colors.black, 16.sp, FontWeight.w500),
              ),
              GestureDetector(
                onTap: (){
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionScreen()));
                },
                child: Text('View All',
                  style: HelperStyle.textStyleTwo(context, HelperColor.primaryColor, 10.sp, FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          //margin: EdgeInsets.only(left: 5.0),
          child: dashBoardState.transactions.isEmpty?
          const NotFoundLottie():
          ListView.builder(
            itemCount:dashBoardState.transactions.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context,int index){
              return TransactionWalletWidget(
                transactionModel: dashBoardState.transactions[index],
              );
            },
          )
        ),

      ],
    );
  }
}