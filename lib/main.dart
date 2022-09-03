import 'dart:io';
import 'package:acoride/presentation/home/bottom_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(acorideApp(),);

}

class acorideApp extends StatefulWidget {
  @override
  _acorideAppState createState() => _acorideAppState();
}


class _acorideAppState extends State<acorideApp> {

  @override
  void initState() {
    super.initState();
  }

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
      systemNavigationBarColor: Color(0xFF00993c),
      systemNavigationBarDividerColor: Color(0xFF00993c),
      systemNavigationBarIconBrightness: Brightness.light,
    ));

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return PlatformProvider(
            settings: PlatformSettingsData(iosUsesMaterialWidgets: true),
            builder: (context) => PlatformApp(
                localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
                  DefaultMaterialLocalizations.delegate,
                  DefaultWidgetsLocalizations.delegate,
                  DefaultCupertinoLocalizations.delegate,
                ],
                home: RootBottom(),
                material: (_, __)  => MaterialAppData(
                  title: "Acoride",
                  debugShowCheckedModeBanner: false,
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
}

