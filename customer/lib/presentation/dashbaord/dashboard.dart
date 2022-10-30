import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/logic/cubits/app_cubit.dart';
import 'package:acoride/logic/cubits/dashboard_cubit.dart';
import 'package:acoride/logic/states/app_state.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../core/helper/helper_style.dart';
import '../../logic/states/dashboard_state.dart';
import '../../utils/conimage.dart';
import '../order/order_trip_screen.dart';
import '../router/router_constant.dart';
import 'components/dashboard_component.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key, }) : super(key: key);
  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(
        builder: (appContext,appState){
          return BlocProvider<DashBoardCubit>(
            create: (context) => DashBoardCubit(DashBoardState(rideDetails: appState.rideDetails)),
            child: Scaffold(
              backgroundColor: HelperColor.slightWhiteColor,
              body: SafeArea(
                child: BlocBuilder<DashBoardCubit, DashBoardState>(
                  builder: (dashboardContext, dashboardState) {
                    return BlurryModalProgressHUD(
                      inAsyncCall: dashboardState.isLoading,
                      child: BlocListener<DashBoardCubit, DashBoardState>(
                          listener: (context, state) async {
                            if (state.rideRequestModel != null) {
                              if(appState.rideDetails?.rideType == "CREATE_RIDE"){
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (
                                        context) => OrderTripScreen(rideRequestModel: state.rideRequestModel!,),
                                  ),
                                );
                              }else if(appState.rideDetails?.rideType == "CONFIRM_RIDE") {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (
                                        context) => OrderTripScreen(rideRequestModel: state.rideRequestModel!,),
                                  ),
                                );
                              }
                            }
                          },
                          child:SingleChildScrollView(
                            child: Column(
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
                                            Text('Good Evening',
                                              style: HelperStyle.textStyleTwo(context, HelperColor.black.withOpacity(0.7), 16.sp, FontWeight.w500,letterSpacing: -0.5)
                                            ),

                                            Text('Emmanuel Bank Anthony',
                                              style: HelperStyle.textStyleTwo(context, Colors.black, 16.sp, FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          child: const Icon(Iconsax.notification1,color: Color(0xff5A5A5A),size: 23,),
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
                                                  return DashBoardAirtimeWidget(dashBoardState: dashboardState,);
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
                                                  return DashBoardDataWidget(dashBoardState: dashboardState,);
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
                                          style: HelperStyle.textStyleTwo(context, HelperColor.secondaryColor, 16.sp, FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          )
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        }
    );
  }
}