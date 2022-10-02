
import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/logic/cubits/app_cubit.dart';
import 'package:acoride/logic/cubits/dashboard_cubit.dart';
import 'package:acoride/logic/states/app_state.dart';
import 'package:acoride/presentation/map_search/map_search_screen.dart';
import 'package:acoride/utils/conimage.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/dashboard_constant.dart';
import '../../core/helper/helper_style.dart';
import '../../logic/states/dashboard_state.dart';
import '../order/order_trip_screen.dart';
import 'components/dashboard_component.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key, }) : super(key: key);
  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(
        builder: (appContext,appState){
          return BlocProvider<DashBoardCubit>(
            create: (context) => DashBoardCubit(DashBoardState(rideDetails: appState.rideDetails)),
            child: Scaffold(
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
                          child:ListView(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SingleChildScrollView(
                                    child: Container(
                                        alignment: Alignment.bottomCenter,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 25.h,
                                            ),
                                            Padding(
                                                padding: const EdgeInsets.only(left: 13,right: 13,bottom: 17).r,
                                                child:Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: <Widget>[
                                                        Expanded(
                                                          child:  Text('Good Afternoon, Emmanuel!',
                                                            style: HelperStyle.textStyleTwo(context, Colors.black, 16.sp, FontWeight.w500),
                                                          ),),

                                                        GestureDetector(
                                                          child: const Icon(Icons.notifications,color: Color(0xff5A5A5A),size: 23,),
                                                          onTap: (){
                                                            //Navigator.push(context,MaterialPageRoute(builder: (context) =>  const NotificationIndexScreen()));

                                                          },
                                                        ),

                                                      ],
                                                    ),
                                                  ],
                                                )
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(left: 13,right: 13).r,
                                              child: CarouselSlider(
                                                options: CarouselOptions(height: 120.0.h,autoPlay: true,autoPlayInterval: const Duration(seconds: 6),viewportFraction:1,),
                                                items: Imagechoices.map((i) {
                                                  return Builder(
                                                    builder: (BuildContext context) {
                                                      return Container(
                                                        width: MediaQuery.of(context).size.width,
                                                        // margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(20),
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

                                            appState.rideDetails?.hasRide == true?
                                            InkWell(
                                              onTap: (){
                                                dashboardContext.read<DashBoardCubit>().returnToRide();
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: HelperColor.primaryColor,
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(25),
                                                    topRight: Radius.circular(25),
                                                  ),
                                                ),
                                                padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10).r,
                                                width: MediaQuery.of(context).size.width,
                                                child:Text(
                                                  "Arriving in 5 mins",
                                                  style: HelperStyle.textStyle(context, Colors.white, 16, FontWeight.w400),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ):
                                            Container(),
                                            Container(
                                              padding: const EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 5).r,
                                              width: MediaQuery.of(context).size.width,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  MapSearchAddress(
                                                                    dashboardState.currentAddress,
                                                                    dashboardState.cameraPosition!,
                                                                  ),
                                                              fullscreenDialog: true));
                                                    },
                                                    child: Hero(
                                                      tag: UniqueKey(),
                                                      child: Container(
                                                        height: 50.0,
                                                        width: MediaQuery.of(context).size.width,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: Colors.grey.shade300,
                                                          ),
                                                          borderRadius: BorderRadius.circular(30.0),
                                                        ),
                                                        padding: const EdgeInsets.symmetric(
                                                          horizontal: 8.0,
                                                        ),
                                                        child: Row(
                                                          children: <Widget>[
                                                            const Icon(
                                                              Icons.search,
                                                              color: Colors.grey,
                                                            ),
                                                            const SizedBox(
                                                              width: 10.0,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                maxLines: 1,
                                                                'Where are you going?',
                                                                style: HelperStyle.textStyle(
                                                                    context,
                                                                    Colors.grey,
                                                                    17,
                                                                    FontWeight.w400),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            ListView.builder(
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemCount: dashboardNotification.length,
                                              itemBuilder: (context, index) {
                                                return DashboardWidget(
                                                  dashBoardModel: dashboardNotification[index],
                                                  onTap: () async {

                                                  },
                                                );
                                              },
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(left: 20,right: 20).r,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text('Service',
                                                    style: HelperStyle.textStyleTwo(
                                                        context, Colors.black, 15, FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                            GridView.builder(
                                              itemCount: billModel.length,
                                              physics: const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              primary: false,
                                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,childAspectRatio:1.2,mainAxisSpacing: 8,crossAxisSpacing: 10),
                                              itemBuilder: (context, index) {
                                                return BillsWidget(
                                                  billsModel: billModel[index],
                                                  onTap: () async {

                                                  },
                                                );
                                              },
                                            ),
                                          ],
                                        )
                                    ),
                                  )

                                ],
                              ),
                            ],
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