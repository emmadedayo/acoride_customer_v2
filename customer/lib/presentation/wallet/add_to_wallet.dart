import 'package:acoride/core/helper/helper_config.dart';
import 'package:acoride/logic/cubits/app_cubit.dart';
import 'package:acoride/logic/cubits/transaction_cubit.dart';
import 'package:acoride/logic/states/app_state.dart';
import 'package:acoride/logic/states/transaction_state.dart';
import 'package:acoride/presentation/components/form_widget_screen.dart';
import 'package:acoride/presentation/debit_card/component/debit_card_widget.dart';
import 'package:acoride/presentation/wallet/component/add_to_wallet_screen.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../core/helper/helper_color.dart';
import '../../core/helper/helper_style.dart';
import '../../data/model/UserCard.dart';
import '../components/buttonWidget.dart';
import 'package:flutter_paystack/flutter_paystack.dart';

class AddToWalletScreen extends StatefulWidget {
  const AddToWalletScreen({Key? key}) : super(key: key);

  @override
  AddToWalletScreenState createState() => AddToWalletScreenState();
}


class AddToWalletScreenState extends State<AddToWalletScreen> {

  final _formKey = GlobalKey<FormState>();
  int selected = -1,_selected = -1;
  UserCard? userCard;
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

    return BlocBuilder<AppCubit, AppState>(
      builder: (context, appState) {
        return BlocProvider<TransactionCubit>(
          create: (context) => TransactionCubit(TransactionState(userModel:appState.user),),
          child: BlocListener<TransactionCubit, TransactionState>(
            listener: (contextRes, state) {
              if (state.message != null) {
                showToast(state.message,
                    context: context,
                    backgroundColor: Colors.red,
                    axis: Axis.horizontal,
                    alignment: Alignment.center,
                    position: StyledToastPosition.top);
                contextRes.read<TransactionCubit>().state.message = null;
                Navigator.pop(context);
              }else{
                showToast(state.message,
                    context: context,
                    backgroundColor: Colors.green,
                    axis: Axis.horizontal,
                    alignment: Alignment.center,
                    position: StyledToastPosition.top);
                contextRes.read<TransactionCubit>().state.message = null;
              }
            },
            child: BlocBuilder<TransactionCubit, TransactionState>(
              builder: (contextCubit, emeState) {

                return BlurryModalProgressHUD(
                  inAsyncCall: emeState.isLoadingCard,
                  child:  Scaffold(
                    backgroundColor: Colors.white,
                    appBar: AppBar(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      automaticallyImplyLeading: true,
                      centerTitle: true,
                      iconTheme: const IconThemeData(
                        color: Colors.black, //change your color here
                      ),
                    ),
                    body: SafeArea(
                      child: ListView(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: 30.0.h),
                                Text(
                                  'Top up \n your wallet',
                                  style:HelperStyle.textStyleTwo(
                                      context, HelperColor.black, 35.sp, FontWeight.normal),
                                ),

                                Form(
                                  autovalidateMode: AutovalidateMode.disabled,
                                  key: _formKey,
                                  child:Column(
                                    children: <Widget>[
                                      SizedBox(height: 30.0.h),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          FormTextPrefix(
                                            hintText: 'Enter Amount',
                                            textInputType: TextInputType.phone,
                                            controller: emeState.amount,
                                            validator: MultiValidator([
                                              RequiredValidator(errorText: "* Required"),
                                            ]),
                                            decoration:  InputDecoration(
                                              filled: true,
                                              fillColor: HelperColor.fillColor,
                                              border: const OutlineInputBorder(),
                                              enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(10),
                                                  borderSide: const BorderSide(color: HelperColor.primaryLightColor, width: 1)),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide: const BorderSide(
                                                    color: HelperColor.primaryLightColor, width: 1.0),
                                              ),
                                              // contentPadding: const EdgeInsets.all(5),
                                            ),
                                          ),
                                          SizedBox(height: 20.0.h),
                                        ],
                                      ),
                                      const SizedBox(height: 20.0),

                                      AddToWalletScreenWidget(
                                        subTitle: 'Top up your wallet using your debit card',
                                        image: 'assets/images/paystack.png',
                                        selected:selected,
                                        onTap: () {
                                          setState(() {
                                            selected = 1;
                                          });
                                        },
                                        title: 'Pay Online',
                                      ),
                                      const SizedBox(height: 10.0),
                                      emeState.isLoading?
                                      const Center(child: CircularProgressIndicator(),):
                                      emeState.userCard.isEmpty?
                                      AddToWalletScreenWidget(
                                        subTitle: 'Top up your wallet using your saved debit card',
                                        image: 'assets/images/credit-card.png',
                                        selected:selected,
                                        onTap: () {

                                        },
                                        title: 'Pay With PayStack',

                                      ):
                                      ListView.builder(
                                        itemCount: emeState.userCard.length,
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemBuilder: (BuildContext context,int index){
                                          return SelectDebitCardWidget(
                                            userCard: emeState.userCard[index],
                                            selected: _selected,
                                            index: index,
                                            onTap: (){
                                              setState(() {
                                                _selected = index;
                                                selected = 2;
                                                emeState.selectedCard = emeState.userCard[index];
                                              });
                                            },
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 30.0),
                                    ],
                                  ),
                                ),
                                //  SizedBox(height: 24.0),
                              ],
                            ),
                          )
                        ],
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
                            buttonText: "Continue",
                            color: HelperColor.primaryColor,
                            textColor: HelperColor.primaryLightColor,
                            onTap: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              if (_formKey.currentState!.validate()) {
                                if(selected == 1){
                                  if(int.parse(emeState.amount.text) >= 200){
                                    Charge charge = Charge()
                                      ..amount = int.parse(emeState.amount.text)*100
                                      ..email = appState.user?.email
                                      ..card = _getCardFromUI();
                                    charge.reference = HelperConfig.uuid();

                                    emeState.response = await plugin.checkout(context,
                                        method: _parseStringToMethod("Card"),
                                        charge: charge,
                                        logo: Image.asset(HelperConfig.getPngImage('acoride'),height: 40,width: 40,),
                                        fullscreen: true);
                                    if(emeState.response!.status){
                                      if (!mounted) return;
                                      contextCubit.read<TransactionCubit>().topFromPayStack();
                                    }else{
                                      showToast(emeState.response!.message,
                                          context: context,
                                          backgroundColor: Colors.red,
                                          axis: Axis.horizontal,
                                          alignment: Alignment.center,
                                          position: StyledToastPosition.top);
                                    }
                                  }else{
                                    showToast('Amount must be greater than 200',
                                        context: context,
                                        backgroundColor: Colors.red,
                                        axis: Axis.horizontal,
                                        alignment: Alignment.center,
                                        position: StyledToastPosition.top);
                                  }
                                }else if(selected == 2) {
                                  if(int.parse(emeState.amount.text) >= 200){
                                    contextCubit.read<TransactionCubit>().topFromCard();
                                  }else{
                                    showToast('Amount must be greater than 200',
                                        context: context,
                                        backgroundColor: Colors.red,
                                        axis: Axis.horizontal,
                                        alignment: Alignment.center,
                                        position: StyledToastPosition.top);
                                  }
                                }
                              } else {

                              }
                            },
                            radius: 8,

                          ),
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