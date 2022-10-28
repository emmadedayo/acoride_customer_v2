import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/logic/cubits/app_cubit.dart';
import 'package:acoride/logic/cubits/dashboard_cubit.dart';
import 'package:acoride/logic/states/app_state.dart';
import 'package:acoride/presentation/map_search/map_search_screen.dart';
import 'package:acoride/presentation/router/router_constant.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../core/constant/dashboard_constant.dart';
import '../../core/helper/helper_style.dart';
import '../../logic/states/dashboard_state.dart';
import '../order/order_trip_screen.dart';
import 'components/dashboard_component.dart';
import 'components/dashboard_widget.dart';

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
                          child:SlidingUpPanel(
                              minHeight:  MediaQuery.of(context).size.height * 0.24,
                              maxHeight: MediaQuery.of(context).size.height * 0.6,
                              controller: panelController,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                              body: Stack(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height,
                                    child:dashboardState.position == null?
                                    const Center(
                                      child: CircularProgressIndicator(),
                                    ):
                                    GoogleMap(
                                      onMapCreated: (GoogleMapController controller) {
                                        dashboardContext.read<DashBoardCubit>().onMapCreated(controller);
                                      },
                                      zoomControlsEnabled: false,
                                      myLocationButtonEnabled: false,
                                      myLocationEnabled: true,
                                      minMaxZoomPreference: const MinMaxZoomPreference(0, 16),
                                      initialCameraPosition: CameraPosition(
                                        target: LatLng(
                                            dashboardState.position != null ? dashboardState.position!.latitude : dashboardState.lastKnownPositions!.latitude,
                                            dashboardState.position != null ? dashboardState.position!.longitude : dashboardState.lastKnownPositions!.longitude),
                                        zoom: 17,
                                      ),
                                      onCameraMove: (CameraPosition position) {
                                        dashboardContext.read<DashBoardCubit>().onCameraMove(position);
                                      },
                                      onCameraIdle: () => dashboardContext.read<DashBoardCubit>().getPositionName(
                                          dashboardState.cameraPosition?.target.latitude ?? dashboardState.position?.latitude,
                                          dashboardState.cameraPosition?.target.longitude ?? dashboardState.position?.longitude),
                                    ),
                                  ),
                                  // Align(
                                  //   alignment: Alignment.topCenter,
                                  //   child: Container(
                                  //     margin: EdgeInsets.only(top: 20.h),
                                  //     child: Row(
                                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //       children: [
                                  //         InkWell(
                                  //           onTap: () {
                                  //             Navigator.pop(context);
                                  //           },
                                  //           child: Container(
                                  //             margin: EdgeInsets.only(left: 20.w),
                                  //             child: const Icon(
                                  //               Iconsax.arrow_left_2,
                                  //               color: Colors.black,
                                  //               size: 25,
                                  //             ),
                                  //           ),
                                  //         ),
                                  //         Container(
                                  //           margin: EdgeInsets.only(right: 20.w),
                                  //           child: const Icon(
                                  //             Iconsax.share,
                                  //             color: Colors.black,
                                  //             size: 25,
                                  //           ),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                              panelBuilder: (scrollController) {
                                return Container(
                                    alignment: Alignment.bottomCenter,
                                    child: Column(
                                      children: [
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
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              const SizedBox(height: 8),
                                              Text(
                                                "Where would you like to go?",
                                                style: HelperStyle.textStyle(
                                                    context,
                                                    Colors.black,
                                                    17,
                                                    FontWeight.w400),
                                              ),
                                              const SizedBox(
                                                height: 10.0,
                                              ),
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
                                                    height: 43.0.h,
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
                                        GridView.builder(
                                          itemCount: billModel.length,
                                          physics: const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          primary: false,
                                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,childAspectRatio:0.9,mainAxisSpacing: 8,crossAxisSpacing: 10),
                                          itemBuilder: (context, index) {
                                            return BillsWidget(
                                              billsModel: billModel[index],
                                              onTap: () async {
                                                if(index == 0) {
                                                  Navigator.of(context).pushNamed(airtimeScreen);
                                                }else if(index == 1) {
                                                  Navigator.of(context).pushNamed(dataScreen);
                                                }else if(index == 2) {
                                                  Navigator.of(context).pushNamed(cableScreen);
                                                }else if(index == 3) {
                                                  Navigator.of(context).pushNamed(electricityScreen);
                                                }
                                              },
                                            );
                                          },
                                        ),
                                        const SizedBox(height: 5,),
                                        DashBoardDelivery(
                                          onTap: (){

                                          },
                                        ),
                                      ],
                                    )
                                );
                              }
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