import 'package:acoride/data/model/UserModel.dart';
import 'package:acoride/logic/cubits/app_cubit.dart';
import 'package:acoride/logic/cubits/map_cubit.dart';
import 'package:acoride/logic/states/map_state.dart';
import 'package:acoride/presentation/delivery/delivery_details/delivery_user_screen.dart';
import 'package:acoride/utils/loadingImage.dart';
import 'package:acoride/utils/map.utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../core/helper/helper_color.dart';
import '../components/delivery_components.dart';


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
                minHeight:  MediaQuery.of(context).size.height *0.40,
                maxHeight: MediaQuery.of(context).size.height *0.44,
                controller: panelController,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                body: BlocListener<MapCubit, MapState>(
                  listener: (mapContext, states) async {

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
                    ConfirmationDeliveryWidget(scrollController: scrollController,
                      mapState: mapState,
                      panelController: panelController,
                      onContinue: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => DeliveryUserScreen(dataFrom: widget.dataFrom, dataTo: widget.dataTo)));
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