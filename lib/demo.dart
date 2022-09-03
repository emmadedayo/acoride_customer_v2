// import 'package:acoride/logic/cubits/registration_cubit.dart';
// import 'package:acoride/logic/states/registration_state.dart';
// import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_styled_toast/flutter_styled_toast.dart';
//
// import 'presentation/onboarding/onboardingscreen.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//
//
//     return ScreenUtilInit(
//       designSize: const Size(360, 690),
//       minTextAdapt: true,
//       splitScreenMode: true,
//       builder: (child) {
//         return PlatformProvider(
//             settings: PlatformSettingsData(iosUsesMaterialWidgets: true),
//             builder: (context) => PlatformApp(
//                 localizationsDelegates: <LocalizationsDelegate<dynamic>>[
//                   DefaultMaterialLocalizations.delegate,
//                   DefaultWidgetsLocalizations.delegate,
//                   DefaultCupertinoLocalizations.delegate,
//                 ],
//                 home: SplashScreen(),
//                 builder: EasyLoading.init(),
//                 material: (_, __)  => MaterialAppData(
//                   title: "Acoride",
//                   theme: themeData(),
//                   debugShowCheckedModeBanner: false,
//                 ),
//                 cupertino: (_, __) => CupertinoAppData(
//                   title: "Acoride",
//                   //theme: iOSTheme(),
//                   debugShowCheckedModeBanner: false,
//                 )
//             )
//         );
//       },
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<RegistrationCubit>(
//       create: (context) => RegistrationCubit(RegistrationState()),
//       child: Scaffold(
//         body: SafeArea(
//           child: BlocBuilder<RegistrationCubit, RegistrationState>(
//             builder: (context, state) {
//               return BlurryModalProgressHUD(
//                 inAsyncCall: state.isLoading,
//                 child: BlocListener<RegistrationCubit, RegistrationState>(
//                   listener: (context, state) async {
//                     if (state.hasError) {
//                       showToast(state.message,
//                           context: context,
//                           backgroundColor: Colors.red,
//                           axis: Axis.horizontal,
//                           alignment: Alignment.center,
//                           position: StyledToastPosition.top);
//                     }
//                     context.read<RegistrationCubit>().clearError;
//                   },
//                   child: Container(
//                     padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
//                     color: Colors.white,
//                     child: Column(
//                       children: [
//                         TextFormField(
//                           controller: state.nameController,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             return null;
//                           },
//                         ),
//
//                         TextFormField(
//                           controller: state.emailController,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             return null;
//                           },
//                         ),
//
//                         TextFormField(
//                           controller: state.phoneController,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             return null;
//                           },
//                         ),
//
//                         TextFormField(
//                           controller: state.passwordController,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             return null;
//                           },
//                         ),
//
//                         TextFormField(
//                           controller: state.confirmPasswordController,
//                           validator: (value) {
//                             if (value == null || value.isEmpty) {
//                               return 'Please enter some text';
//                             }
//                             return null;
//                           },
//                         ),
//
//                         Padding(
//                           padding: const EdgeInsets.symmetric(vertical: 16.0),
//                           child: ElevatedButton(
//                             onPressed: () {
//                               context.read<RegistrationCubit>().signUp();
//                             },
//                             child: const Text('Submit'),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
