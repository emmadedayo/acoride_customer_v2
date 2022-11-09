import 'package:acoride/logic/cubits/app_cubit.dart';
import 'package:acoride/logic/cubits/login_cubit.dart';
import 'package:acoride/logic/states/login_state.dart';
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

import '../../core/helper/helper_color.dart';
import '../../core/helper/helper_style.dart';
import '../components/buttonWidget.dart';

class LoginScreenController extends StatefulWidget {
  const LoginScreenController({Key? key}) : super(key: key);

  @override
  LoginScreenControllerState createState() => LoginScreenControllerState();
}


class LoginScreenControllerState extends State<LoginScreenController> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(LoginState()),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return BlurryModalProgressHUD(
            inAsyncCall: state.isLoading,
            dismissible: true,
            child: BlocListener<LoginCubit, LoginState>(
              listener: (context, state) async {
                if (state.user != null) {
                  context.read<AppCubit>().setCurrentUser(state.user);
                  Navigator.of(context).pushNamedAndRemoveUntil(pageHome, (route) => false);
                }
                if (state.hasError != null && state.hasError!) {
                  showToast(state.message,
                      context: context,
                      backgroundColor: Colors.red,
                      axis: Axis.horizontal,
                      alignment: Alignment.center,
                      position: StyledToastPosition.top);
                  context.read<LoginCubit>().state.hasError = false;
                  context.read<LoginCubit>().state.message = null;
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
                              'Login to your account',
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
                                        controller:state.phoneController ,
                                        validator: MultiValidator([
                                          RequiredValidator(errorText: "* Required"),
                                        ]),
                                        decoration:  InputDecoration(
                                          filled: true,
                                          prefixIcon: const Icon(Iconsax.mobile,color: HelperColor.black,),
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
                                          contentPadding: const EdgeInsets.all(6),
                                        ),
                                      ),

                                      const SizedBox(height: 30.0),

                                      FormTextPrefix(
                                        hintText: 'Password',
                                        textInputType: TextInputType.text,
                                        controller:state.passwordController ,
                                        validator: MultiValidator([
                                          RequiredValidator(errorText: "* Required"),
                                        ]),
                                        decoration:  InputDecoration(
                                          filled: true,
                                          fillColor: HelperColor.fillColor,
                                          prefixIcon: const Icon(Iconsax.password_check,color: HelperColor.black,),
                                          border: const OutlineInputBorder(),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: HelperColor.primaryLightColor, width: 1)),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: HelperColor.primaryLightColor, width: 1.0),
                                          ),
                                          contentPadding: const EdgeInsets.all(6),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20.0),
                                  GestureDetector(
                                    child:Align(
                                      alignment: Alignment.centerLeft,
                                      child:RichText(
                                        text: TextSpan(
                                          text: 'Forgot Password?',
                                          style: HelperStyle.textStyle(
                                              context, HelperColor.primaryColor, 16.sp, FontWeight.normal),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: '',
                                                style: HelperStyle.textStyle(context, const Color(0xff284716),
                                                    12, FontWeight.normal)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    onTap: (){
                                      Navigator.of(context).pushNamed(resetAccountScreen);
                                    },
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
                                        buttonText: "Login",
                                        color: HelperColor.primaryColor,
                                        textColor:HelperColor.slightWhiteColor,
                                        onTap: (){
                                          FocusManager.instance.primaryFocus?.unfocus();
                                          if (_formKey.currentState!.validate()) {
                                            context.read<LoginCubit>().loginIn();
                                          } else {

                                          }
                                        }, radius: 30,

                                      ),
                                      SizedBox(height: 20.0.h),
                                      GestureDetector(
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'Don’t have an account?',
                                            style: HelperStyle.textStyle(
                                                context, HelperColor.primaryColor, 16.sp, FontWeight.normal),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: '  Sign Up',
                                                  style: HelperStyle.textStyle(context, HelperColor.black,
                                                      16.sp, FontWeight.normal)),
                                            ],
                                          ),
                                        ),
                                        onTap: (){
                                          Navigator.of(context).pushNamed(registrationScreenController);
                                        },
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
              ),
            ),
          );
        },
      ),
    );
  }
}