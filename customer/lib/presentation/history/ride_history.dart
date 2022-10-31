import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/logic/cubits/ride_history_cubit.dart';
import 'package:acoride/logic/states/ride_history_state.dart';
import 'package:acoride/presentation/components/noWidgetFound.dart';
import 'package:acoride/presentation/history/components/ride_history_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/loadingImage.dart';
import '../router/router_constant.dart';


class RideHistoryScreen extends StatefulWidget {
  const RideHistoryScreen({Key? key}) : super(key: key);

  @override
  RideHistoryScreenState createState() => RideHistoryScreenState();
}

class RideHistoryScreenState extends State<RideHistoryScreen> {



  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return BlocProvider<RideHistoryCubit>(
      create: (context) => RideHistoryCubit(RideHistoryState(),),
      child: BlocListener<RideHistoryCubit, RideHistoryState>(
        listener: (context, state) {

        },
        child: BlocBuilder<RideHistoryCubit, RideHistoryState>(
          builder: (contextCubit, emeState) {

            return Scaffold(
                backgroundColor: HelperColor.slightWhiteColor,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Text("Ride History",style: HelperStyle.textStyle(context,Colors.black,20.sp,FontWeight.w500),),
                ),
                body:SafeArea(
                    child: LayoutBuilder(
                        builder: (context, key){
                          if(emeState.isLoading){
                            return const Center(
                              child: LoadingWidget(),
                            );
                          }else if(emeState.history.isEmpty){
                            return const Center(
                              child: NotFoundLottie(),
                            );
                          }else{
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: emeState.history.length,
                                    itemBuilder: (context, index) {
                                      return RideRequestWidget(
                                        rideRequestModel: emeState.history[index],
                                        onTap: () async {
                                          Navigator.of(context).pushNamed(
                                              tripHistoryScreen,
                                              arguments: {'data':emeState.history[index]});
                                        },
                                      );
                                    },
                                  ),
                                  SizedBox(height: 30.h,),
                                ],
                              ),
                            );
                          }
                        }
                    )
                )
            );
          },
        ),
      ),
    );

  }
}