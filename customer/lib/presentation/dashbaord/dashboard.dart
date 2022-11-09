import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/logic/cubits/app_cubit.dart';
import 'package:acoride/logic/cubits/dashboard_cubit.dart';
import 'package:acoride/logic/states/app_state.dart';
import 'package:acoride/presentation/dashbaord/components/dashboard_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../logic/states/dashboard_state.dart';
import 'package:acoride/utils/blurry_modal_profress_hud.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key, }) : super(key: key);
  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit,AppState>(
        builder: (appContext,appState){
          return BlocProvider<DashBoardCubit>(
            create: (context) => DashBoardCubit(DashBoardState()),
            child: Scaffold(
              backgroundColor: HelperColor.slightWhiteColor,
              body: SafeArea(
                child: BlocBuilder<DashBoardCubit, DashBoardState>(
                  builder: (dashboardContext, dashboardState) {
                    return BlurryModalProgressHUD(
                      inAsyncCall: dashboardState.userLoading,
                      child: BlocListener<DashBoardCubit, DashBoardState>(
                          listener: (context, state) async {
                            // if (state.rideRequestModel != null) {
                            //   if(appState.rideDetails?.rideType == "CREATE_RIDE"){
                            //     Navigator.pushReplacement(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (
                            //             context) => OrderTripScreen(rideRequestModel: state.rideRequestModel!,),
                            //       ),
                            //     );
                            //   }else if(appState.rideDetails?.rideType == "CONFIRM_RIDE") {
                            //     Navigator.pushReplacement(
                            //       context,
                            //       MaterialPageRoute(
                            //         builder: (
                            //             context) => OrderTripScreen(rideRequestModel: state.rideRequestModel!,),
                            //       ),
                            //     );
                            //   }
                            // }
                          },
                          child:ListView(
                            children: [
                              LayoutBuilder(
                                  builder:(context, ctx){
                                    if(dashboardState.userLoading){
                                      return DashboardAppState(appState: appState,);
                                    }else{
                                      return DashboardFullState(dashBoardState: dashboardState,);
                                    }
                                  }
                              )
                            ],
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