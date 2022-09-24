import 'package:acoride/logic/cubits/app_cubit.dart';
import 'package:acoride/logic/states/app_state.dart';
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
        builder: (context,state){
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
                          firstIcon: FeatherIcons.info,
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
                          firstIcon: FeatherIcons.info,
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
                          firstIcon: FeatherIcons.info,
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
                          firstIcon: FeatherIcons.info,
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
                          firstIcon: FeatherIcons.info,
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
                          firstIcon: FeatherIcons.info,
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
                          firstIcon: FeatherIcons.info,
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
                          firstIcon: FeatherIcons.info,
                          text: 'Terms of Service',
                          lastIcon: FeatherIcons.arrowRight,
                          hasLastIcon: true,
                          lastText: 'English',
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const WebViewScreen(data: 'https://acoride.ng/terms-of-use/',title: 'Term of Use',),),);
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