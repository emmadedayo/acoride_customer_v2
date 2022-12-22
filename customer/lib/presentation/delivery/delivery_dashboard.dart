import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/data/model/ride_request_model.dart';
import 'package:acoride/logic/cubits/app_cubit.dart';
import 'package:acoride/logic/states/app_state.dart';
import 'package:acoride/utils/blurry_modal_profress_hud.dart';
import 'package:acoride/utils/loadingImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../logic/cubits/dashboard_map_cubit.dart';
import '../../logic/states/dashboard_map_state.dart';
import '../delivery/mapcomponents/panelwidget.dart';
import '../order/order_trip_screen.dart';


class DeliveryMapMainPage extends StatefulWidget {
  const DeliveryMapMainPage({
    Key? key,
    required this.rideHistory,
  }) : super(key: key);

  final List<RideRequestModel> rideHistory;

  @override
  State<DeliveryMapMainPage> createState() => _DeliveryMapMainPageState();
}

class _DeliveryMapMainPageState extends State<DeliveryMapMainPage> {
  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(
        builder: (appContext,appState){
          return BlocProvider<DashBoardMapCubit>(
            create: (context) => DashBoardMapCubit(DashBoardMapState(rideDetails: appState.rideDetails)),
            child: Scaffold(
              body: SafeArea(
                child: BlocBuilder<DashBoardMapCubit, DashBoardMapState>(
                  builder: (dashboardContext, dashboardState) {
                    return BlurryModalProgressHUD(
                      inAsyncCall: dashboardState.isLoading,
                      child: BlocListener<DashBoardMapCubit, DashBoardMapState>(
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
                                      child: LoadingWidget(),
                                    ):
                                    GoogleMap(
                                      onMapCreated: (GoogleMapController controller) {
                                        dashboardContext.read<DashBoardMapCubit>().onMapCreated(controller);
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
                                        dashboardContext.read<DashBoardMapCubit>().onCameraMove(position);
                                      },
                                      onCameraIdle: () => dashboardContext.read<DashBoardMapCubit>().getPositionName(
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
                                          MaterialButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            elevation: 2,
                                            color: Colors.white,
                                            padding: const EdgeInsets.all(15),
                                            shape: const CircleBorder(),
                                            child: const Icon(
                                              Icons.arrow_back,
                                              color: HelperColor.black,
                                              size: 24,
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
                                  rideHistory: widget.rideHistory,
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