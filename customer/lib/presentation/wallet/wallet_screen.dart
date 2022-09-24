import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/logic/cubits/app_cubit.dart';
import 'package:acoride/logic/cubits/transaction_cubit.dart';
import 'package:acoride/logic/states/app_state.dart';
import 'package:acoride/logic/states/transaction_state.dart';
import 'package:acoride/presentation/components/buttonWidget.dart';
import 'package:acoride/presentation/components/noWidgetFound.dart';
import 'package:acoride/presentation/wallet/add_to_wallet.dart';
import 'package:acoride/presentation/wallet/component/wallet_screen_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';


class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  WalletScreenState createState() => WalletScreenState();
}

class WalletScreenState extends State<WalletScreen> {

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

    return BlocBuilder<AppCubit, AppState>(
      builder: (appCubit, appState) {
        return BlocProvider<TransactionCubit>(
          create: (context) => TransactionCubit(TransactionState(),),
          child: BlocListener<TransactionCubit, TransactionState>(
            listener: (context, state) {

            },
            child: BlocBuilder<TransactionCubit, TransactionState>(
              builder: (contextCubit, emeState) {

                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    title: Text(
                      'Wallet',
                      style: HelperStyle.textStyleTwo(
                          context, HelperColor.black, 20.sp, FontWeight.normal),
                    ),
                    elevation: 0,
                    automaticallyImplyLeading: true,
                    centerTitle: true,
                    iconTheme: const IconThemeData(
                      color: Colors.black, //change your color here
                    ),
                  ),
                  bottomNavigationBar:Padding(
                    padding: const EdgeInsets.only(bottom: 10, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ButtonWidget(
                          buttonTextSize: 20,
                          containerHeight: 50.h,
                          containerWidth: 341.w,
                          buttonText: "Fund Wallet",
                          color: HelperColor.primaryColor,
                          textColor: HelperColor.primaryLightColor,
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddToWalletScreen(),
                              ),
                            ).then((value) =>{
                              contextCubit.read<TransactionCubit>().initData(),
                            });
                          },
                          radius: 8,

                        ),
                      ],
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
                                      Text('NGN ${oCcy.format(emeState.userModel?.walletBalance ?? 0)}',
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
                                                Text("₦ ${oCcy.format(emeState.userModel?.bonus ?? 0)}", style: HelperStyle.textStyle(
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
                                Container(
                                  margin: const EdgeInsets.only(left: 8,right: 8).r,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Transaction',
                                        style: HelperStyle.textStyle(
                                            context, Colors.black, 15, FontWeight.w500,letterSpacing: -1),
                                      ),

                                      GestureDetector(
                                        child:  Text('See All',
                                          style: HelperStyle.textStyle(
                                              context, const Color(0xff66AE3D), 15, FontWeight.w500,letterSpacing: -1),
                                        ),
                                        onTap: (){
                                          // Navigator.push(context, MaterialPageRoute(builder: (context) => const TransactionIndexScreen(),),);
                                        },
                                      )
                                    ],
                                  ),
                                ),
                                const Divider(),
                                const SizedBox(
                                  height: 10,
                                ),
                                emeState.isLoading?
                                const Center(child: CircularProgressIndicator(),):
                                emeState.transactions.isEmpty?
                                const NotFoundCardTwo(text: 'No transaction',):
                                ListView.builder(
                                  itemCount:(emeState.transactions.length > 10 ? 10 : emeState.transactions.length),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (BuildContext context,int index){
                                    return TransactionWalletWidget(
                                      transactionModel: emeState.transactions[index],
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
              },
            ),
          ),
        );
      },
    );

  }
}
