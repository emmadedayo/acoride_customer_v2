import 'package:acoride/logic/cubits/registration_cubit.dart';
import 'package:acoride/logic/states/registration_state.dart';
import 'package:acoride/presentation/components/form_widget_screen.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
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
import '../router/router_constant.dart';
import '../state/state_component.dart';

class RegistrationScreenController extends StatefulWidget {
  const RegistrationScreenController({Key? key}) : super(key: key);

  @override
  RegistrationScreenControllerState createState() => RegistrationScreenControllerState();
}


class RegistrationScreenControllerState extends State<RegistrationScreenController> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    return BlocProvider<RegistrationCubit>(
      create: (context) => RegistrationCubit(RegistrationState()),
      child: BlocBuilder<RegistrationCubit, RegistrationState>(
        builder: (regContext, regState) {
          return BlurryModalProgressHUD(
            inAsyncCall: regState.isLoading,
            dismissible: true,
            child: BlocListener<RegistrationCubit, RegistrationState>(
              listener: (context, state) async {
                if (state.success==true) {
                  Navigator.of(context).pushNamedAndRemoveUntil(verifyAccountScreen, (route) => false,arguments: {'phone': state.phoneController.text});
                }
                if (state.hasError == true) {
                  showToast(state.message,
                      context: context,
                      backgroundColor: Colors.red,
                      axis: Axis.horizontal,
                      alignment: Alignment.center,
                      position: StyledToastPosition.top);
                  context.read<RegistrationCubit>().state.hasError = null;
                  context.read<RegistrationCubit>().state.message = null;
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
                              'Register Your Account',
                              style:HelperStyle.textStyleTwo(
                                  context, HelperColor.black, 35.sp, FontWeight.normal),
                            ),

                            Form(
                              autovalidateMode: AutovalidateMode.disabled,
                              key: _formKey,
                              child:Column(
                                children: <Widget>[
                                  SizedBox(height: 17.0.h),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      FormTextPrefix(
                                        hintText: 'Full Name',
                                        textInputType: TextInputType.text,
                                        controller:regState.nameController,
                                        validator: MultiValidator([
                                          RequiredValidator(errorText: "* Required"),
                                        ]),
                                        decoration:  InputDecoration(
                                          filled: true,
                                          contentPadding: const EdgeInsets.all(10.0),
                                          prefixIcon: const Icon(Iconsax.user,color: HelperColor.black,),
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
                                          // contentPadding: const EdgeInsets.all(5),
                                        ),
                                      ),

                                      const SizedBox(height: 20.0),

                                      FormTextPrefix(
                                        hintText: 'Phone Number',
                                        textInputType: TextInputType.number,
                                        controller:regState.phoneController,
                                        validator: MultiValidator([
                                          RequiredValidator(errorText: "* Required"),
                                          MinLengthValidator(11, errorText: 'Phone number must be at least 11 digits long'),
                                          MaxLengthValidator(11, errorText: 'Phone number must be at most 11 digits long'),
                                        ]),
                                        decoration:  InputDecoration(
                                          filled: true,
                                          contentPadding: const EdgeInsets.all(10.0),
                                          prefixIcon: const Icon(Iconsax.mobile,color: HelperColor.black,),
                                          fillColor: HelperColor.fillColor,
                                          border: const OutlineInputBorder(),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: const BorderSide(color: Colors.red, width: 1)),
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

                                      const SizedBox(height: 20.0),

                                      FormTextPrefix(
                                        hintText: 'Email',
                                        textInputType: TextInputType.emailAddress,
                                        controller:regState.emailController,
                                        validator: MultiValidator([
                                          RequiredValidator(errorText: "* Required"),
                                          EmailValidator(errorText: "Enter a valid email address"),
                                        ]),
                                        decoration:  InputDecoration(
                                          filled: true,
                                          contentPadding: const EdgeInsets.all(10.0),
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
                                          // contentPadding: const EdgeInsets.all(5),
                                        ),
                                      ),

                                      const SizedBox(height: 20.0),

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
                                              return const StateComponent();
                                            },
                                          ).then((value) => {
                                            if(value != null){
                                              regContext.read<RegistrationCubit>().setStateName(value)
                                            }
                                          });
                                        },
                                        child: FormTextPrefixWithValidation(
                                          hintText: 'Select State',
                                          textInputType: TextInputType.text,
                                          enabled: false,
                                          controller:regState.stateController,
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

                                      const SizedBox(height: 20.0),

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
                                          contentPadding: const EdgeInsets.all(10.0),
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
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      ButtonWidget(
                                        buttonTextSize: 18,
                                        containerHeight: 47.h,
                                        containerWidth: 341.w,
                                        buttonText: "Create Account",
                                        color: HelperColor.black,
                                        textColor:HelperColor.primaryColor,
                                        onTap: (){
                                          FocusManager.instance.primaryFocus?.unfocus();
                                          if (_formKey.currentState!.validate()) {
                                            regContext.read<RegistrationCubit>().signUp();
                                          } else {

                                          }
                                        }, radius: 30,

                                      ),
                                      SizedBox(height: 20.0.h),
                                      GestureDetector(
                                        child: RichText(
                                          text: TextSpan(
                                            text: 'Already have an account? ',
                                            style: HelperStyle.textStyle(
                                                context, HelperColor.primaryColor, 16.sp, FontWeight.normal),
                                            children: <TextSpan>[
                                              TextSpan(
                                                  text: ' Login',
                                                  style: HelperStyle.textStyle(context, HelperColor.black,
                                                      16.sp, FontWeight.normal)),
                                            ],
                                          ),
                                        ),
                                        onTap: (){

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