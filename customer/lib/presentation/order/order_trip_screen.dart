import 'package:acoride/data/model/ride_request_model.dart';
import 'package:acoride/data/repositories/object_box_repository.dart';
import 'package:acoride/logic/cubits/ride_request_cubit.dart';
import 'package:acoride/logic/states/ride_request_state.dart';
import 'package:acoride/presentation/order/components/order_screen_widget_trip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../core/helper/helper_color.dart';
import '../../utils/loadingImage.dart';
import '../cancellation/cancellation_screen.dart';
import '../router/router_constant.dart';
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
                minHeight: MediaQuery.of(context).size.height * 0.4,
                maxHeight: MediaQuery.of(context).size.height * 0.6,
                controller: panelController,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                body: BlocListener<RideRequestCubit, RideRequestState>(
                  listener: (mapContext, states) async {
                    if (states.fireStoreModel != null) {
                      if (states.fireStoreModel!.deleteTrip == true) {
                        objectBoxRepository.deleteRide();
                        states.userStream!.cancel();
                        states.rideRequestStream?.cancel();
                        Navigator.of(context).pushNamedAndRemoveUntil(tripDeleteScreen, (route) => false);
                      } else if (states.fireStoreModel!.endTrip == true) {
                        objectBoxRepository.deleteRide();
                        //states.userStream!.cancel();
                        states.rideRequestStream?.cancel();
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => OrderRateDriver(rideRequestModel: widget.rideRequestModel,amountToPay: states.fireStoreModel!.amount ?? 0,),), (route) => false);
                      }
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
                                  Navigator.of(context).pushNamed(pageHome);
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
                      onPanic: () async {
                        mapContext.read<RideRequestCubit>().panicAlert();
                      },
                      onCancel: () async {
                        mapState.userStream!.cancel();
                        mapState.rideRequestStream?.cancel();
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CancellationScreen(
                          rideRequestModel: mapState.rideRequestModel!,
                          currentPosition: mapState.position!,
                        ))).then((value) => {
                            mapState.userStream!.resume(),
                            mapState.rideRequestStream?.resume(),
                        });
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