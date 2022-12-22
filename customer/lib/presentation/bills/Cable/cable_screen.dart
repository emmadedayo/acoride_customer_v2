import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/logic/cubits/bills_cubit.dart';
import 'package:acoride/logic/states/bills_state.dart';
import 'package:acoride/presentation/bills/Airtime/components/airtime_component.dart';
import 'package:acoride/presentation/bills/Data/components/data_variation_screen.dart';
import 'package:acoride/presentation/components/buttonWidget.dart';
import 'package:acoride/presentation/components/form_widget_screen.dart';
import 'package:acoride/presentation/router/router_constant.dart';
import 'package:acoride/utils/blurry_modal_profress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../core/helper/helper_config.dart';
import 'component/cable_components.dart';

class CableScreenIndex extends StatefulWidget {
  const CableScreenIndex({
    Key? key,
    required this.walletBalance,
  }) : super(key: key);

  final String walletBalance;

  @override
  CableScreenIndexState createState() => CableScreenIndexState();
}

class CableScreenIndexState extends State<CableScreenIndex> {

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // UserItem user = context.read<AppCubit>().state.user!;
    return BlocProvider<BillsCubit>(
      create: (context) => BillsCubit(BillState(type: 'tv-subscription'),),
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
                      arguments: {'message': 'Your airtime transaction of ${HelperConfig.currencyFormat(state.amount.text)} was successful'}
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
                      return CableConfirmation(
                        billState: emeState,
                        onTap: (){
                          Navigator.pop(context);
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
                                        Text('${HelperConfig.currencyFormat(widget.walletBalance ?? '')}',style: HelperStyle.textStyle(context,Colors.white,20.sp,FontWeight.bold)),
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
                                    itemCount: emeState.isLoading?4:emeState.billModel.length,
                                    itemBuilder: (context, index) {
                                      if(emeState.isLoading){
                                        return const ShimmersWidget();
                                      }else{
                                        return AirtimeWidget(
                                          value: index,
                                          billModel: emeState.billModel[index],
                                          selected: emeState.selectedNetwork,
                                          onTap: (){
                                            contextCubit.read<BillsCubit>().selectNetwork(emeState.billModel[index],index);
                                          },
                                        );
                                      }
                                    },
                                  ),
                                  SizedBox(height: 10.h,),
                                  InkWell(
                                    onTap: () async {
                                      if(emeState.selectedBill != null){
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
                                            contextCubit.read<BillsCubit>().setDataPlan(value)
                                          }
                                        });
                                      }else{

                                      }
                                    },
                                    child: FormTextPrefixWithValidation(
                                      hintText: 'Select Plan',
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
                                  FormTextPrefix(
                                    hintText: 'Amount',
                                    textInputType: TextInputType.number,
                                    enabled: false,
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
                                    hintText: 'Smart Number',
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
                                      if(emeState.selectedNetwork == null) {
                                        showToast('Select Network Provider',
                                            context: context,
                                            backgroundColor: Colors.red,
                                            axis: Axis.horizontal,
                                            alignment: Alignment.center,
                                            position: StyledToastPosition.top);
                                      }else{
                                        if (_formKey.currentState!.validate()) {
                                          contextCubit.read<BillsCubit>().getSmartNumber();

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