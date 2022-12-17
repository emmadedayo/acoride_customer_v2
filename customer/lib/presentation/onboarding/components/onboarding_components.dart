import 'package:acoride/core/helper/helper_color.dart';
import 'package:acoride/core/helper/helper_style.dart';
import 'package:acoride/presentation/onboarding/context_list.dart';
import 'package:flutter/material.dart';

import '../../../data/model/ride_request_model.dart';

class OnboardingComponents extends StatelessWidget {
  final VoidCallback? onTap;
  const OnboardingComponents({Key? key,this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
              margin: const EdgeInsets.only(top: 6, left: 5, right: 5),
              padding: const EdgeInsets.all(15.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(13)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Privacy and Policy', style: HelperStyle.textStyle(context, const Color(0xff08133D), 20, FontWeight.w500)),
                      GestureDetector(
                        child:  Icon(Icons.cancel, color: Colors.red.withOpacity(0.7), size: 24),
                        onTap: (){
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("It's important that you understand what information Acoride collects, uses and how you can control it, We explain it in detail in our Acoride Privacy and Policy and you can review the key points below.", style: HelperStyle.textStyle(context, const Color(0xff08133D), 12, FontWeight.w400),),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Why does Acoride use your data?',
                      style: HelperStyle.textStyle(
                          context, Colors.black, 12, FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' To give you a customized Acoride experience,improve our services and make them easier to use and more.',
                            style: HelperStyle.textStyle(context, const Color(0xff08133D),
                                12, FontWeight.normal)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Some examples of data Acoride collects and uses are", style: HelperStyle.textStyle(context, const Color(0xff08133D), 12, FontWeight.w400),),

                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: documentListModel.length,
                        itemBuilder: (context, index) {
                          return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.circle, size: 10, color: Color(0xff8CC93E),),
                                      const SizedBox(width: 5,),
                                      Text(documentListModel[index].text ?? '', style: HelperStyle.textStyle(context, const Color(0xff08133D), 13, FontWeight.bold),),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  Text(documentListModel[index].message ?? '', style: HelperStyle.textStyle(context, const Color(0xff08133D), 12, FontWeight.w400),),
                                ],
                              )
                          );
                        },
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: onTap,
                        child: Container(
                          height: 52.0,
                          margin:
                          const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(60),
                              color: HelperColor.primaryColor,
                              border: Border.all(color: Colors.white)),
                          child: Center(
                              child: Text(
                                  "I Agree",
                                  style: HelperStyle.textStyle(context,
                                      Colors.white, 14, FontWeight.w700))),
                        )
                      ),
                    ],
                  ),
                ],
              )),
        ));
  }
}