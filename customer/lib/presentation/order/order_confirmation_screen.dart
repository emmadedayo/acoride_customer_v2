import 'package:acoride/data/model/UserModel.dart';
import 'package:acoride/logic/cubits/app_cubit.dart';
import 'package:acoride/logic/cubits/map_cubit.dart';
import 'package:acoride/logic/states/map_state.dart';
import 'package:acoride/presentation/order/components/confirmation_panel_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'order_payment_screen.dart';
import 'order_trip_screen.dart';

class ConfirmRideDetails extends StatefulWidget {

  final List<Map<String, dynamic>> dataFrom;
  final List<Map<String, dynamic>> dataTo;

  const ConfirmRideDetails({Key? key,required this.dataFrom, required this.dataTo}) : super(key: key);

  @override
  State<ConfirmRideDetails> createState() => _ConfirmRideDetailsState();
}

class _ConfirmRideDetailsState extends State<ConfirmRideDetails> {

  final panelController = PanelController();
  String paymentType = 'Wallet';


  @override
  Widget build(BuildContext context) {
    UserModel user = context.read<AppCubit>().state.user!;
    return BlocProvider<MapCubit>(
      create: (context) => MapCubit(MapState(dataFrom: widget.dataFrom, dataTo: widget.dataTo,userModel: user)),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: BlocBuilder<MapCubit, MapState>(
            builder: (mapContext, mapState) {
              return SlidingUpPanel(
                minHeight:  MediaQuery.of(context).size.height * 0.47,
                maxHeight: MediaQuery.of(context).size.height * 0.6,
                controller: panelController,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                body: BlocListener<MapCubit, MapState>(
                  listener: (mapContext, states) async {
                    if (states.rideRequestModel != null) {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => OrderTripScreen(
                              rideRequestModel: states.rideRequestModel!,
                            ),
                          ));
                    }
                    if (states.hasError == true) {
                      showToast(states.message,
                          context: context,
                          backgroundColor: Colors.red,
                          axis: Axis.horizontal,
                          alignment: Alignment.center,
                          position: StyledToastPosition.top);

                      mapContext.read<MapCubit>().state.hasError = null;
                      mapContext.read<MapCubit>().state.message = null;
                    }else if(states.hasError == false){
                      showToast(states.message,
                          context: context,
                          backgroundColor: Colors.green,
                          axis: Axis.horizontal,
                          alignment: Alignment.center,
                          position: StyledToastPosition.top);
                      mapContext.read<MapCubit>().state.hasError = null;
                      mapContext.read<MapCubit>().state.message = null;
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
                            context.read<MapCubit>().onMapCreated(controller);
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
                ),
                panelBuilder: (scrollController) =>
                    ConfirmationWidget(scrollController: scrollController,
                      mapState: mapState,
                      panelController: panelController,
                      selectPayment: () async {

                       await Navigator.push(context,
                          MaterialPageRoute(
                            builder: (context) => const SelectPaymentScreen(),
                          ),
                        ).then((value) => {
                        if(value != null){
                            mapContext.read<MapCubit>().updatePayment(value),
                        }});
                      },
                      onContinue: (){
                        mapContext.read<MapCubit>().loadingAndWaitingForDriver();
                      },
                    ),
              );
            },
          ),
        ),
      ),
    );
  }
}