import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/data/model/UserCard.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DebitCardWidget extends StatelessWidget {
  final UserCard? userCard;
  final VoidCallback? onTap;

  const DebitCardWidget({Key? key, required this.userCard, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: HelperColor.slightWhiteColor,
              boxShadow: [
                BoxShadow(
                    color: HelperColor.black.withOpacity(0.01),
                    spreadRadius: 20,
                    blurRadius: 10,
                    offset:const Offset(0, 10)
                )
              ],
              borderRadius: BorderRadius.circular(12)
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/credit-card.png'), fit: BoxFit.cover),

                  ),
                ),
                const SizedBox(width: 15,),
                SizedBox(
                  height: 55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${userCard?.bin} ********* ${userCard?.last4}',style: HelperStyle.textStyle(
                          context, HelperColor.black, 12, FontWeight.w400)
                        ,),
                      Text(userCard?.bank ?? '',style: HelperStyle.textStyle(
                          context, HelperColor.black.withOpacity(0.5), 11, FontWeight.w400),),
                      Text(userCard?.accountName ?? '',style: HelperStyle.textStyle(
                          context, HelperColor.black.withOpacity(0.5), 11, FontWeight.w400),),
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                      color: HelperColor.black,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: const Icon(Iconsax.trash,color: HelperColor.slightWhiteColor,size: 20,),
                )
              ],
            ),
          )
      ),
    );
  }
}

class SelectDebitCardWidget extends StatelessWidget {
  final UserCard userCard;
  final VoidCallback onTap;

  const SelectDebitCardWidget({Key? key, required this.userCard, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: HelperColor.slightWhiteColor,
              boxShadow: [
                BoxShadow(
                    color: HelperColor.black.withOpacity(0.01),
                    spreadRadius: 20,
                    blurRadius: 10,
                    offset:const Offset(0, 10)
                )
              ],
              borderRadius: BorderRadius.circular(12)
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/credit-card.png'), fit: BoxFit.cover),

                  ),
                ),
                const SizedBox(width: 15,),
                SizedBox(
                  height: 55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${userCard.bin} ********* ${userCard.last4}',style: HelperStyle.textStyle(
                          context, HelperColor.black, 12, FontWeight.w400)
                        ,),
                      Text(userCard.bank!,style: HelperStyle.textStyle(
                          context, HelperColor.black.withOpacity(0.5), 11, FontWeight.w400),),
                      Text(userCard.accountName!,style: HelperStyle.textStyle(
                          context, HelperColor.black.withOpacity(0.5), 11, FontWeight.w400),),
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}

class SelectDefaultCard extends StatelessWidget {
  final String? name, amount;
  final VoidCallback onTap;

  const SelectDefaultCard({Key? key,required this.onTap, this.name, this.amount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: HelperColor.slightWhiteColor,
              boxShadow: [
                BoxShadow(
                    color: HelperColor.black.withOpacity(0.01),
                    spreadRadius: 20,
                    blurRadius: 10,
                    offset:const Offset(0, 10)
                )
              ],
              borderRadius: BorderRadius.circular(12)
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/images/wallet.png'), fit: BoxFit.cover),

                  ),
                ),
                const SizedBox(width: 15,),
                SizedBox(
                  height: 55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('$name',style: HelperStyle.textStyle(
                          context, HelperColor.black, 12, FontWeight.w400)
                        ,),
                      Text(amount!,style: HelperStyle.textStyle(
                          context, HelperColor.black.withOpacity(0.5), 11, FontWeight.w400),),
                      Text('----------------',style: HelperStyle.textStyle(
                          context, HelperColor.black.withOpacity(0.5), 11, FontWeight.w400),),
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}