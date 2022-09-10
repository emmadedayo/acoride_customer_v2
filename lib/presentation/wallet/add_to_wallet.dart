import 'package:acoride/presentation/components/form_widget_screen.dart';
import 'package:acoride/presentation/wallet/component/add_to_wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../../core/helper/helper_color.dart';
import '../../core/helper/helper_style.dart';
import '../components/buttonWidget.dart';

class AddToWalletScreen extends StatefulWidget {
  const AddToWalletScreen({Key? key}) : super(key: key);

  @override
  AddToWalletScreenState createState() => AddToWalletScreenState();
}


class AddToWalletScreenState extends State<AddToWalletScreen> {

  TextEditingController amount = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordVisible = false;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      iosContentPadding: false,
      iosContentBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: PlatformAppBar(
        backgroundColor: Colors.white,
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
                          onTap: () {
                            // Navigator.pushNamed(context, '/add_to_wallet');
                          },
                          title: 'Pay With PayStack',

                        ),
                        const SizedBox(height: 10.0),

                        AddToWalletScreenWidget(
                          subTitle: 'Top up your wallet using your saved debit card',
                          image: 'assets/images/credit-card.png',
                          onTap: () {

                          },
                          title: 'Pay With PayStack',

                        ),
                        const SizedBox(height: 30.0),

                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ButtonWidget(
                              buttonTextSize: 18,
                              containerHeight: 47.h,
                              containerWidth: 341.w,
                              buttonText: "Top Up",
                              color: HelperColor.black,
                              textColor:HelperColor.primaryColor,
                              onTap: (){
                                FocusManager.instance.primaryFocus?.unfocus();
                                if (_formKey.currentState!.validate()) {


                                } else {

                                }
                              }, radius: 30,

                            ),
                          ],
                        ),
                        const SizedBox(height: 24.0),

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
    );
  }
}