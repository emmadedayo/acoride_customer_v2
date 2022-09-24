import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/data/model/ride_request_model.dart';
import 'package:acoride/logic/cubits/app_cubit.dart';
import 'package:acoride/logic/cubits/cancellation_cubit.dart';
import 'package:acoride/logic/states/app_state.dart';
import 'package:acoride/logic/states/cancellation_state.dart';
import 'package:acoride/presentation/cancellation/component/cancellation_widget.dart';
import 'package:acoride/presentation/components/buttonWidget.dart';
import 'package:acoride/presentation/router/router_constant.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';

import '../components/noWidgetFound.dart';



class CancellationScreen extends StatefulWidget {
  final RideRequestModel rideRequestModel;
  final Position currentPosition;
  const CancellationScreen({Key? key,required this.rideRequestModel,required this.currentPosition}) : super(key: key);

  @override
  CancellationScreenState createState() => CancellationScreenState();
}

class CancellationScreenState extends State<CancellationScreen> {



  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return BlocBuilder<AppCubit, AppState>(
      builder: (context, appState) {
        return BlocProvider<CancellationCubit>(
          create: (context) => CancellationCubit(CancellationState(rideRequestModel: widget.rideRequestModel,position: widget.currentPosition),),
          child: BlocListener<CancellationCubit, CancellationState>(
            listener: (contextCubit, stateRes) {
              if (stateRes.message != null) {
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.topSlide,
                    title: 'Success',
                    desc: 'You have cancelled the ride',
                    dismissOnBackKeyPress: false,
                    btnOkText: 'Go Back',
                    titleTextStyle: HelperStyle.textStyle(context, HelperColor.black, 15, FontWeight.w500),
                    descTextStyle: HelperStyle.textStyle(context, HelperColor.black, 14, FontWeight.w400),
                    dismissOnTouchOutside: false,
                    barrierColor: Colors.black.withOpacity(0.2),
                    btnCancelColor: HelperColor.primaryColor,
                    btnOkOnPress: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(pageHome, (route) => false);
                      contextCubit.read<CancellationCubit>().state.message = null;
                    }).show();
              }
            },
            child: BlocBuilder<CancellationCubit, CancellationState>(
              builder: (contextCubit, emeState) {

                return Scaffold(
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      backgroundColor: Colors.white,
                      title: Text(
                        'Cancellation Reasons',
                        style: HelperStyle.textStyleTwo(
                            context, HelperColor.black, 20.sp, FontWeight.normal),
                      ),
                      elevation: 0,
                      automaticallyImplyLeading: true,
                      centerTitle: true,
                      iconTheme: const IconThemeData(
                        color: Colors.black, //change your color here
                      ),
                    ),
                    bottomNavigationBar:Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ButtonWidget(
                            buttonTextSize: 20,
                            containerHeight: 50.h,
                            containerWidth: 341.w,
                            buttonText: "Continue",
                            color: HelperColor.primaryColor,
                            textColor: HelperColor.primaryLightColor,
                            onTap: () async {
                              contextCubit.read<CancellationCubit>().cancelTrip();
                            },
                            radius: 8,
                          ),
                        ],
                      ),
                    ),
                    body:BlurryModalProgressHUD(
                        inAsyncCall: emeState.isLoading,
                        dismissible: true,
                        child:SafeArea(
                          child: ListView(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    emeState.data.isEmpty ?
                                    const NotFoundCard(text: '',)
                                        : ListView.builder(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: emeState.data.length,
                                          itemBuilder: (context, index) {
                                            return CancellationWidget(
                                              cancellationModel: emeState.data[index],
                                              widgetIndex: index,
                                              index: emeState.selectedReason,
                                              onTap: () async {
                                                contextCubit.read<CancellationCubit>().selectedCancellation(index, emeState.data[index]);
                                              },
                                            );
                                          },
                                    ),
                                    SizedBox(height: 30.h,),

                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                    )
                );
              },
            ),
          ),
        );
      },
    );

  }
}