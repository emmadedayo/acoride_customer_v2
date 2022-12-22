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
import 'package:acoride/utils/blurry_modal_profress_hud.dart';
import 'package:acoride/utils/confirmation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

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
              if (state.hasError == true) {
                showToast(state.message,
                    context: context,
                    backgroundColor: Colors.red,
                    axis: Axis.horizontal,
                    alignment: Alignment.center,
                    position: StyledToastPosition.top);
                context.read<EmergencyCubit>().state.hasError = null;
                context.read<EmergencyCubit>().state.message = null;
              }else if(state.hasError == false){
                showToast(state.message,
                    context: context,
                    backgroundColor: Colors.green,
                    axis: Axis.horizontal,
                    alignment: Alignment.center,
                    position: StyledToastPosition.top);
                context.read<EmergencyCubit>().state.hasError = null;
                context.read<EmergencyCubit>().state.message = null;
              }
            },
            child: BlocBuilder<EmergencyCubit, EmergencyState>(
              builder: (contextCubit, emeState) {

                return Scaffold(
                  backgroundColor: HelperColor.slightWhiteColor,
                  appBar: AppBar(
                    backgroundColor:HelperColor.slightWhiteColor,
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
                      dismissible: false,
                      child:SafeArea(
                        child: ListView(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  emeState.emergency.isEmpty ?
                                      const Center(
                                        child: NotFoundLottie(),
                                      )
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
                                              showModalBottomSheet(
                                                enableDrag: true,
                                                isDismissible: true,
                                                isScrollControlled: true,
                                                shape: const RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(30.0),
                                                      topRight: Radius.circular(30.0),
                                                    )),
                                                context: context,
                                                builder: (context) {
                                                  return DeleteConfirmationWidget(
                                                    onCancel: (){
                                                      Navigator.pop(context);
                                                    },
                                                    onDelete: (){
                                                      Navigator.pop(context);
                                                      contextCubit.read<EmergencyCubit>().delete(emeState.emergency[index].id);
                                                    },
                                                  );
                                                },
                                              );
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