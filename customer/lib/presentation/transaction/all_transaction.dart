import 'package:acoride/core/helper/DateHelper.dart';
import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_config.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/logic/states/transaction_state.dart';
import 'package:acoride/presentation/components/noWidgetFound.dart';
import 'package:acoride/presentation/wallet/component/wallet_screen_component.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../logic/cubits/transaction_cubit.dart';
import '../../utils/loadingImage.dart';


class AllTransactionScreen extends StatefulWidget {
  const AllTransactionScreen({Key? key}) : super(key: key);

  @override
  AllTransactionScreenState createState() => AllTransactionScreenState();
}

class AllTransactionScreenState extends State<AllTransactionScreen> {



  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return BlocProvider<TransactionCubit>(
      create: (context) => TransactionCubit(TransactionState(),),
      child: BlocListener<TransactionCubit, TransactionState>(
        listener: (context, state) {

        },
        child: BlocBuilder<TransactionCubit, TransactionState>(
          builder: (contextCubit, emeState) {

            return Scaffold(
                backgroundColor: HelperColor.slightWhiteColor,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Text("Transaction History",style: HelperStyle.textStyle(context,Colors.black,20.sp,FontWeight.w500),),
                ),
                body:SafeArea(
                    child: LayoutBuilder(
                        builder: (context, key){
                          if(emeState.isLoading){
                            return const Center(
                              child: LoadingWidget(),
                            );
                          }else if(emeState.transactions.isEmpty){
                            return const Center(
                              child: NotFoundLottie(),
                            );
                          }else{
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListView.builder(
                                    itemCount:emeState.transactions.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContext context,int index){
                                      bool isSameDate = true;
                                      final String? dateString = emeState.transactions[index].createdAt;
                                      final DateTime date = DateTime.parse(dateString!);
                                      if (index == 0) {
                                        isSameDate = false;
                                      } else {
                                        final String? prevDateString = emeState.transactions[index - 1].createdAt;
                                        final DateTime prevDate = DateTime.parse(prevDateString!);
                                        isSameDate = date.isSameDate(prevDate);
                                      }

                                      if (index == 0 || !(isSameDate)) {
                                        return Column(children: [
                                          Container(
                                            margin: const EdgeInsets.only(left: 20, right: 20,top: 10).r,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  HelperConfig.shortHistory(date.toString()),
                                                  style: HelperStyle.textStyle(context, Colors.black, 15, FontWeight.w500, letterSpacing: -1),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          TransactionWalletWidget(
                                            transactionModel: emeState.transactions[index],
                                          )
                                        ]);
                                      } else {
                                        return TransactionWalletWidget(
                                          transactionModel: emeState.transactions[index],
                                        );
                                      }
                                    },
                                  ),
                                  SizedBox(height: 30.h,),
                                ],
                              ),
                            );
                          }
                        }
                    )
                )
            );
          },
        ),
      ),
    );

  }
}