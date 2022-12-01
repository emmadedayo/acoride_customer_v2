import 'package:acoride/logic/cubits/forgot_password_cubit.dart';
import 'package:acoride/logic/states/forgot_password_state.dart';
import 'package:acoride/presentation/components/form_widget_screen.dart';
import 'package:acoride/presentation/router/router_constant.dart';
import 'package:acoride/utils/blurry_modal_profress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:iconsax/iconsax.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../core/helper/helper_color.dart';
import '../../core/helper/helper_style.dart';
import '../components/buttonWidget.dart';
import '../success/success_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String phone;
  const ChangePasswordScreen({Key? key, required this.phone}) : super(key: key);

  @override
  ChangePasswordScreenState createState() => ChangePasswordScreenState();
}


class ChangePasswordScreenState extends State<ChangePasswordScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    return BlocProvider<ForgotPasswordCubit>(
      create: (context) => ForgotPasswordCubit(ForgotPasswordState(phone: widget.phone)),
      child: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
        builder: (regContext, regState) {
          return BlurryModalProgressHUD(
            inAsyncCall: regState.isLoading,
            dismissible: true,
            child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
                listener: (context, state) async {
                  if (state.hasError == false) {
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
                        return SuccessScreen(
                          message: 'Your password has been changed successfully',
                          onPressed: (){
                            Navigator.of(context).pushNamedAndRemoveUntil(baseAuthScreen, (route) => false);
                          },
                        );
                      },
                    );
                  }else if (state.hasError==true) {
                    showToast(state.message,
                        context: context,
                        backgroundColor: Colors.red,
                        axis: Axis.horizontal,
                        alignment: Alignment.center,
                        position: StyledToastPosition.top);
                    context.read<ForgotPasswordCubit>().state.hasError = null;
                    context.read<ForgotPasswordCubit>().state.message = null;
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
                                          hintText: 'Password',
                                          textInputType: TextInputType.text,
                                          controller:regState.passwordController,
                                          validator: MultiValidator([
                                            RequiredValidator(errorText: "* Required"),
                                          ]),
                                          decoration:  InputDecoration(
                                            filled: true,
                                            fillColor: HelperColor.fillColor,
                                            prefixIcon: const Icon(LineAwesomeIcons.lock,color: HelperColor.black,),
                                            suffixIcon: const Icon(LineAwesomeIcons.eye,color: HelperColor.black,),
                                            border: const OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(color: HelperColor.primaryLightColor, width: 1)),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  color: HelperColor.primaryLightColor, width: 1.0),
                                            ),
                                            contentPadding: const EdgeInsets.all(5),
                                          ),
                                        ),
                                        SizedBox(height: 20.0.h),
                                        FormTextPrefix(
                                          hintText: 'Confirm Password',
                                          textInputType: TextInputType.text,
                                          controller:regState.confirmPasswordController,
                                          validator: MultiValidator([
                                            RequiredValidator(errorText: "* Required"),
                                          ]),
                                          decoration:  InputDecoration(
                                            filled: true,
                                            fillColor: HelperColor.fillColor,
                                            prefixIcon: const Icon(LineAwesomeIcons.lock,color: HelperColor.black,),
                                            suffixIcon: const Icon(LineAwesomeIcons.eye,color: HelperColor.black,),
                                            border: const OutlineInputBorder(),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(color: HelperColor.primaryLightColor, width: 1)),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  color: HelperColor.primaryLightColor, width: 1.0),
                                            ),
                                            contentPadding: const EdgeInsets.all(5),
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
                                          color: HelperColor.primaryColor,
                                          textColor:HelperColor.whiteColor,
                                          onTap: (){
                                            FocusManager.instance.primaryFocus?.unfocus();
                                            if (_formKey.currentState!.validate()) {
                                              regContext.read<ForgotPasswordCubit>().resetAccount(widget.phone);
                                            } else {
                                              showToast("Please fill all the fields",
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