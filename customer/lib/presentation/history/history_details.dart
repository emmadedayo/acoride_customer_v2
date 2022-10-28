import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../core/constant/enum.dart';
import '../../core/helper/helper_color.dart';
import '../../core/helper/helper_config.dart';
import '../../core/helper/helper_style.dart';
import '../../data/model/ride_request_model.dart';
import '../../logic/cubits/history_details_cubit.dart';
import '../../logic/states/history_details_state.dart';

class HistoryDetailsScreen extends StatefulWidget {
  final RideRequestModel rideRequestModel;
  const HistoryDetailsScreen({Key? key,required this.rideRequestModel}) : super(key: key);

  @override
  RideHistoryScreenState createState() => RideHistoryScreenState();
}

class RideHistoryScreenState extends State<HistoryDetailsScreen> {



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocProvider<HistoryDetailsCubit>(
      create: (context) => HistoryDetailsCubit(HistoryDetailsState(rideRequestModel: widget.rideRequestModel),),
      child: BlocListener<HistoryDetailsCubit, HistoryDetailsState>(
        listener: (context, state) {

        },
        child: BlocBuilder<HistoryDetailsCubit, HistoryDetailsState>(
          builder: (contextCubit, emeState) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                automaticallyImplyLeading: true,
                title: Text("History Details",style: HelperStyle.textStyle(context,Colors.black,20.sp,FontWeight.w500),),
              ),
              body:SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 25,right: 25,bottom: 20,top: 10).r,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Image.asset('assets/images/start_marker.png', width: 18, height: 18,),
                                const SizedBox(width: 20,),
                                Expanded(child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(widget.rideRequestModel.passengerPickupAddress ?? '', style: HelperStyle.textStyleTwo(context, HelperColor.black, 12.sp, FontWeight.normal),),
                                    const SizedBox(height: 5,),
                                    Text(HelperConfig.shortHistory(widget.rideRequestModel.driverStartrideTime ?? ''), style: HelperStyle.textStyleTwo(context, HelperColor.black, 14.sp, FontWeight.w500),),
                                  ],
                                ))
                              ],
                            ),
                            const SizedBox(height: 20,),
                            Row(
                              children: [
                                Image.asset('assets/images/end_marker.png', width: 18, height: 18,),
                                const SizedBox(width: 20,),
                                Expanded(child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(widget.rideRequestModel.passengerDestinationAddress ?? '', style: HelperStyle.textStyleTwo(context, HelperColor.black, 12.sp, FontWeight.normal),),
                                    const SizedBox(height: 5,),
                                    Text(HelperConfig.shortHistory(widget.rideRequestModel.completedStatusTime ?? ''), style: HelperStyle.textStyleTwo(context, HelperColor.black, 14.sp, FontWeight.w500),),
                                  ],
                                ))
                              ],
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          SizedBox(
                            height: 200,
                            child:emeState.positionLoading == CustomState.LOADING?
                            const Center(child: CircularProgressIndicator(),):
                            GoogleMap(
                              onMapCreated: (GoogleMapController controller) {
                                contextCubit.read<HistoryDetailsCubit>().onMapCreated(controller);
                              },
                              markers: emeState.markers,
                              compassEnabled: false,
                              polylines: emeState.polyLines,
                              zoomControlsEnabled: false,
                              myLocationButtonEnabled: false,
                              scrollGesturesEnabled: false,
                              liteModeEnabled: true ,
                              myLocationEnabled: false,
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                  emeState.rideRequestModel.passengerDestinationLatitude ?? 0.0,
                                  emeState.rideRequestModel.passengerDestinationLongitude ?? 0.0,),
                                zoom: 12,
                                //tilt: 10
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 35,right: 35,top: 20,bottom: 5).r,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ClipOval(
                                child: SizedBox(
                                  height: 50,
                                  width: 50,
                                  child: CachedNetworkImage(
                                    imageUrl: emeState.rideRequestModel.user?.kyc?.profileImage ?? '',
                                    fit: BoxFit.contain,
                                    placeholder: (context, url) => const CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ),
                                )
                            ),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text('Your trip with ${HelperConfig.splitName(emeState.rideRequestModel.user?.name ?? 'AA')}',
                                    style: HelperStyle.textStyle(context,Colors.black,14,FontWeight.bold),
                                  ),
                                  Text('Fri, 12 Mar 2021',
                                    style: HelperStyle.textStyle(context,Colors.black,14,FontWeight.normal),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25,right: 25,top: 8).r,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Ride Details', style: HelperStyle.textStyleTwo(context, HelperColor.black, 18.sp, FontWeight.w500),),
                                Text('', style: HelperStyle.textStyleTwo(context, HelperColor.black, 14.sp, FontWeight.w500),),
                              ],
                            ),
                            Divider(
                              color: HelperColor.black.withOpacity(0.5),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Ride Type', style: HelperStyle.textStyleTwo(context, HelperColor.black, 14.sp, FontWeight.normal),),
                                Text('${widget.rideRequestModel.rideType}', style: HelperStyle.textStyleTwo(context, HelperColor.black, 14.sp, FontWeight.w500),),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Duration', style: HelperStyle.textStyleTwo(context, HelperColor.black, 14.sp, FontWeight.normal),),
                                Text('', style: HelperStyle.textStyleTwo(context, HelperColor.black, 14.sp, FontWeight.w500),),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Payment Method', style: HelperStyle.textStyleTwo(context, HelperColor.black, 14.sp, FontWeight.normal),),
                                Text('${widget.rideRequestModel.paymentType}', style: HelperStyle.textStyleTwo(context, HelperColor.black, 14.sp, FontWeight.w500),),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total', style: HelperStyle.textStyleTwo(context, HelperColor.black, 14.sp, FontWeight.bold),),
                                Text('${HelperConfig.currencyFormat(widget.rideRequestModel.tripAmountRequest?.total ?? '0.0')}', style: HelperStyle.textStyleTwo(context, HelperColor.primaryColor, 15.sp, FontWeight.w700),),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}