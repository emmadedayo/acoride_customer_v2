import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/logic/cubits/emergency_cubit.dart';
import 'package:acoride/logic/states/emergency_state.dart';
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

class AddEmergencyScreen extends StatefulWidget {
  const AddEmergencyScreen({Key? key}) : super(key: key);

  @override
  AddEmergencyScreenState createState() => AddEmergencyScreenState();
}


class AddEmergencyScreenState extends State<AddEmergencyScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    return BlocProvider<EmergencyCubit>(
      create: (context) => EmergencyCubit(EmergencyState()),
      child: BlocBuilder<EmergencyCubit, EmergencyState>(
        builder: (contextCubit, state) {
          return BlurryModalProgressHUD(
            inAsyncCall: state.addEmergency,
            child: BlocListener<EmergencyCubit, EmergencyState>(
                listener: (context, state) async {
                  if (state.emergencyModel != null) {
                    Navigator.of(context).pop('refresh');
                  }
                  if (state.hasError == true) {
                    showToast(state.message,
                        context: context,
                        backgroundColor: Colors.red,
                        axis: Axis.horizontal,
                        alignment: Alignment.center,
                        position: StyledToastPosition.top);
                    contextCubit.read<EmergencyCubit>().state.hasError = null;
                    contextCubit.read<EmergencyCubit>().state.message = null;
                  }else if(state.hasError == false){
                    showToast(state.message,
                        context: context,
                        backgroundColor: Colors.green,
                        axis: Axis.horizontal,
                        alignment: Alignment.center,
                        position: StyledToastPosition.top);
                    contextCubit.read<EmergencyCubit>().state.hasError = null;
                    contextCubit.read<EmergencyCubit>().state.message = null;
                  }
                },
                child: PlatformScaffold(
                  iosContentPadding: false,
                  iosContentBottomPadding: false,
                  backgroundColor: Colors.white,
                  appBar: PlatformAppBar(
                    backgroundColor: Colors.white,
                    title: Text(
                      'Add Contact',
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
                                          hintText: 'Full Name',
                                          textInputType: TextInputType.text,
                                          controller:state.nameController ,
                                          validator: MultiValidator([
                                            RequiredValidator(errorText: "* Required"),
                                          ]),
                                          decoration:  InputDecoration(
                                            filled: true,
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
                                            contentPadding: const EdgeInsets.all(5),
                                          ),
                                        ),

                                        const SizedBox(height: 30.0),

                                        FormTextPrefix(
                                          hintText: 'Phone Number',
                                          textInputType: TextInputType.number,
                                          controller:state.phoneController,
                                          maxLength: 11,
                                          validator: MultiValidator([
                                            RequiredValidator(errorText: "* Required"),
                                            MinLengthValidator(11, errorText: 'Phone Number must be at least 10 digits long'),
                                            MaxLengthValidator(11, errorText: 'Phone Number must not be greater than 10 digits'),

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
                                             contentPadding: const EdgeInsets.all(5),
                                          ),
                                        ),

                                        const SizedBox(height: 30.0),

                                        FormTextPrefix(
                                          hintText: 'Address',
                                          textInputType: TextInputType.text,
                                          controller:state.addressController,
                                          validator: MultiValidator([
                                            RequiredValidator(errorText: "* Required"),
                                          ]),
                                          decoration:  InputDecoration(
                                            filled: true,
                                            prefixIcon: const Icon(Iconsax.home,color: HelperColor.black,),
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
                                    const SizedBox(height: 20.0),
                                    Column(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        ButtonWidget(
                                          buttonTextSize: 18,
                                          containerHeight: 47.h,
                                          containerWidth: 341.w,
                                          buttonText: "Add Contact",
                                          color: HelperColor.primaryColor,
                                          textColor:HelperColor.slightWhiteColor,
                                          onTap: (){
                                            FocusManager.instance.primaryFocus?.unfocus();
                                            if (_formKey.currentState!.validate()) {
                                              contextCubit.read<EmergencyCubit>().save();
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