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
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';

import '../../core/helper/helper_style.dart';
import '../../logic/states/dashboard_state.dart';
import '../order/order_trip_screen.dart';

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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Stack(
                                    children: [
                                      SizedBox(
                                        height: MediaQuery.of(context).size.height - 300.h,
                                        child:dashboardState.position == null?
                                        const Center(child: CircularProgressIndicator(),):
                                        GoogleMap(
                                          onMapCreated: (GoogleMapController controller) {
                                            context.read<DashBoardCubit>().onMapCreated(controller);
                                          },
                                          zoomControlsEnabled: false,
                                          myLocationButtonEnabled: false,
                                          myLocationEnabled: true,
                                          initialCameraPosition: CameraPosition(
                                            target: LatLng(
                                                dashboardState.position != null ? dashboardState.position!.latitude : dashboardState.lastKnownPositions!.latitude ?? dashboardState.position!.latitude,
                                                dashboardState.position != null ? dashboardState.position!.longitude : dashboardState.lastKnownPositions!.longitude ?? dashboardState.position!.longitude),
                                            zoom: 17,
                                          ),
                                          onCameraMove: (CameraPosition position) {
                                            context.read<DashBoardCubit>().onCameraMove(position);
                                          },
                                          onCameraIdle: () => context.read<DashBoardCubit>().getPositionName(
                                              dashboardState.cameraPosition?.target.latitude ?? dashboardState.position?.latitude,
                                              dashboardState.cameraPosition?.target.longitude ?? dashboardState.position?.longitude),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SingleChildScrollView(
                                    child: Container(
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
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    "Where would you like to go?",
                                                  ),
                                                  const SizedBox(
                                                    height: 15.0,
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
                                                        height: 50.0,
                                                        width: MediaQuery.of(context).size.width,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: Colors.grey.shade300,
                                                          ),
                                                          borderRadius: BorderRadius.circular(6.0),
                                                        ),
                                                        padding: const EdgeInsets.symmetric(
                                                          horizontal: 8.0,
                                                        ),
                                                        child: Row(
                                                          children: <Widget>[
                                                            Expanded(
                                                              child: Text(
                                                                maxLines: 1,
                                                                dashboardState.currentAddress,
                                                                style: HelperStyle.textStyle(
                                                                    context,
                                                                    Colors.grey,
                                                                    17,
                                                                    FontWeight.w400),
                                                              ),
                                                            ),
                                                            const Icon(
                                                              Iconsax.search_favorite,
                                                              color: Colors.grey,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(left: 10,right: 10).r,
                                              child: CarouselSlider(
                                                options: CarouselOptions(height: 120.0.h,autoPlay: true,autoPlayInterval: const Duration(seconds: 6),viewportFraction:1,),
                                                items: Imagechoices.map((i) {
                                                  return Builder(
                                                    builder: (BuildContext context) {
                                                      return Container(
                                                        width: MediaQuery.of(context).size.width,
                                                        // margin: const EdgeInsets.symmetric(horizontal: 5.0),
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
                                            )
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