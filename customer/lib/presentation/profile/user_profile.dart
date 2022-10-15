import 'package:acoride/logic/cubits/app_cubit.dart';
import 'package:acoride/logic/states/app_state.dart';
import 'package:acoride/presentation/components/buttonWidget.dart';
import 'package:acoride/presentation/profile/web_view/urlScreenController.dart';
import 'package:acoride/utils/profile_widget_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/helper/helper_color.dart';
import '../../core/helper/helper_style.dart';
import '../router/router_constant.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({Key? key}) : super(key: key);

  @override
  ProfileSettingsScreenState createState() => ProfileSettingsScreenState();
}


class ProfileSettingsScreenState extends State<ProfileSettingsScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      iosContentPadding: false,
      iosContentBottomPadding: false,
      backgroundColor: Colors.white,
      body: BlocBuilder<AppCubit,AppState>(
        builder: (appContext,state){
          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
              children: [
                Column(
                  children: <Widget>[
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'ACCOUNT SETTINGS',
                              style:HelperStyle.textStyleTwo(
                                  context, HelperColor.black, 15.sp, FontWeight.normal),
                            ),
                          ],
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 20,
                        ),
                        ProfileWidgetOne(
                          firstIcon: FeatherIcons.user,
                          text: 'Personal Information',
                          lastIcon: FeatherIcons.arrowRight,
                          hasLastIcon: true,
                          lastText: 'English',
                          onTap: () {
                            Navigator.of(context).pushNamed(editProfile, arguments: {'user': state.user!});
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ProfileWidgetOne(
                          firstIcon: FeatherIcons.shield,
                          text: 'Emergency Contact',
                          lastIcon: FeatherIcons.arrowRight,
                          hasLastIcon: true,
                          lastText: 'English',
                          onTap: () {
                            //  Navigator.pushNamed(context, '/profile');
                            Navigator.of(context).pushNamed(emergencyContact);
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ProfileWidgetOne(
                          firstIcon: FeatherIcons.creditCard,
                          text: 'Card Information',
                          lastIcon: FeatherIcons.arrowRight,
                          hasLastIcon: true,
                          lastText: 'English',
                          onTap: () {
                            Navigator.of(context).pushNamed(card);
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ProfileWidgetOne(
                          firstIcon: FeatherIcons.lock,
                          text: 'Change Password',
                          lastIcon: FeatherIcons.arrowRight,
                          hasLastIcon: true,
                          lastText: '',
                          onTap: () {

                            Navigator.of(context).pushNamed(changePassword);
                            //  Navigator.pushNamed(context, '/profile');
                          },
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CONTENT & ACTIVITY',
                          style:HelperStyle.textStyleTwo(
                            context, HelperColor.black, 15.sp, FontWeight.normal,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 20,
                        ),
                        ProfileWidgetOne(
                          firstIcon: FeatherIcons.globe,
                          text: 'App Language',
                          lastIcon: FeatherIcons.arrowRight,
                          hasLastIcon: false,
                          lastText: 'English',
                          onTap: () {
                            Navigator.pushNamed(context, '/profile');
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ProfileWidgetOne(
                          firstIcon: FeatherIcons.moon,
                          text: 'Dark Mode',
                          lastIcon: FeatherIcons.arrowRight,
                          hasLastIcon: true,
                          lastText: 'English',
                          onTap: () {
                            Navigator.pushNamed(context, '/profile');
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SUPPORT',
                          style:HelperStyle.textStyleTwo(
                            context, HelperColor.black, 15.sp, FontWeight.normal,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 15,
                        ),
                        ProfileWidgetOne(
                          firstIcon:Icons.emergency_rounded ,
                          text: 'Report a Problem',
                          lastIcon: FeatherIcons.arrowRight,
                          hasLastIcon: true,
                          lastText: 'English',
                          onTap: () {
                            Navigator.pushNamed(context, '/profile');
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ProfileWidgetOne(
                          firstIcon: FeatherIcons.helpCircle,
                          text: 'Help Center',
                          lastIcon: FeatherIcons.arrowRight,
                          hasLastIcon: true,
                          lastText: 'English',
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const WebViewScreen(data: 'https://acoride.ng/contacts/',title: 'Contact Us',),),);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ABOUT',
                          style:HelperStyle.textStyleTwo(
                            context, HelperColor.black, 15.sp, FontWeight.normal,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const Divider(),
                        const SizedBox(
                          height: 15,
                        ),
                        ProfileWidgetOne(
                          firstIcon: FeatherIcons.info,
                          text: 'About Us',
                          lastIcon: FeatherIcons.arrowRight,
                          hasLastIcon: true,
                          lastText: 'English',
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const WebViewScreen(data: 'https://acoride.ng/about-us/',title: 'About Us',),),);

                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ProfileWidgetOne(
                          firstIcon: Icons.privacy_tip_outlined,
                          text: 'Privacy Policy',
                          lastIcon: FeatherIcons.arrowRight,
                          hasLastIcon: true,
                          lastText: 'English',
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const WebViewScreen(data: 'https://acoride.ng/privacy-policy/',title: 'Privacy and Policy',),),);
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ProfileWidgetOne(
                          firstIcon:Icons.privacy_tip_outlined,
                          text: 'Terms of Service',
                          lastIcon: FeatherIcons.arrowRight,
                          hasLastIcon: true,
                          lastText: 'English',
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const WebViewScreen(data: 'https://acoride.ng/terms-of-use/',title: 'Term of Use',),),);
                          },
                        ),

                        const SizedBox(
                          height: 15,
                        ),
                        ProfileWidgetOne(
                          firstIcon:Icons.power_settings_new_sharp,
                          text: 'Log Out',
                          lastIcon: FeatherIcons.arrowRight,
                          hasLastIcon: true,
                          lastText: 'English',
                          onTap: () async {
                            showModalBottomSheet(
                              enableDrag: true,
                              isDismissible: false,
                              isScrollControlled: false,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0),
                                  )),
                              context: context,
                              builder: (BuildContext bc) {
                                return SingleChildScrollView(
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                      child: Container(
                                          margin: const EdgeInsets.only(top: 6, left: 5, right: 5),
                                          padding: const EdgeInsets.all(15.0),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(13)),
                                          ),
                                          child: Column(
                                            children: [
                                              Center(
                                                child: Text(
                                                    'Leaving us so soon ? 😢',
                                                    style: HelperStyle.textStyle(context, Colors.black, 18.sp, FontWeight.w500)),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Center(
                                                child: Text(
                                                    'Are you sure you want to exit the app ?',
                                                    style: HelperStyle.textStyle(context, const Color(0xff696F79), 14.sp, FontWeight.w300)),
                                              ),
                                              const SizedBox(
                                                height: 45,
                                              ),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[
                                                  ButtonWidget(
                                                    buttonTextSize: 16,
                                                    containerHeight: 50.h,
                                                    containerWidth: 341.w,
                                                    buttonText: "Confirm",
                                                    color: HelperColor.primaryColor,
                                                    textColor: Colors.white,
                                                    radius: 20,
                                                    onTap: () async {
                                                      await appContext.read<AppCubit>().logout().then((value) => {
                                                        print("logoutlogout $value"),
                                                          Navigator.of(context).pushNamedAndRemoveUntil(baseAuthScreen, (route) => false)
                                                      });
                                                    },

                                                  ),
                                                  SizedBox(height: 20.sp),

                                                  ButtonWidget(
                                                    buttonTextSize: 16,
                                                    containerHeight: 50.h,
                                                    containerWidth: 341.w,
                                                    buttonText: "Cancel",
                                                    color: const Color(0xffe7f2de),
                                                    textColor:HelperColor.primaryColor,
                                                    onTap: (){
                                                      Navigator.pop(context);
                                                    },
                                                    radius: 20,

                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                    ));
                              },
                            );
                            //
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      )
    );
  }
}