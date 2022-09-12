import 'dart:io';
import 'package:acoride/core/constant/enum.dart';
import 'package:acoride/data/entities/settings_item.dart';
import 'package:acoride/data/repositories/settings_repository.dart';
import 'package:acoride/logic/cubits/card_cubit.dart';
import 'package:acoride/logic/cubits/change_password_cubit.dart';
import 'package:acoride/logic/cubits/emergency_cubit.dart';
import 'package:acoride/logic/cubits/settings_cubit.dart';
import 'package:acoride/logic/states/card_state.dart';
import 'package:acoride/logic/states/change_password_state.dart';
import 'package:acoride/logic/states/emergency_state.dart';
import 'package:acoride/presentation/auth/base_auth_screen.dart';
import 'package:acoride/presentation/home/bottom_screen.dart';
import 'package:acoride/presentation/onboarding/onboardingscreen.dart';
import 'package:acoride/presentation/router/app_router.dart';
import 'package:acoride/presentation/styles/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'core/constant/constants.dart';
import 'logic/cubits/app_cubit.dart';
import 'logic/states/app_state.dart';
import 'logic/states/settings_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  SettingsItem settings = await SettingsRepository().getSettings();
  runApp(MainInitState(settings: settings,appRouter: AppRouter(),),);

}


class MainInitState extends StatelessWidget {

  final AppRouter appRouter;
  final SettingsItem settings;

  const MainInitState({Key? key,required this.appRouter,required this.settings}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    return MultiBlocProvider(
        providers: [
          BlocProvider<SettingsCubit>(
              create: (context) => SettingsCubit(SettingsState(settings))
          ),
          BlocProvider<AppCubit>(
              create: (context) => AppCubit(AppState())
          ),
          BlocProvider<EmergencyCubit>(
              create: (context) => EmergencyCubit(EmergencyState())
          ),
          BlocProvider<CardCubit>(
              create: (context) => CardCubit(CardState())
          ),
        ],
        child:BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return ScreenUtilInit(
                designSize: const Size(360, 690),
                minTextAdapt: true,
                splitScreenMode: true,
                builder: (context , child) {
                  return PlatformProvider(
                      settings: PlatformSettingsData(iosUsesMaterialWidgets: true),
                      builder: (context) => PlatformApp(
                          localizationsDelegates: AppLocalizations.localizationsDelegates,
                          home:WillPopScope(
                              child: BlocListener<AppCubit, AppState>(
                                listener: appListener,
                                child: BlocBuilder<AppCubit, AppState>(
                                    builder: (context, state) {
                                      if (state.customState == CustomState.LOADING) {
                                        return const Scaffold(
                                          body: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      }

                                      if (state.user != null) {
                                        return const RootBottom();
                                      }

                                      if (settings.isFirstUse) {
                                        return const OnBoardingPage();
                                      }

                                      return const BaseAuthScreen();
                                    }
                                ),
                              ),
                              onWillPop: () async {
                               /// flutterLocalNotificationsPlugin.cancelAll();
                                return Future<bool>.value(true); // this will close the app,
                              }
                          ),
                          onGenerateRoute: appRouter.onGenerateRoute,
                          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
                          locale: Locale(state.settings.langCode),
                          supportedLocales: supportedLanguages.toList().map((lang) => Locale(lang)),
                          material: (_, __)  => MaterialAppData(
                            title: "Acoride",
                            debugShowCheckedModeBanner: false,
                            theme: (state.settings.isDarkMode)? AppTheme.darkTheme: AppTheme.lightTheme,
                          ),
                          cupertino: (_, __) => CupertinoAppData(
                            title: "Acoride",
                            //theme: iOSTheme(),
                            debugShowCheckedModeBanner: false,
                          )
                      )
                  );
                },
              );
            }
        )
    );
  }

  appListener(BuildContext context, AppState state) async {
    //get all notifications once a user is initialized
    if (state.userInitialized) {

      //state.userInitialized = false;
    }

  }
}

