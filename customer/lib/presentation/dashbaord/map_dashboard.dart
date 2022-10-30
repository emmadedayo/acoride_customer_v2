import 'package:acoride/logic/cubits/app_cubit.dart';
import 'package:acoride/logic/cubits/dashboard_cubit.dart';
import 'package:acoride/logic/states/app_state.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../logic/states/dashboard_state.dart';
import '../order/order_trip_screen.dart';
import 'mapcomponents/panelwidget.dart';


class MapMainHomePage extends StatefulWidget {
  const MapMainHomePage({Key? key, }) : super(key: key);
  @override
  State<MapMainHomePage> createState() => _MapMainHomePageState();
}

class _MapMainHomePageState extends State<MapMainHomePage> {
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
                              minHeight:  MediaQuery.of(context).size.height * 0.27,
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
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      margin: EdgeInsets.only(top: 20.h),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              margin: EdgeInsets.only(left: 20.w),
                                              child: const Icon(
                                                Iconsax.arrow_left_2,
                                                color: Colors.black,
                                                size: 25,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(right: 20.w),
                                            child: const Icon(
                                              Iconsax.share,
                                              color: Colors.black,
                                              size: 25,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              panelBuilder: (scrollController) {
                                return MapSearchPanelWidget(
                                  scrollController: scrollController,
                                  panelController: panelController,
                                  dashBoardState: dashboardState,
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