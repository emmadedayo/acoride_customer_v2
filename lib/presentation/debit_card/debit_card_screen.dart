import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_config.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/logic/cubits/app_cubit.dart';
import 'package:acoride/logic/cubits/card_cubit.dart';
import 'package:acoride/logic/states/app_state.dart';
import 'package:acoride/logic/states/card_state.dart';
import 'package:acoride/presentation/components/buttonWidget.dart';
import 'package:acoride/presentation/components/noWidgetFound.dart';
import 'package:acoride/presentation/debit_card/component/debit_card_widget.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';


class CardScreenIndex extends StatefulWidget {
  const CardScreenIndex({Key? key}) : super(key: key);

  @override
  CardScreenIndexState createState() => CardScreenIndexState();
}

class CardScreenIndexState extends State<CardScreenIndex> {

  final amountController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final phoneNameController = TextEditingController();
  final amountTransferController = TextEditingController();
  bool isLoading = true;
  final plugin = PaystackPlugin();
  String? cardNumber,cvv,amount;
  int? expiryMonth,total = 0;
  int? expiryYear;
  var banks = ['Selectable', 'Bank', 'Card'];

  CheckoutMethod _parseStringToMethod(String string) {
    CheckoutMethod method = CheckoutMethod.selectable;
    switch (string) {
      case 'Bank':
        method = CheckoutMethod.bank;
        break;
      case 'Card':
        method = CheckoutMethod.card;
        break;
    }
    return method;
  }

  PaymentCard _getCardFromUI() {
    // Using just the must-@required parameters.
    return PaymentCard(
      number: cardNumber,
      cvc: cvv,
      expiryMonth: expiryMonth,
      expiryYear: expiryYear,
    );
  }

  @override
  void initState() {
    plugin.initialize(publicKey: HelperConfig.payStackPublicKey);
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
              if (state.hasError != null && state.hasError!) {
                showToast(state.message,
                    context: context,
                    backgroundColor: Colors.red,
                    axis: Axis.horizontal,
                    alignment: Alignment.center,
                    position: StyledToastPosition.top);

              }else{
                showToast(state.message,
                    context: context,
                    backgroundColor: Colors.green,
                    axis: Axis.horizontal,
                    alignment: Alignment.center,
                    position: StyledToastPosition.top);
                cardContext.read<CardCubit>().state.hasError = false;
                cardContext.read<CardCubit>().state.message = null;
              }
            },
            child: BlocBuilder<CardCubit, CardState>(
              builder: (contextCubit, cadState) {

                return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: AppBar(
                    backgroundColor: Colors.white,
                    title: Text(
                      'Card Management',
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
                          buttonText: "Add Card",
                          color: HelperColor.primaryColor,
                          textColor: HelperColor.primaryLightColor,
                          onTap: () async {

                            showModalBottomSheet(
                              enableDrag: false,
                              isDismissible: false,
                              isScrollControlled: false,
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0),
                                  ),
                              ),
                              context: context,
                              builder: (BuildContext bc) {
                                return SingleChildScrollView(
                                    child:Padding(
                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                      child:  Container(
                                          margin: const EdgeInsets.only(top: 6,left: 5,right: 5),
                                          padding: const EdgeInsets.all(15.0),
                                          decoration: const BoxDecoration(
                                            //color: PsColors.white,
                                            borderRadius: BorderRadius.all(Radius.circular(60)),
                                          ),
                                          child: Column(
                                            children: [
                                              Center(
                                                child: Text('You will be redirected to our payment gateway and the sum of ₦ 50 will be deducted from your account, Click continue to proceed',
                                                    style: HelperStyle.textStyle(context, const Color(0xff08133D), 13, FontWeight.w400)),
                                              ),
                                              const Divider(
                                                color: Colors.grey,
                                                thickness: 1,
                                              ),
                                              const SizedBox(height: 10,),
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: <Widget>[

                                                  ButtonWidget(
                                                    buttonTextSize: 20,
                                                    containerHeight: 50.h,
                                                    containerWidth: 341.w,
                                                    buttonText: "Cancel",
                                                    color: HelperColor.black,
                                                    textColor: HelperColor.primaryLightColor,
                                                    radius: 20,
                                                    onTap: (){
                                                      Navigator.pop(context);
                                                    },

                                                  ),
                                                  const SizedBox(height: 10,),
                                                  ButtonWidget(
                                                    buttonTextSize: 20,
                                                    containerHeight: 50.h,
                                                    containerWidth: 341.w,
                                                    buttonText: "Add Card",
                                                    color: HelperColor.primaryColor,
                                                    textColor: HelperColor.primaryLightColor,
                                                    radius: 20,
                                                    onTap: () async {
                                                      int amount = 50;
                                                      Charge charge = Charge()
                                                        ..amount = amount*100
                                                        ..email = appState.user?.email
                                                        ..card = _getCardFromUI();
                                                      charge.reference = HelperConfig.uuid();

                                                      cadState.response = await plugin.checkout(context,
                                                          method: _parseStringToMethod("Card"),
                                                          charge: charge,
                                                          logo: Image.asset(HelperConfig.getPngImage('acoride'),height: 40,width: 40,),
                                                          fullscreen: true);
                                                      if(cadState.response!.status){
                                                        if (!mounted) return;
                                                        contextCubit.read<CardCubit>().addCard();
                                                      }else{
                                                        showToast(cadState.response!.message,
                                                            context: context,
                                                            backgroundColor: Colors.red,
                                                            axis: Axis.horizontal,
                                                            alignment: Alignment.center,
                                                            position: StyledToastPosition.top);
                                                      }
                                                    },

                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                      ),
                                    )
                                );
                              },
                            );
                          },
                          radius: 8,

                        ),
                      ],
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
                                  cadState.userCard.isEmpty ?
                                  const NotFoundCard(text: 'No Debit Card Found',):
                                  ListView.builder(
                                    itemCount: cadState.userCard.length,
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (BuildContext context,int index){
                                      return DebitCardWidget(
                                        userCard: cadState.userCard[index],
                                        onTap: (){
                                          contextCubit.read<CardCubit>().deleteCard(cadState.userCard[index].id);
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