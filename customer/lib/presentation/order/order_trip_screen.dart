import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/data/model/ride_request_model.dart';
import 'package:acoride/data/repositories/object_box_repository.dart';
import 'package:acoride/logic/cubits/ride_request_cubit.dart';
import 'package:acoride/logic/states/ride_request_state.dart';
import 'package:acoride/presentation/order/components/order_screen_widget_trip.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../core/helper/helper_color.dart';
import 'order_rate_driver.dart';


class OrderTripScreen extends StatefulWidget {
  final RideRequestModel rideRequestModel;
  const OrderTripScreen({Key? key,required this.rideRequestModel}) : super(key: key);

  @override
  State<OrderTripScreen> createState() => OrderTripScreenState();
}

class OrderTripScreenState extends State<OrderTripScreen> {

  ObjectBoxRepository objectBoxRepository = ObjectBoxRepository();
  final panelController = PanelController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider<RideRequestCubit>(
      create: (context) => RideRequestCubit(RideRequestState(rideRequestModel: widget.rideRequestModel)),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<RideRequestCubit, RideRequestState>(
            builder: (mapContext, mapState) {
              return SlidingUpPanel(
                minHeight:  MediaQuery.of(context).size.height * 0.47,
                maxHeight: MediaQuery.of(context).size.height * 0.6,
                controller: panelController,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                body: BlocListener<RideRequestCubit, RideRequestState>(
                  listener: (mapContext, states) async {
                    if (mapState.fireStoreModel != null) {
                      if (mapState.fireStoreModel!.deleteTrip!) {
                        objectBoxRepository.deleteRide();
                        FlutterRingtonePlayer.play(
                          fromAsset: 'assets/sounds/beep.mp3',
                          looping: false, // Android only - API >= 28
                          volume: 0.1, // Android only - API >= 28
                          asAlarm: false, // Android only - all APIs
                        );
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.error,
                            animType: AnimType.topSlide,
                            title: 'Warning',
                            desc: 'Your trip has been canceled by the driver',
                            dismissOnBackKeyPress: false,
                            btnOkText: 'Go Back',
                            titleTextStyle: HelperStyle.textStyle(context, HelperColor.black, 15, FontWeight.w500),
                            descTextStyle: HelperStyle.textStyle(context, HelperColor.black, 14, FontWeight.w400),
                            dismissOnTouchOutside: false,
                            barrierColor: Colors.black.withOpacity(0.2),
                            btnCancelColor: HelperColor.primaryColor,
                            btnOkOnPress: () {
                              FlutterRingtonePlayer.stop();
                            }).show();
                      } else if (mapState.fireStoreModel!.endTrip!) {
                        objectBoxRepository.deleteRide();
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => OrderRateDriver(rideRequestModel: widget.rideRequestModel,amountToPay: mapState.fireStoreModel?.amount ?? 0,)
                          ),
                        );
                      }
                    }
                  },
                  child:Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child:mapState.position == null?
                        const Center(
                          child: CircularProgressIndicator(),
                        ):
                        GoogleMap(
                          onMapCreated: (GoogleMapController controller) {
                            mapContext.read<RideRequestCubit>().onMapCreated(controller);
                          },
                          markers: mapState.markers,
                          compassEnabled: false,
                          polylines: mapState.polyLines,
                          zoomControlsEnabled: false,
                          myLocationButtonEnabled: false,
                          scrollGesturesEnabled: true,
                          myLocationEnabled: true,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(
                                mapState.position != null ? mapState.position!.latitude : mapState.lastKnownPositions!.latitude,
                                mapState.position != null ? mapState.position!.longitude : mapState.lastKnownPositions!.longitude),
                            zoom: 10,
                            //tilt: 10
                          ),
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
                ),
                panelBuilder: (scrollController) =>
                    OrderTripScreenWidget(
                      scrollController: scrollController,
                      mapState: mapState,
                      panelController: panelController,
                      onCancel: () async {

                      },
                      rideRequestModel: widget.rideRequestModel,
                    ),
              );
            },
          ),
        ),
      ),
    );
  }
}