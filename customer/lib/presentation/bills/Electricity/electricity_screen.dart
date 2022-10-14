import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/logic/cubits/app_cubit.dart';
import 'package:acoride/logic/cubits/bills_cubit.dart';
import 'package:acoride/logic/states/bills_state.dart';
import 'package:acoride/presentation/bills/Data/components/data_variation_screen.dart';
import 'package:acoride/presentation/components/buttonWidget.dart';
import 'package:acoride/presentation/components/form_widget_screen.dart';
import 'package:acoride/presentation/router/router_constant.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../core/helper/helper_config.dart';
import 'component/electricity_component.dart';
import 'component/list_electricity.dart';


class ElectricityScreen extends StatefulWidget {
  const ElectricityScreen({Key? key}) : super(key: key);

  @override
  ElectricityScreenState createState() => ElectricityScreenState();
}

class ElectricityScreenState extends State<ElectricityScreen> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // UserItem user = context.read<AppCubit>().state.user!;
    return BlocProvider<BillsCubit>(
      create: (context) => BillsCubit(BillState(type: 'electricity-bill'),),
      child:BlocBuilder<BillsCubit, BillState>(
        builder: (contextCubit, emeState) {
          return BlurryModalProgressHUD(
            inAsyncCall: emeState.isLoadingCard,
            child: BlocListener<BillsCubit, BillState>(
                listener: (context, state) {
                  if (state.hasError == true) {
                    showToast(state.message,
                        context: context,
                        backgroundColor: Colors.red,
                        axis: Axis.horizontal,
                        alignment: Alignment.center,
                        position: StyledToastPosition.top);
                    context.read<BillsCubit>().state.hasError = null;
                    context.read<BillsCubit>().state.message = null;
                  }else if(state.hasError == false){
                    Navigator.of(context).pushNamedAndRemoveUntil(successScreen, (route) => false,
                        arguments: {'message': 'Your ${emeState.selectedBill?.name} bill was successfully paid'}
                    );
                  }

                  if(state.hasSmartCardError == false){
                    showModalBottomSheet(
                      enableDrag: false,
                      isDismissible: false,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0),)),
                      context: context,
                      builder: (context) {
                        return ElectricityComponent(
                          billState: emeState,
                          onTap: (){
                            contextCubit.read<BillsCubit>().payBill();
                          },
                          onCancel: (){
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                    context.read<BillsCubit>().state.hasError = null;
                    context.read<BillsCubit>().state.message = null;
                    context.read<BillsCubit>().state.hasSmartCardError = null;
                  }else if(state.hasSmartCardError == true){
                    showToast(state.message,
                        context: context,
                        backgroundColor: Colors.red,
                        axis: Axis.horizontal,
                        alignment: Alignment.center,
                        position: StyledToastPosition.top);
                    context.read<BillsCubit>().state.hasError = null;
                    context.read<BillsCubit>().state.message = null;
                    context.read<BillsCubit>().state.hasSmartCardError = null;
                  }
                },
                child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: HelperColor.primaryColor,
                    elevation: 0,
                    title: Text("Cable",style: HelperStyle.textStyle(context,Colors.white,17.sp,FontWeight.w500),),
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
                                    InkWell(
                                      onTap: () async {
                                        showModalBottomSheet(
                                          enableDrag: true,
                                          isDismissible: false,
                                          isScrollControlled: true,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(30.0),
                                                topRight: Radius.circular(30.0),
                                              )),
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ListElectricityScreen(bills: emeState.billModel);
                                          },
                                        ).then((value) => {
                                          if(value != null){
                                            contextCubit.read<BillsCubit>().electricitySelectedPlan(value)
                                          }
                                        });
                                      },
                                      child: FormTextPrefixWithValidation(
                                        hintText: 'Select Network Provider',
                                        textInputType: TextInputType.text,
                                        enabled: false,
                                        controller:emeState.planName,
                                        decoration:  InputDecoration(
                                          contentPadding: const EdgeInsets.all(10.0),
                                          filled: true,
                                          fillColor: HelperColor.fillColor,
                                          border: const OutlineInputBorder(),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: HelperColor.primaryLightColor, width: 1)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: HelperColor.primaryLightColor, width: 1)),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: HelperColor.primaryLightColor, width: 1.0),
                                          ),
                                          // contentPadding: const EdgeInsets.all(5),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.h,),
                                    InkWell(
                                      onTap: () async {
                                        if(emeState.billModel != null){
                                          showModalBottomSheet(
                                            enableDrag: true,
                                            isDismissible: false,
                                            isScrollControlled: true,
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(30.0),
                                                  topRight: Radius.circular(30.0),
                                                )),
                                            context: context,
                                            builder: (BuildContext context) {
                                              return VariationScreen(type: emeState.selectedBill?.serviceID,);
                                            },
                                          ).then((value) => {
                                            if(value != null){
                                              contextCubit.read<BillsCubit>().electricityPlan(value)
                                            }
                                          });
                                        }else{

                                        }
                                      },
                                      child: FormTextPrefixWithValidation(
                                        hintText: 'Select Meter Type',
                                        textInputType: TextInputType.text,
                                        enabled: false,
                                        controller:emeState.meterType,
                                        decoration:  InputDecoration(
                                          contentPadding: const EdgeInsets.all(10.0),
                                          filled: true,
                                          fillColor: HelperColor.fillColor,
                                          border: const OutlineInputBorder(),
                                          disabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: HelperColor.primaryLightColor, width: 1)),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: HelperColor.primaryLightColor, width: 1)),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: HelperColor.primaryLightColor, width: 1.0),
                                          ),
                                          // contentPadding: const EdgeInsets.all(5),
                                        ),
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
                                        contentPadding: const EdgeInsets.all(10.0),
                                        filled: true,
                                        fillColor: HelperColor.fillColor,
                                        border: const OutlineInputBorder(),
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(color: HelperColor.primaryLightColor, width: 1)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(color: HelperColor.primaryLightColor, width: 1)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: HelperColor.primaryLightColor, width: 1.0),
                                        ),
                                        // contentPadding: const EdgeInsets.all(5),
                                      ),
                                    ),
                                    SizedBox(height: 10.h,),
                                    FormTextPrefix(
                                      hintText: 'Meter Number',
                                      textInputType: TextInputType.number,
                                      controller: emeState.smartNumber,
                                      validator: MultiValidator([
                                        RequiredValidator(errorText: "* Required"),
                                      ]),
                                      autofocus: true,
                                      decoration:  InputDecoration(
                                        contentPadding: const EdgeInsets.all(10.0),
                                        filled: true,
                                        fillColor: HelperColor.fillColor,
                                        border: const OutlineInputBorder(),
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(color: HelperColor.primaryLightColor, width: 1)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(color: HelperColor.primaryLightColor, width: 1)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: HelperColor.primaryLightColor, width: 1.0),
                                        ),
                                        // contentPadding: const EdgeInsets.all(5),
                                      ),
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
                                        contentPadding: const EdgeInsets.all(10.0),
                                        filled: true,
                                        fillColor: HelperColor.fillColor,
                                        border: const OutlineInputBorder(),
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(color: HelperColor.primaryLightColor, width: 1)),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(color: HelperColor.primaryLightColor, width: 1)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: HelperColor.primaryLightColor, width: 1.0),
                                        ),
                                        // contentPadding: const EdgeInsets.all(5),
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
                                        if(emeState.billModel == null) {
                                          showToast('Select Network Provider',
                                              context: context,
                                              backgroundColor: Colors.red,
                                              axis: Axis.horizontal,
                                              alignment: Alignment.center,
                                              position: StyledToastPosition.top);
                                        }else{
                                          if (_formKey.currentState!.validate()) {
                                            contextCubit.read<BillsCubit>().getElectricityName();

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
            ),
          );
        },
      ),
    );
  }
}