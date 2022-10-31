import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_config.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/logic/cubits/airtime_cubit.dart';
import 'package:acoride/logic/cubits/app_cubit.dart';
import 'package:acoride/logic/states/airtime_state.dart';
import 'package:acoride/logic/states/app_state.dart';
import 'package:acoride/presentation/components/buttonWidget.dart';
import 'package:acoride/presentation/components/form_widget_screen.dart';
import 'package:acoride/presentation/router/router_constant.dart';
import 'package:acoride/utils/blurry_modal_profress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'components/airtime_component.dart';


class AirtimeScreenIndex extends StatefulWidget {
  const AirtimeScreenIndex({Key? key}) : super(key: key);

  @override
  AirtimeScreenIndexState createState() => AirtimeScreenIndexState();
}

class AirtimeScreenIndexState extends State<AirtimeScreenIndex> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocBuilder<AppCubit,AppState>(
        builder: (appContext,appState){
          return BlocProvider<AirtimeCubit>(
            create: (context) => AirtimeCubit(AirtimeState(),),
            child: BlocListener<AirtimeCubit, AirtimeState>(
              listener: (context, state) {
                if (state.hasError== true) {
                  showToast(state.message,
                      context: context,
                      backgroundColor: Colors.red,
                      axis: Axis.horizontal,
                      alignment: Alignment.center,
                      position: StyledToastPosition.top);
                  context.read<AirtimeCubit>().state.hasError = null;
                  context.read<AirtimeCubit>().state.message = null;
                }else if(state.hasError == false){
                  showToast(state.message,
                      context: context,
                      backgroundColor: Colors.green,
                      axis: Axis.horizontal,
                      alignment: Alignment.center,
                      position: StyledToastPosition.top);
                  context.read<AirtimeCubit>().state.hasError = null;
                  context.read<AirtimeCubit>().state.message = null;
                  Navigator.of(context).pushNamedAndRemoveUntil(successScreen, (route) => false,
                      arguments: {'message': 'Your airtime transaction of ${state.amount.text} was successful'}
                  );
                }
              },
              child: BlocBuilder<AirtimeCubit, AirtimeState>(
                builder: (contextCubit, emeState) {

                  return BlurryModalProgressHUD(
                      inAsyncCall: emeState.isLoadingCard,
                      dismissible: true,
                      child: Scaffold(
                        backgroundColor: Colors.white,
                        appBar: AppBar(
                          backgroundColor: HelperColor.primaryColor,
                          elevation: 0,
                          title: Text("Airtime",style: HelperStyle.textStyle(context,Colors.white,17.sp,FontWeight.w500),),
                          centerTitle: true,
                          leading: IconButton(
                            icon: const Icon(Icons.arrow_back_ios,color: Colors.white,),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          ),
                        ),
                        body:SafeArea(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(bottom: 10).r,
                                  width: MediaQuery.of(context).size.width,
                                  color: HelperColor.primaryColor,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.only(left: 10,right: 20,top: 7,bottom: 7).r,
                                        //height: 60,
                                        padding: const EdgeInsets.only(left: 10,right: 20,top: 7,bottom: 7).r,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text("Balance",style: HelperStyle.textStyle(context,HelperColor.slightWhiteColor,11.sp,FontWeight.normal)),
                                                const SizedBox(height: 5,),
                                                Text('${HelperConfig.currencyFormat(context.read<AppCubit>().state.user?.walletBalance.toString() ?? '')}',style: HelperStyle.textStyle(context,Colors.white,20.sp,FontWeight.bold)),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade50,
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Select Network Provider",style: HelperStyle.textStyle(context,HelperColor.black,13.sp,FontWeight.normal)),
                                          GridView.builder(
                                            shrinkWrap: true,
                                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4,childAspectRatio:0.9,mainAxisSpacing: 8,crossAxisSpacing: 10),
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: emeState.isLoading?4:emeState.billModel.length-1,
                                            itemBuilder: (context, index) {
                                              if(emeState.isLoading){
                                                return const ShimmersWidget();
                                              }else{
                                                return AirtimeWidget(
                                                  value: index,
                                                  billModel: emeState.billModel[index],
                                                  selected: emeState.selectedNetwork,
                                                  onTap: (){
                                                    contextCubit.read<AirtimeCubit>().selectNetwork(emeState.billModel[index],index);
                                                  },
                                                );
                                              }
                                            },
                                          ),
                                          SizedBox(height: 10.h,),
                                          FormTextPrefix(
                                            hintText: 'Phone Number',
                                            textInputType: TextInputType.number,
                                            controller: emeState.phone,
                                            validator: MultiValidator([
                                              RequiredValidator(errorText: "* Required"),
                                            ]),
                                            autofocus: true,
                                            decoration:  InputDecoration(
                                              filled: true,
                                              fillColor: HelperColor.fillColor,
                                              border: const OutlineInputBorder(),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                  borderSide: const BorderSide(color: HelperColor.primaryLightColor, width: 1)),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: HelperColor.primaryLightColor, width: 1.0),
                                              ),
                                              contentPadding: const EdgeInsets.all(7),
                                            ),
                                          ),
                                          SizedBox(height: 10.h,),
                                          FormTextPrefix(
                                            hintText: 'Amount',
                                            textInputType: TextInputType.number,
                                            controller: emeState.amount,
                                            validator: MultiValidator([
                                              RequiredValidator(errorText: "* Required"),
                                            ]),
                                            decoration:  InputDecoration(
                                              filled: true,
                                              fillColor: HelperColor.fillColor,
                                              border: const OutlineInputBorder(),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                  borderSide: const BorderSide(color: HelperColor.primaryLightColor, width: 1)),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: HelperColor.primaryLightColor, width: 1.0),
                                              ),
                                              contentPadding: const EdgeInsets.all(7),
                                            ),
                                          ),
                                          SizedBox(height: 10.h,),

                                          ButtonWidget(
                                            buttonTextSize: 18,
                                            containerHeight: 47.h,
                                            containerWidth: 341.w,
                                            buttonText: "Continue",
                                            color: HelperColor.primaryColor,
                                            textColor:HelperColor.slightWhiteColor,
                                            onTap: (){
                                              FocusManager.instance.primaryFocus?.unfocus();
                                              if(emeState.selectedNetwork == null) {
                                                showToast('Select Network Provider',
                                                    context: context,
                                                    backgroundColor: Colors.red,
                                                    axis: Axis.horizontal,
                                                    alignment: Alignment.center,
                                                    position: StyledToastPosition.top);
                                              }else{
                                                if (_formKey.currentState!.validate()) {
                                                  showModalBottomSheet(
                                                    enableDrag: false,
                                                    isDismissible: false,
                                                    isScrollControlled: true,
                                                    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0),)),
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AirtimeConfirmation(
                                                        airtimeState: emeState,
                                                        onTap: (){
                                                          contextCubit.read<AirtimeCubit>().payBill();
                                                        },
                                                        onCancel: (){
                                                          Navigator.pop(context);
                                                        },
                                                      );
                                                    },
                                                  );
                                                } else {
                                                  showToast('Please fill all fields',
                                                      context: context,
                                                      backgroundColor: Colors.red,
                                                      axis: Axis.horizontal,
                                                      alignment: Alignment.center,
                                                      position: StyledToastPosition.top);
                                                }
                                              }
                                            }, radius: 30,

                                          ),
                                        ],
                                      ),
                                    )
                                ),

                              ],
                            ),
                          ),
                        ),
                      )
                  );
                },
              ),
            ),
          );
        }
    );
  }
}