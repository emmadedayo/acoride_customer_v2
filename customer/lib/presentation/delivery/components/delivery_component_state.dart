import 'package:acoride/core/helper/helper_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/helper/helper_style.dart';
import '../../../logic/states/delivery_receiver_state.dart';

class DeliveryComponentCategory extends StatefulWidget {
  final DeliveryReceiverState? state;
  const DeliveryComponentCategory({Key? key, this.state}) : super(key: key);

  @override
  DeliveryComponentCategoryState createState() {
    return DeliveryComponentCategoryState();
  }
}

class DeliveryComponentCategoryState extends State<DeliveryComponentCategory> {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
          height: MediaQuery.of(context).size.height/1.2,
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setStates) {
              return Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  margin: const EdgeInsets.only(top: 6, left: 5, right: 5),
                  padding: const EdgeInsets.all(15.0),
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(13)),
                  ),
                  child:Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Select Category', style: HelperStyle.textStyle(context, Colors.black, 18.sp, FontWeight.w500)),
                            GestureDetector(
                              child: const Icon(Icons.close, color: Colors.black,),
                              onTap: (){
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                        SizedBox(height: 10.h),
                        widget.state?.isLoading == true?
                        const LinearProgressIndicator(
                          minHeight: 1,
                          backgroundColor: Colors.transparent,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                        ):
                        Expanded(
                          child:ListView.builder(
                            shrinkWrap: true,
                            primary: true,
                            physics: const ScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: (){
                                  Navigator.pop(context, widget.state?.categoryModel![index]);
                                },
                                child:ListTile(
                                  title: Text(
                                    widget.state?.categoryModel![index].category ?? '',
                                    style: HelperStyle.textStyle(context,Colors.black,14,FontWeight.bold),
                                  ),
                                  trailing: const Icon(Icons.chevron_right),
                                ),
                              );
                            },
                            itemCount: widget.state?.categoryModel?.length,
                          ),
                        ),
                      ]
                  ),
                ),
              );
            },
          )
      ),
    );
  }
}
