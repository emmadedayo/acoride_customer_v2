import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/presentation/components/buttonWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';


class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  WalletScreenState createState() => WalletScreenState();
}

class WalletScreenState extends State<WalletScreen> {

  final amountController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final phoneNameController = TextEditingController();
  final amountTransferController = TextEditingController();
  bool isLoading = true;
  final oCcy = NumberFormat("#,##0.00", "en_US");

  @override
  void initState() {
    //Provider.of<DashBoardProvider>(context, listen: false).getUserInfo(context);
    Future.delayed(const Duration(seconds: 10), () {
      if(mounted){
        setState(() {
          isLoading = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PlatformScaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(20),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(child:  Text('Welcome, Adenagbe ', style: HelperStyle.textStyle(
                              context, Colors.black, 24.sp, FontWeight.w500,letterSpacing: -1),
                          ),),

                          //  const Spacer(),
                          GestureDetector(
                            child: const Icon(Icons.notifications,color: Color(0xff5A5A5A),size: 23,),
                            onTap: (){
                              // Navigator.push(context,MaterialPageRoute(builder: (context) =>  const NotificationIndexScreen()));

                            },
                          ),

                        ],
                      ),
                      const SizedBox(height: 5,),
                      Text("Today's ${DateFormat.MMMMEEEEd().format(DateTime.now())}", style: HelperStyle.textStyle(
                          context, Colors.black, 13.sp, FontWeight.w400),
                      ),
                    ],
                  )
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      width: ScreenUtil().setWidth(400),
                      decoration: const BoxDecoration(
                        color: HelperColor.primaryColor,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/bg.png'),
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.only(left: 20,right: 20,top: 25),
                        margin: const EdgeInsets.all(30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Total Balance',
                              style: HelperStyle.textStyle(
                                  context, Colors.white, 14.sp, FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text('NGN 1.00',
                              style: HelperStyle.textStyle(
                                  context, HelperColor.black, 25.sp, FontWeight.w700,letterSpacing: 0.5),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ButtonWidget(
                              buttonTextSize: 16,
                              containerHeight: 40.h,
                              containerWidth: 100.w,
                              buttonText: "Withdraw",
                              color: Colors.black,
                              textColor: Colors.white,
                              onTap: (){


                              },
                              radius: 10,

                            ),
                          ],
                        ),
                      )
                  ),
                ],
              ),
              SizedBox(height: 30.h,),

            ],
          ),
        ),
      ),
    );
    
  }
}