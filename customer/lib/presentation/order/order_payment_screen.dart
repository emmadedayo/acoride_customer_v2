import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/data/model/UserCard.dart';
import 'package:acoride/presentation/debit_card/component/debit_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';


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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Payment Method',
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
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SelectDefaultCard(
                    onTap: () {
                      Navigator.pop(context, "Wallet");
                    },
                    name: 'Default Wallet',
                    amount: '20000',
                  ),
                  SizedBox(height: 10.h,),
                  ListView.builder(
                    itemCount: choices.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context,int index){
                      return SelectDebitCardWidgetTwo(
                        userCard: choices[index],
                        onTap: () {
                          Navigator.pop(context, "Card");
                        },
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
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