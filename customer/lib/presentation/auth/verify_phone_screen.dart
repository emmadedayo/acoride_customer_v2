import 'package:acoride/logic/cubits/verify_phone_cubit.dart';
import 'package:acoride/presentation/components/buttonWidget.dart';
import 'package:acoride/presentation/success/success_screen.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';

import '../../core/helper/helper_color.dart';
import '../../core/helper/helper_style.dart';
import '../../logic/states/verifiy_phone_state.dart';
import '../router/router_constant.dart';

class VerifyAccountScreen extends StatefulWidget {
  final String phone;
  const VerifyAccountScreen({Key? key, required this.phone}) : super(key: key);

  @override
  VerifyAccountScreenState createState() => VerifyAccountScreenState();

  @override
  String toStringShort() => 'Rounded With Shadow';
}

class VerifyAccountScreenState extends State<VerifyAccountScreen> {
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
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 64,
      textStyle: GoogleFonts.poppins(
          fontSize: 20, color: const Color.fromRGBO(70, 69, 66, 1)),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(232, 235, 241, 0.37),
        borderRadius: BorderRadius.circular(24),
      ),
    );

    final cursor = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 21,
        height: 1,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(137, 146, 160, 1),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );

    return BlocProvider<VerifyPhoneCubit>(
      create: (context) => VerifyPhoneCubit(VerifyPhoneState(phone: widget.phone)),
      child: BlocBuilder<VerifyPhoneCubit, VerifyPhoneState>(
        builder: (regContext, regState) {
          return BlurryModalProgressHUD(
            inAsyncCall: regState.isLoading,
            dismissible: true,
            child: BlocListener<VerifyPhoneCubit, VerifyPhoneState>(
              listener: (context, state) async {
                if (state.user!= null) {
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
                      return SuccessScreen(
                          message: 'Your account has been verified successfully',
                          onPressed: (){
                            Navigator.of(context).pushNamedAndRemoveUntil(baseAuthScreen, (route) => false);
                          },
                      );
                    },
                  );
                }
                if (state.hasError==true) {
                  showToast(state.message,
                      context: context,
                      backgroundColor: Colors.red,
                      axis: Axis.horizontal,
                      alignment: Alignment.center,
                      position: StyledToastPosition.top);
                  context.read<VerifyPhoneCubit>().state.hasError = null;
                  context.read<VerifyPhoneCubit>().state.message = null;
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
                                'Verify your phone number',
                                style:HelperStyle.textStyleTwo(
                                    context, HelperColor.black, 32.sp, FontWeight.normal),
                              ),
                              SizedBox(height: 40.0.h),
                              Text(
                                'Enter the 6-digit code sent to you at +234${widget.phone}',
                                textAlign: TextAlign.center,
                                style:HelperStyle.textStyleTwo(
                                    context, HelperColor.black, 18.sp, FontWeight.normal),
                              ),
                              SizedBox(height: 40.0.h),
                              Pinput(
                                length: 4,
                                controller: regState.otpController,
                                focusNode: focusNode,
                                defaultPinTheme: defaultPinTheme,
                                separator: const SizedBox(width: 16),
                                focusedPinTheme: defaultPinTheme.copyWith(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.05999999865889549),
                                        offset: Offset(0, 3),
                                        blurRadius: 16,
                                      )
                                    ],
                                  ),
                                ),
                                showCursor: true,
                                cursor: cursor,
                              ),
                              SizedBox(height: 50.0.h),
                              Text(
                                'Didn’t receive code?',
                                style: HelperStyle.textStyleTwo(
                                    context, HelperColor.black, 15.sp, FontWeight.normal),
                              ),
                              SizedBox(height: 11.0.h),
                              Text(
                                'Resend',
                                style: HelperStyle.textStyleTwo(
                                    context, HelperColor.primaryColor, 15.sp, FontWeight.normal),
                              ),
                              SizedBox(height: 20.0.h),
                              ButtonWidget(
                                buttonTextSize: 18,
                                containerHeight: 47.h,
                                containerWidth: 341.w,
                                buttonText: "Verify Me",
                                color: HelperColor.black,
                                textColor:HelperColor.primaryColor,
                                onTap: (){
                                  if(regState.otpController.text.length == 4) {
                                    regContext.read<VerifyPhoneCubit>().verifyAccount(widget.phone);
                                  }else{
                                    showToast("Otp is required",
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
                        )
                      ],
                    )
                ),
              )
            ),
          );
        },
      ),
    );
  }
}