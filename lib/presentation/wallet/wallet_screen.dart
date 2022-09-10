import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/presentation/wallet/component/wallet_screen_component.dart';
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
      backgroundColor: Colors.white,
      appBar: PlatformAppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Wallet',
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
        child: SingleChildScrollView(
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                //margin: EdgeInsets.only(left: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/earning_bg_@3x.png'),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 30.h,),
                          Text('Total Balance',
                            style: HelperStyle.textStyle(
                                context, Colors.white, 14.sp, FontWeight.w400),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text('NGN 1.00',
                            style: HelperStyle.textStyle(
                                context, HelperColor.slightWhiteColor, 25.sp, FontWeight.w700,letterSpacing: 0.5),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          Container(
                            padding: const EdgeInsets.only(left: 15,right: 15),
                            child: Row(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Text("Bonus Balance", style: HelperStyle.textStyle(
                                            context, const Color(0xffFFFC00), 12, FontWeight.w400),),
                                      ],
                                    ),
                                    const SizedBox(height: 2,),
                                    Text("₦ ", style: HelperStyle.textStyle(
                                        context, const Color(0xffFFFC00), 14, FontWeight.w700),)
                                  ],
                                ),
                                const Spacer(),
                                //
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    ListView.builder(
                      itemCount: choices.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context,int index){
                        return TransactionWalletWidget(
                          transactionModel: choices[index],
                        );
                      },
                    )
                  ],
                ),
              ),
              SizedBox(height: 30.h,),

            ],
          ),
        ),
      ),
    );
    
  }
}

class TransactionModel {
  TransactionModel({this.id,this.userId,this.amount,this.type,this.createdAt,this.remark, this.paymentFor,this.paymentRef});
  int? id;
  int? userId;
  String? amount;
  String? remark;
  String? type;
  String? paymentFor;
  String? paymentRef;
  String? createdAt;
}
 List<TransactionModel> choices = <TransactionModel>[
  TransactionModel(
    id: 1,
    userId: 1,
    amount: "100",
    type: "credit",
    createdAt: "01 Sep, 10:00 AM",
    remark: "Payment for ride",
    paymentFor: "ride",
    paymentRef: "6e2baf40-484f-4513-bdd3-379558d88303",
  ),
  TransactionModel(
    id: 2,
    userId: 1,
    amount: "100",
    type: "credit",
    createdAt: "01 Sep, 10:00 AM",
    remark: "Payment for ride",
    paymentFor: "ride",
    paymentRef: "6e2baf40-484f-4513-bdd3-379558d88303",
  ),
  TransactionModel(
    id: 3,
    userId: 1,
    amount: "100",
    type: "credit",
    createdAt: "01 Sep, 10:00 AM",
    remark: "Payment for ride",
    paymentFor: "ride",
    paymentRef: "6e2baf40-484f-4513-bdd3-379558d88303",
  ),

   TransactionModel(
     id: 4,
     userId: 1,
     amount: "100",
     type: "credit",
     createdAt: "01 Sep, 10:00 AM",
     remark: "Payment for ride",
     paymentFor: "ride",
     paymentRef: "6e2baf40-484f-4513-bdd3-379558d88303",
   ),

   TransactionModel(
     id: 5,
     userId: 1,
     amount: "100",
     type: "credit",
     createdAt: "01 Sep, 10:00 AM",
     remark: "Payment for ride",
     paymentFor: "ride",
     paymentRef: "6e2baf40-484f-4513-bdd3-379558d88303",
   ),

   TransactionModel(
     id: 6,
     userId: 1,
     amount: "100",
     type: "credit",
     createdAt: "01 Sep, 10:00 AM",
     remark: "Payment for ride",
     paymentFor: "ride",
     paymentRef: "6e2baf40-484f-4513-bdd3-379558d88303",
   ),

];