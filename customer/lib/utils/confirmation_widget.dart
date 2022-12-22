import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/helper/helper_color.dart';
import '../core/helper/helper_style.dart';
import '../presentation/components/buttonWidget.dart';

class DeleteConfirmationWidget extends StatelessWidget {
  final VoidCallback onDelete,onCancel;
  const DeleteConfirmationWidget({Key? key, required this.onDelete,required this.onCancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          //padding: const EdgeInsets.all(15.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
                Radius.circular(13)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: HelperColor.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,top: 10,bottom: 10),
                child: Text("Delete Confirmation",
                    textAlign: TextAlign.left,
                    style: HelperStyle.textStyle(context, HelperColor.black, 20.sp, FontWeight.w500)
                ),
              ),
              Center(
                child: Text(
                    'Are you sure you want to delete this?',
                    style: HelperStyle.textStyle(context, const Color(0xff696F79), 14.sp, FontWeight.w300)),
              ),
              Padding(
                padding: const EdgeInsets.all(20).r,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ButtonWidget(
                        buttonTextSize: 16,
                        containerHeight: 50.h,
                        containerWidth: 341.w,
                        buttonText: "Confirm",
                        color: HelperColor.primaryColor,
                        textColor: Colors.white,
                        radius: 20,
                        onTap:onDelete

                    ),
                    SizedBox(height: 20.sp),

                    ButtonWidget(
                      buttonTextSize: 16,
                      containerHeight: 50.h,
                      containerWidth: 341.w,
                      buttonText: "Cancel",
                      color: const Color(0xffe7f2de),
                      textColor:HelperColor.primaryColor,
                      onTap:onCancel,
                      radius: 20,

                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}