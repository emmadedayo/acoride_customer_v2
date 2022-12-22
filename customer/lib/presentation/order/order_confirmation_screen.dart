import 'package:acoride/data/model/UserModel.dart';
import 'package:acoride/logic/cubits/app_cubit.dart';
import 'package:acoride/logic/cubits/map_cubit.dart';
import 'package:acoride/logic/states/map_state.dart';
import 'package:acoride/presentation/order/components/confirmation_panel_widget.dart';
import 'package:acoride/presentation/router/router_constant.dart';
import 'package:acoride/utils/loadingImage.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../core/helper/helper_color.dart';
import '../../core/helper/helper_style.dart';
import '../../utils/map.utils.dart';
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
                minHeight:  MediaQuery.of(context).size.height * mapState.bottomSheetHeight,
                maxHeight: MediaQuery.of(context).size.height * mapState.bottomSheetHeight2,
                controller: panelController,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                body: BlocListener<MapCubit, MapState>(
                  listener: (mapContext, states) async {
                    if (states.rideRequestModel != null) {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => OrderTripScreen(rideRequestModel: states.rideRequestModel!,),), (route) => false);
                    }
                    if(states.amountLoadingResult == true){
                      AwesomeDialog(
                          context: context,
                          dialogType: DialogType.error,
                          animType: AnimType.topSlide,
                          title: 'Warning',
                          desc: 'Unable to process your request, please try again later',
                          dismissOnBackKeyPress: false,
                          btnOkText: 'Go Back',
                          titleTextStyle: HelperStyle.textStyle(context, HelperColor.black, 15, FontWeight.w500),
                          descTextStyle: HelperStyle.textStyle(context, HelperColor.black, 14, FontWeight.w400),
                          dismissOnTouchOutside: false,
                          barrierColor: Colors.black.withOpacity(0.2),
                          btnCancelColor: HelperColor.primaryColor,
                          btnOkOnPress: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(pageHome, (route) => false);
                          }).show();
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
                          child: LoadingWidget(),
                        ):
                        GoogleMap(
                          onMapCreated: (GoogleMapController controller) {
                            mapContext.read<MapCubit>().onMapCreated(controller);
                          },
                          markers: mapState.markers,
                          compassEnabled: false,
                          polylines: mapState.polyLines,
                          zoomControlsEnabled: false,
                          cameraTargetBounds: CameraTargetBounds(
                            MapUtils.targetBounds(
                              LatLng(widget.dataFrom[0]['lat'], widget.dataFrom[0]['long']),
                              LatLng(widget.dataTo[0]['lat'], widget.dataTo[0]['long']),
                            ),
                          ),
                          myLocationButtonEnabled: false,
                          scrollGesturesEnabled: true,
                          myLocationEnabled: true,
                          //minMaxZoomPreference: const MinMaxZoomPreference(10, 20),
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
                            debugPrint("value is ${value['name']} ${value['card_id']}"),
                            mapContext.read<MapCubit>().updatePayment(value['name'],value['card_id']),
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