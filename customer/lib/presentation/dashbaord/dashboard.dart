import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/logic/cubits/app_cubit.dart';
import 'package:acoride/logic/cubits/dashboard_cubit.dart';
import 'package:acoride/logic/states/app_state.dart';
import 'package:acoride/presentation/dashbaord/components/dashboard_widget.dart';
import 'package:acoride/presentation/splashscreen/components/screenappupdate.dart';
import 'package:acoride/presentation/splashscreen/updatescreen.dart';
import 'package:acoride/utils/blurry_modal_profress_hud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:launch_review/launch_review.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../logic/states/dashboard_state.dart';

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
                            if (state.appSettings?.androidAppVersion != '1.0.2') {
                              if(state.appSettings?.forceUpdate == true){
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const AppUpdateScreen(),
                                  ),
                                );
                              }else{
                                showModalBottomSheet(
                                  enableDrag: false,
                                  isDismissible: false,
                                  isScrollControlled: false,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30.0),
                                        topRight: Radius.circular(30.0),
                                      )),
                                  context: context,
                                  builder: (BuildContext bc) {
                                    return SoftScreenUpdate(
                                      update: (){
                                        LaunchReview.launch(androidAppId: "com.acoride.customer", iOSAppId: "");
                                      },
                                      cancel: (){
                                        Navigator.pop(context);
                                      }
                                    );
                                  },
                                );
                              }
                            }
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