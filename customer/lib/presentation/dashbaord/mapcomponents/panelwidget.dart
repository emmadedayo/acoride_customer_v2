import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/data/model/ride_request_model.dart';
import 'package:acoride/logic/states/dashboard_map_state.dart';
import 'package:acoride/presentation/dashbaord/mapcomponents/panel_list_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../core/constant/dashboard_constant.dart';
import '../../map_search/map_search_screen.dart';

class MapSearchPanelWidget extends StatelessWidget {
  final DashBoardMapState? dashBoardState;
  final ScrollController scrollController;
  final PanelController? panelController;
  final List<RideRequestModel> rideHistory;
  final VoidCallback? onSearch,onSelect;

  const MapSearchPanelWidget({Key? key, required this.rideHistory,required this.scrollController, this.panelController, this.onSearch, this.onSelect,required this.dashBoardState})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      primary: false,
      child:Container(
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: HelperColor.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30,right: 30,bottom: 5).r,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      "Where would you like to go?",
                      style: HelperStyle.textStyle(context, Colors.black, 18.sp, FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 10).r,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                MapSearchAddress(
                                  dashBoardState?.currentAddress ?? "",
                                  dashBoardState?.cameraPosition! ?? const CameraPosition(target: LatLng(0, 0)),
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
                          color: Colors.grey.shade200,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8.0,),
                      child: Row(
                        children: <Widget>[
                          const Icon(Icons.search, color: Colors.grey,),
                          const SizedBox(width: 10.0,),
                          Expanded(
                            child: Text(
                              maxLines: 1,
                              'Search for a destination',
                              style: HelperStyle.textStyle(
                                  context,
                                  Colors.black.withOpacity(0.5),
                                  16.sp,
                                  FontWeight.w400,
                                  letterSpacing: -0.8
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 5).r,
                child:LayoutBuilder(
                  builder: (context, constraints) {
                    if(rideHistory.isEmpty){
                      return Container(
                        height: 200,
                        child: Center(
                          child: Text(
                            "No ride history",
                            style: HelperStyle.textStyle(context, Colors.black, 18.sp, FontWeight.w400),
                          ),
                        ),
                      );
                    }else{
                      return GridView.builder(
                        itemCount:rideHistory.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        primary: false,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio:1.8,mainAxisSpacing: 8,crossAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){

                            },
                            child: Column(
                              children: [
                                const Icon(LineAwesomeIcons.history,size: 20,color: HelperColor.primaryColor,),
                                const SizedBox(height: 5,),
                                Text(rideHistory[index].passengerDestinationAddress ?? "",
                                  style: HelperStyle.textStyle(context, Colors.black, 11.sp, FontWeight.w400),
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
                )
            ],
          )
      )
    );
  }

  Widget dragHandle() => GestureDetector(
      onTap:togglePanel,
      child: Center(
        child: Container(
          height: 5,
          width: 50,
          decoration: BoxDecoration(
            color: HelperColor.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      )
  );

  void togglePanel() => panelController!.isPanelOpen ? panelController?.close() : panelController?.open();
}

