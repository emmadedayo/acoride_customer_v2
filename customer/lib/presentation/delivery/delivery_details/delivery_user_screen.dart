import 'package:acoride/core/constant/enum.dart';
import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/data/model/UserModel.dart';
import 'package:acoride/logic/cubits/app_cubit.dart';
import 'package:acoride/logic/cubits/delivery_receiver_cubit.dart';
import 'package:acoride/logic/states/delivery_receiver_state.dart';
import 'package:acoride/presentation/components/buttonWidget.dart';
import 'package:acoride/presentation/components/form_widget_screen.dart';
import 'package:acoride/presentation/components/progressive_loading.dart';
import 'package:acoride/presentation/delivery/components/delivery_component_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../components/delivery_components.dart';

class DeliveryUserScreen extends StatefulWidget {

  final List<Map<String, dynamic>> dataFrom;
  final List<Map<String, dynamic>> dataTo;

  const DeliveryUserScreen({Key? key,required this.dataFrom, required this.dataTo}) : super(key: key);

  @override
  DeliveryUserScreenState createState() => DeliveryUserScreenState();
}


class DeliveryUserScreenState extends State<DeliveryUserScreen> {

  final _formKey = GlobalKey<FormState>();

  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel user = context.read<AppCubit>().state.user!;
    return BlocProvider<DeliveryReceiverCubit>(
      create: (context) => DeliveryReceiverCubit(DeliveryReceiverState(dataFrom: widget.dataFrom, dataTo: widget.dataTo, myAuth: user)),
      child: BlocBuilder<DeliveryReceiverCubit, DeliveryReceiverState>(
        builder: (contextCubit, dayState) {
          return BlocListener<DeliveryReceiverCubit, DeliveryReceiverState>(
              listener: (context, state) async {
                if(state.showLoader == true){
                  showModalBottomSheet(
                    enableDrag: false,
                    isDismissible: false,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        )),
                    context: context,
                    builder: (BuildContext context) {
                      return const DeliveryLoadingScreen();
                    },
                  ).then((value) => {
                    if(value != null){
                      debugPrint('value is $value'),
                      contextCubit.read<DeliveryReceiverCubit>().setStateName(value)
                    }
                  });
                }
                if (state.hasError == true) {
                  showToast(state.message,
                      context: context,
                      backgroundColor: Colors.red,
                      axis: Axis.horizontal,
                      alignment: Alignment.center,
                      position: StyledToastPosition.top);
                  context.read<DeliveryReceiverCubit>().state.hasError = null;
                  context.read<DeliveryReceiverCubit>().state.message = null;
                }else if(state.hasError == false){
                  showToast(state.message,
                      context: context,
                      backgroundColor: Colors.green,
                      axis: Axis.horizontal,
                      alignment: Alignment.center,
                      position: StyledToastPosition.top);
                 // Navigator.pop(context);
                  contextCubit.read<DeliveryReceiverCubit>().state.hasError = null;
                  contextCubit.read<DeliveryReceiverCubit>().state.message = null;
                }
              },
              child: PlatformScaffold(
                iosContentPadding: false,
                iosContentBottomPadding: false,
                backgroundColor: Colors.white,
                appBar: PlatformAppBar(
                  backgroundColor: Colors.white,
                  title: Text(
                    'Delivery Details',
                    style: HelperStyle.textStyleTwo(
                        context, HelperColor.black, 20.sp, FontWeight.normal),
                  ),
                  material: (_, __)  => MaterialAppBarData(
                    elevation: 0,
                    automaticallyImplyLeading: true,
                    centerTitle: true,
                    iconTheme: const IconThemeData(
                      color: Colors.black, //change your color here
                    ),
                  ),
                  cupertino: (_, __) => CupertinoNavigationBarData(
                      automaticallyImplyLeading: true
                  ),
                ),
                body: SafeArea(
                  child: ListView(
                    children: [
                      ProgressiveLoading(
                        color: HelperColor.black,
                        inAsyncCall: dayState.isLoading,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          children: <Widget>[
                            Form(
                              autovalidateMode: AutovalidateMode.disabled,
                              key: _formKey,
                              child:Column(
                                children: <Widget>[
                                  SizedBox(height: 30.0.h),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      FormTextPrefix(
                                        hintText: 'Phone Number',
                                        textInputType: TextInputType.phone,
                                        controller:dayState.phoneNumber,
                                        maxLength: 11,
                                        validator: MultiValidator([
                                          RequiredValidator(errorText: 'Phone Number is required'),
                                          MinLengthValidator(11, errorText: 'Phone Number must be at least 10 digits long'),
                                          MaxLengthValidator(11, errorText: 'Phone Number must not be greater than 10 digits'),
                                        ]),
                                        valueChanged: (value){
                                          if(value.toString().length == 11){
                                            contextCubit.read<DeliveryReceiverCubit>().verifyUser(value);
                                          }
                                        },
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

                                      const SizedBox(height: 30.0),
                                      FormTextPrefixWithValidation(
                                        hintText: 'Receiver Name',
                                        textInputType: TextInputType.text,
                                        controller:dayState.fullUsername,
                                        enabled:false,
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

                                      SizedBox(height: 20.0.h),

                                      GestureDetector(
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
                                              return DeliveryComponentCategory(state: dayState,);
                                            },
                                          ).then((value) => {
                                            if(value != null){
                                              debugPrint('value is $value'),
                                              contextCubit.read<DeliveryReceiverCubit>().setStateCategory(value)
                                            }
                                          });
                                        },
                                        child: FormTextPrefixWithValidation(
                                          hintText: 'Package Category',
                                          textInputType: TextInputType.text,
                                          enabled: false,
                                          controller:dayState.categoryMethod,
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


                                      SizedBox(height: 20.0.h),

                                      GestureDetector(
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
                                              return const DeliveryPaymentWidget();
                                            },
                                          ).then((value) => {
                                            if(value != null){
                                              debugPrint('value is $value'),
                                              contextCubit.read<DeliveryReceiverCubit>().setStateName(value)
                                            }
                                          });
                                        },
                                        child: FormTextPrefixWithValidation(
                                          hintText: 'Payment Method',
                                          textInputType: TextInputType.text,
                                          enabled: false,
                                          controller:dayState.paymentMethod,
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

                                      SizedBox(height: 20.0.h),

                                      GestureDetector(
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
                                              return const DeliveryPayingAccountWidget();
                                            },
                                          ).then((value) => {
                                            if(value != null){
                                              debugPrint('value is $value'),
                                              contextCubit.read<DeliveryReceiverCubit>().setPaymentStateName(value)
                                            }
                                          });
                                        },
                                        child: FormTextPrefixWithValidation(
                                          hintText: 'Paying Account',
                                          textInputType: TextInputType.text,
                                          enabled: false,
                                          controller:dayState.whoIsPaying,
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

                                      SizedBox(height: 20.0.h),
                                      FormTextPrefixWithValidation(
                                        hintText: 'Enter Amount',
                                        textInputType: const TextInputType.numberWithOptions(),
                                        controller:dayState.amount ,
                                        enabled:false,
                                        decoration:  InputDecoration(
                                          filled: true,
                                          fillColor: HelperColor.fillColor,
                                          border: const OutlineInputBorder(),
                                          contentPadding: const EdgeInsets.all(10.0),
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
                                    ],
                                  ),
                                  const SizedBox(height: 50.0),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      ButtonWidget(
                                        buttonTextSize: 18,
                                        containerHeight: 47.h,
                                        containerWidth: 341.w,
                                        buttonText: "Continue",
                                        color: HelperColor.primaryColor,
                                        textColor:HelperColor.slightWhiteColor,
                                        onTap: (){
                                          FocusManager.instance.primaryFocus?.unfocus();
                                          if (_formKey.currentState!.validate()) {
                                            if(dayState.fullUsername.text.isEmpty){
                                              showToast('Full Name is required',
                                                  context: context,
                                                  backgroundColor: Colors.red,
                                                  axis: Axis.horizontal,
                                                  alignment: Alignment.center,
                                                  position: StyledToastPosition.top);
                                            }else{
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
                                                  return ConfirmDeliveryDetails(
                                                      deliveryReceiverState: dayState,
                                                      voidCallback: (){
                                                        Navigator.pop(context);
                                                        contextCubit.read<DeliveryReceiverCubit>().searchDriver();
                                                      },
                                                  );
                                                },
                                              );
                                            }
                                          } else {
                                            showToast('Please fill all fields',
                                                context: context,
                                                backgroundColor: Colors.red,
                                                axis: Axis.horizontal,
                                                alignment: Alignment.center,
                                                position: StyledToastPosition.top);
                                          }
                                        }, radius: 30,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 24.0),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
          );
        },
      ),
    );
  }
}