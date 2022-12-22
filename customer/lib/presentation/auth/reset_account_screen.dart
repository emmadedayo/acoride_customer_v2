import 'package:acoride/logic/cubits/forgot_password_cubit.dart';
import 'package:acoride/presentation/components/form_widget_screen.dart';
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
import '../../logic/states/forgot_password_state.dart';
import '../components/buttonWidget.dart';
import '../router/router_constant.dart';

class ResetAccountScreen extends StatefulWidget {
  const ResetAccountScreen({Key? key}) : super(key: key);

  @override
  ResetAccountScreenState createState() => ResetAccountScreenState();
}


class ResetAccountScreenState extends State<ResetAccountScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    return BlocProvider<ForgotPasswordCubit>(
      create: (context) => ForgotPasswordCubit(ForgotPasswordState()),
      child: BlocBuilder<ForgotPasswordCubit, ForgotPasswordState>(
        builder: (regContext, regState) {
          return BlurryModalProgressHUD(
            inAsyncCall: regState.isLoading,
            dismissible: false,
            child: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
                listener: (context, state) async {
                  if (state.hasError == false) {
                    Navigator.of(context).pushNamedAndRemoveUntil(verifyResetPassword, (route) => true,arguments: {'phone': state.phoneController.text});
                  }
                  if (state.hasError==true) {
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
                                'Forgot Password?',
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
                                          hintText: 'Phone Number',
                                          textInputType: TextInputType.number,
                                          controller: regState.phoneController,
                                          validator: MultiValidator([
                                            RequiredValidator(errorText: "* Required"),
                                            MinLengthValidator(11, errorText: 'Password must be at least 11 digits long'),
                                            MaxLengthValidator(11, errorText: 'Password must be at least 11 digits long')
                                          ]),
                                          decoration:  InputDecoration(
                                            filled: true,
                                            prefixIcon: const Icon(LineAwesomeIcons.phone,color: HelperColor.black,),
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
                                            contentPadding: const EdgeInsets.all(5),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 30.0),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        ButtonWidget(
                                          buttonTextSize: 18,
                                          containerHeight: 47.h,
                                          containerWidth: 341.w,
                                          buttonText: "Reset Password",
                                          color: HelperColor.primaryColor,
                                          textColor:HelperColor.slightWhiteColor,
                                          onTap: (){
                                            FocusManager.instance.primaryFocus?.unfocus();
                                            if (_formKey.currentState!.validate()) {
                                              regContext.read<ForgotPasswordCubit>().verifyResetAccount();
                                            } else {

                                              showToast('Please fill all the fields',
                                                  context: context,
                                                  backgroundColor: Colors.red,
                                                  axis: Axis.horizontal,
                                                  alignment: Alignment.center,
                                                  position: StyledToastPosition.top);

                                            }
                                          }, radius: 30,

                                        ),
                                        SizedBox(height: 20.0.h),
                                        // GestureDetector(
                                        //   child: RichText(
                                        //     text: TextSpan(
                                        //       text: 'Don’t have an account?',
                                        //       style: HelperStyle.textStyle(
                                        //           context, HelperColor.primaryColor, 16.sp, FontWeight.normal),
                                        //       children: <TextSpan>[
                                        //         TextSpan(
                                        //             text: '  Sign Up',
                                        //             style: HelperStyle.textStyle(context, HelperColor.black,
                                        //                 16.sp, FontWeight.normal)),
                                        //       ],
                                        //     ),
                                        //   ),
                                        //   onTap: (){
                                        //     Navigator.of(context).pushNamed(resetAccountScreen);
                                        //   },
                                        // ),

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