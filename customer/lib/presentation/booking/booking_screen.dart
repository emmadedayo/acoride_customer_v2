// import 'dart:convert';
//
// import 'package:acoride/core/helper/helper_color.dart';
// import 'package:acoride/core/helper/helper_style.dart';
// import 'package:acoride/data/model/UserModel.dart';
// import 'package:acoride/data/model/user_ride_request.dart';
// import 'package:acoride/presentation/components/buttonWidget.dart';
// import 'package:acoride/presentation/wallet/component/wallet_screen_component.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
//
//
// class BookingScreen extends StatefulWidget {
//   const BookingScreen({Key? key}) : super(key: key);
//
//   @override
//   BookingScreenState createState() => BookingScreenState();
// }
//
// class BookingScreenState extends State<BookingScreen> {
//
//   final amountController = TextEditingController();
//   final phoneNumberController = TextEditingController();
//   final phoneNameController = TextEditingController();
//   final amountTransferController = TextEditingController();
//   bool isLoading = true;
//   final oCcy = NumberFormat("#,##0.00", "en_US");
//   List<RideRequestModel>? rideRequestModel = [];
//
//   @override
//   void initState() {
//     //Provider.of<DashBoardProvider>(context, listen: false).getUserInfo(context);
//     Future.delayed(const Duration(seconds: 10), () {
//       if(mounted){
//         setState(() {
//           isLoading = false;
//         });
//       }
//     });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   Future<void> readJson() async {
//     final String response = await rootBundle.loadString('assets/json/example.json');
//     final data = await json.decode(response);
//     setState(() {
//       rideRequestModel = RideRequestModel.fromJson(data) as List<RideRequestModel>?;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return PlatformScaffold(
//       backgroundColor: Colors.white,
//       appBar: PlatformAppBar(
//         backgroundColor: Colors.white,
//         title: Text(
//           'Wallet',
//           style: HelperStyle.textStyleTwo(
//               context, HelperColor.black, 20.sp, FontWeight.normal),
//         ),
//         material: (_, __)  => MaterialAppBarData(
//           elevation: 0,
//           automaticallyImplyLeading: true,
//           centerTitle: true,
//           iconTheme: const IconThemeData(
//             color: Colors.black, //change your color here
//           ),
//         ),
//         cupertino: (_, __) => CupertinoNavigationBarData(
//             automaticallyImplyLeading: true
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child:Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: <Widget>[
//               ListView.builder(
//                 itemCount: rideRequestModel?.length,
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 itemBuilder: (BuildContext context,int index){
//                   return TransactionWalletWidget(
//                     transactionModel: choices[index],
//                   );
//                 },
//               ),
//               SizedBox(height: 30.h,),
//
//             ],
//           ),
//         ),
//       ),
//     );
//
//   }
// }
