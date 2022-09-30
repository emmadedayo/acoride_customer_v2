import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/logic/states/change_password_state.dart';
import 'package:acoride/presentation/components/buttonWidget.dart';
import 'package:acoride/presentation/components/form_widget_screen.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:iconsax/iconsax.dart';

import '../../../logic/cubits/change_password_cubit.dart';

class ChangePasswordScreenTwo extends StatefulWidget {
  const ChangePasswordScreenTwo({Key? key}) : super(key: key);

  @override
  ChangePasswordScreenTwoState createState() => ChangePasswordScreenTwoState();
}


class ChangePasswordScreenTwoState extends State<ChangePasswordScreenTwo> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    return BlocProvider<ChangePasswordCubit>(
      create: (context) => ChangePasswordCubit(ChangePasswordState()),
      child: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
        builder: (context, state) {
          return BlurryModalProgressHUD(
            inAsyncCall: state.isLoading,
            dismissible: true,
            child: BlocListener<ChangePasswordCubit, ChangePasswordState>(
                listener: (context, state) async {
                  if (state.hasError == true) {
                    showToast(state.message,
                        context: context,
                        backgroundColor: Colors.red,
                        axis: Axis.horizontal,
                        alignment: Alignment.center,
                        position: StyledToastPosition.top);

                    context.read<ChangePasswordCubit>().state.hasError = null;
                    context.read<ChangePasswordCubit>().state.message = null;
                  }else if(state.hasError == false){
                    showToast(state.message,
                        context: context,
                        backgroundColor: Colors.green,
                        axis: Axis.horizontal,
                        alignment: Alignment.center,
                        position: StyledToastPosition.top);
                    context.read<ChangePasswordCubit>().state.hasError = null;
                    context.read<ChangePasswordCubit>().state.message = null;
                    Navigator.pop(context);
                  }
                },
                child: PlatformScaffold(
                  iosContentPadding: false,
                  iosContentBottomPadding: false,
                  backgroundColor: Colors.white,
                  appBar: PlatformAppBar(
                    backgroundColor: Colors.white,
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
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 30.0.h),
                              Text(
                                'Set a new password',
                                style:HelperStyle.textStyleTwo(
                                    context, HelperColor.black, 35.sp, FontWeight.normal),
                              ),

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
                                          hintText: 'Old Password',
                                          textInputType: TextInputType.text,
                                          controller:state.oldPassword ,
                                          validator: MultiValidator([
                                            RequiredValidator(errorText: "* Required"),
                                          ]),
                                          decoration:  InputDecoration(
                                            filled: true,
                                            fillColor: HelperColor.fillColor,
                                            prefixIcon: const Icon(Iconsax.password_check,color: HelperColor.black,),
                                            suffixIcon: const Icon(Iconsax.eye,color: HelperColor.black,),
                                            border: const OutlineInputBorder(),
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
                                        FormTextPrefix(
                                          hintText: 'Password',
                                          textInputType: TextInputType.text,
                                          controller:state.newPassword ,
                                          validator: MultiValidator([
                                            RequiredValidator(errorText: "* Required"),
                                          ]),
                                          decoration:  InputDecoration(
                                            filled: true,
                                            fillColor: HelperColor.fillColor,
                                            prefixIcon: const Icon(Iconsax.password_check,color: HelperColor.black,),
                                            suffixIcon: const Icon(Iconsax.eye,color: HelperColor.black,),
                                            border: const OutlineInputBorder(),
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
                                        FormTextPrefix(
                                          hintText: 'Confirm Password',
                                          textInputType: TextInputType.text,
                                          controller:state.confirmPassword ,
                                          validator: MultiValidator([
                                            RequiredValidator(errorText: "* Required"),
                                          ]),
                                          decoration:  InputDecoration(
                                            filled: true,
                                            fillColor: HelperColor.fillColor,
                                            prefixIcon: const Icon(Iconsax.password_check,color: HelperColor.black,),
                                            suffixIcon: const Icon(Iconsax.eye,color: HelperColor.black,),
                                            border: const OutlineInputBorder(),
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
                                    const SizedBox(height: 20.0),
                                    const SizedBox(height: 30.0),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        ButtonWidget(
                                          buttonTextSize: 18,
                                          containerHeight: 47.h,
                                          containerWidth: 341.w,
                                          buttonText: "Change Password",
                                          color: HelperColor.black,
                                          textColor:HelperColor.primaryColor,
                                          onTap: (){
                                            FocusManager.instance.primaryFocus?.unfocus();
                                            if (_formKey.currentState!.validate()) {

                                              context.read<ChangePasswordCubit>().changePassword();

                                            } else {

                                            }
                                          }, radius: 30,

                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 24.0),

                                  ],
                                ),
                              ),
                              //  SizedBox(height: 24.0),
                            ],
                          ),
                        )
                      ],
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