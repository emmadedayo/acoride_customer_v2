import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/data/model/UserModel.dart';
import 'package:acoride/logic/cubits/profile_cubit.dart';
import 'package:acoride/logic/states/profile_state.dart';
import 'package:acoride/presentation/components/buttonWidget.dart';
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

class EditProfileScreen extends StatefulWidget {
  final UserModel user;
  const EditProfileScreen({Key? key,required this.user}) : super(key: key);

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}


class EditProfileScreenState extends State<EditProfileScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    return BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit(ProfileState(user: widget.user)),
      child: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          return BlurryModalProgressHUD(
            inAsyncCall: state.isLoading,
            dismissible: true,
            child: BlocListener<ProfileCubit, ProfileState>(
              listener: (context, state) async {
                if (state.user == null) {
                  Navigator.of(context).pushNamed(verifyEmail, arguments: {'user': widget.user,'email': state.emailController.text});
                }
                if (state.hasError == true) {
                  showToast(state.message,
                      context: context,
                      backgroundColor: Colors.red,
                      axis: Axis.horizontal,
                      alignment: Alignment.center,
                      position: StyledToastPosition.top);
                  context.read<ProfileCubit>().state.hasError = null;
                  context.read<ProfileCubit>().state.message = null;
                }else if(state.hasError == false){
                  showToast(state.message,
                      context: context,
                      backgroundColor: Colors.green,
                      axis: Axis.horizontal,
                      alignment: Alignment.center,
                      position: StyledToastPosition.top);
                  Navigator.pop(context);
                  context.read<ProfileCubit>().state.hasError = null;
                  context.read<ProfileCubit>().state.message = null;
                }
              },
              child: PlatformScaffold(
                iosContentPadding: false,
                iosContentBottomPadding: false,
                backgroundColor: Colors.white,
                appBar: PlatformAppBar(
                  backgroundColor: Colors.white,
                  title: Text(
                    'Edit Profile',
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
                                  SizedBox(height: 25.0.h),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      FormTextPrefix(
                                        hintText: 'Full Name',
                                        textInputType: TextInputType.number,
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

                                      const SizedBox(height: 20.0),

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
                                           contentPadding: const EdgeInsets.all(5),
                                        ),
                                      ),

                                      const SizedBox(height: 20.0),

                                      FormTextPrefix(
                                        hintText: 'Email Address',
                                        textInputType: TextInputType.emailAddress,
                                        controller:state.emailController ,
                                        validator: MultiValidator([
                                          RequiredValidator(errorText: "* Required"),
                                        ]),
                                        decoration:  InputDecoration(
                                          filled: true,
                                          prefixIcon: const Icon(Iconsax.message,color: HelperColor.black,),
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
                                  SizedBox(height: 30.0.h),
                                  Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      ButtonWidget(
                                        buttonTextSize: 18,
                                        containerHeight: 47.h,
                                        containerWidth: 341.w,
                                        buttonText: "Update Account",
                                        color: HelperColor.primaryColor,
                                        textColor:HelperColor.slightWhiteColor,
                                        onTap: (){
                                          FocusManager.instance.primaryFocus?.unfocus();
                                          if (_formKey.currentState!.validate()) {
                                            context.read<ProfileCubit>().editProfile();

                                          } else {

                                          }
                                        }, radius: 30,

                                      ),
                                    ],
                                  ),

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