import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/logic/cubits/app_cubit.dart';
import 'package:acoride/logic/cubits/emergency_cubit.dart';
import 'package:acoride/logic/states/app_state.dart';
import 'package:acoride/logic/states/emergency_state.dart';
import 'package:acoride/presentation/components/buttonWidget.dart';
import 'package:acoride/presentation/profile/emergency/add_emergency_screen.dart';
import 'package:acoride/presentation/profile/emergency/component/emergency_component.dart';
import 'package:acoride/presentation/profile/emergency/edit_emergency_screen.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../components/noWidgetFound.dart';


class EmergencyContactScreen extends StatefulWidget {
  const EmergencyContactScreen({Key? key}) : super(key: key);

  @override
  EmergencyContactScreenState createState() => EmergencyContactScreenState();
}

class EmergencyContactScreenState extends State<EmergencyContactScreen> {



  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return BlocBuilder<AppCubit, AppState>(
      builder: (context, appState) {
        return BlocProvider<EmergencyCubit>(
          create: (context) => EmergencyCubit(EmergencyState(),),
          child: BlocListener<EmergencyCubit, EmergencyState>(
            listener: (context, state) {

            },
            child: BlocBuilder<EmergencyCubit, EmergencyState>(
              builder: (contextCubit, emeState) {

                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    title: Text(
                      'Emergency Management',
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
                          buttonText: "Add Contact",
                          color: HelperColor.primaryColor,
                          textColor: HelperColor.primaryLightColor,
                          onTap: () async {
                           Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddEmergencyScreen(),
                              ),
                            ).then((value) => {
                               contextCubit.read<EmergencyCubit>().initState()
                           });
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
                                  emeState.emergency.isEmpty ?
                                  const NotFoundCard(text: 'No Emergency Contact Added',)
                                      : ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: emeState.emergency.length,
                                    itemBuilder: (context, index) {
                                      return EmergencyWidget(
                                        emergencyModel: emeState.emergency[index],
                                        onTap: () async {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => UpdateEmergencyScreen(
                                                emergencyModel: emeState.emergency[index],
                                              ),
                                            ),
                                          ).then((value) => {
                                            contextCubit.read<EmergencyCubit>().initState()
                                          });
                                        },
                                        deleteTap: () async {
                                          //emeState.isLoading = true;
                                          contextCubit.read<EmergencyCubit>().delete(emeState.emergency[index].id);
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