import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/data/model/UserCard.dart';
import 'package:acoride/logic/cubits/app_cubit.dart';
import 'package:acoride/logic/cubits/card_cubit.dart';
import 'package:acoride/logic/states/app_state.dart';
import 'package:acoride/presentation/components/noWidgetFound.dart';
import 'package:acoride/presentation/debit_card/component/debit_card_widget.dart';
import 'package:acoride/utils/blurry_modal_profress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:intl/intl.dart';

import '../../logic/states/card_state.dart';


class SelectPaymentScreen extends StatefulWidget {
  const SelectPaymentScreen({Key? key}) : super(key: key);

  @override
  SelectPaymentScreenState createState() => SelectPaymentScreenState();
}

class SelectPaymentScreenState extends State<SelectPaymentScreen> {

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
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, appState) {
        return BlocProvider<CardCubit>(
          create: (context) => CardCubit(CardState(),),
          child: BlocListener<CardCubit, CardState>(
            listener: (cardContext, state) {
              if (state.hasError == true) {
                showToast(state.message,
                    context: context,
                    backgroundColor: Colors.red,
                    axis: Axis.horizontal,
                    alignment: Alignment.center,
                    position: StyledToastPosition.top);

                cardContext.read<CardCubit>().state.hasError = null;
                cardContext.read<CardCubit>().state.message = null;
              }
            },
            child: BlocBuilder<CardCubit, CardState>(
              builder: (contextCubit, cadState) {

                return Scaffold(
                    backgroundColor: HelperColor.slightWhiteColor,
                    appBar: AppBar(
                      backgroundColor:HelperColor.slightWhiteColor,
                      title: Text(
                        'Select Payment Method',
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
                    body: BlurryModalProgressHUD(
                      inAsyncCall: cadState.isLoading,
                      dismissible: true,
                      child:SafeArea(
                        child: ListView(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SelectDefaultCard(
                                    onTap: () {

                                      Navigator.pop(context, {"name": "wallet", "card_id": '0'});
                                    },
                                    name: 'Default Wallet',
                                    amount: '20000',
                                  ),
                                  SizedBox(height: 10.h,),
                                  cadState.userCard.isEmpty ?
                                  const NotFoundLottie():
                                  ListView.builder(
                                    itemCount: cadState.userCard.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContext context,int index){
                                      return SelectDebitCardWidgetTwo(
                                        userCard: cadState.userCard[index],
                                        onTap: (){
                                          Navigator.pop(context, {"name": "card", "card_id": cadState.userCard[index].id.toString()});
                                        },
                                      );
                                    },
                                  ),
                                  SizedBox(height: 30.h,),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class UserCardTest {
  UserCardTest({
    required this.id,
    required this.userId,
    required this.transactionId,
    required this.bin,
    required this.last4,
    required this.expMonth,
    required this.expYear,
    required this.cardType,
    required this.bank,
    required this.channel,
    required this.countryCode,
    required this.brand,
    required this.reusable,
    required this.accountName,

  });
  int? id;
  String? userId;
  String? transactionId;
  String? bin;
  String? last4;
  String? expMonth;
  String? expYear;
  String? channel;
  String? cardType;
  String? bank;
  String? countryCode;
  String? brand;
  String? reusable;
  String? accountName;
  String? isActive;
}
List<UserCard> choices = <UserCard>[
  UserCard(
    id: 1,
    userId: '1',
    transactionId: '1',
    bin: '12345',
    last4: '0987',
    expMonth: '12',
    expYear: '2090',
    cardType: 'visa',
    bank: 'Emmanuel Bank',
    channel: '1',
    countryCode: '1',
    brand: 'visa',
    reusable: 'true',
    accountName: 'Emmanuel Adeyemi',
  ),

];