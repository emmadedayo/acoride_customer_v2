import 'package:acoride/core/helper/helper_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../core/helper/helper_style.dart';


class FormTextPrefix extends StatelessWidget {
  const FormTextPrefix({
    Key? key,
    this.controller,
    required this.hintText,
    required this.textInputType,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    required this.validator,
    this.valueChanged,
    this.obscureText = false,
    this.decoration,
    this.onTap,
    this.maxLength,
  }) : super(key: key);

  final TextEditingController? controller;
  final String hintText;
  final TextInputType textInputType;
  final bool readOnly;
  final bool enabled;
  final bool obscureText;
  final bool autofocus;
  final MultiValidator validator;
  final ValueChanged? valueChanged;
  final VoidCallback? onTap;
  final InputDecoration? decoration;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hintText,
          style: HelperStyle.textStyleTwo(
              context, HelperColor.kTextColor, 14.sp, FontWeight.w400,letterSpacing: -0.3),),
        SizedBox(height: 5.h),
        TextFormField(
          controller: controller,
          autofocus: autofocus,
          maxLength: maxLength,
          obscureText: obscureText,
          readOnly: readOnly,
          enabled: enabled,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          cursorColor: HelperColor.black,
          validator: validator,
          onTap: onTap,
          style: HelperStyle.textStyleTwo(context, const Color.fromRGBO(0, 0, 0, 0.7), 14, FontWeight.normal),
          onChanged: valueChanged,
          keyboardType: textInputType,
          decoration: decoration,
        ),
      ],
    );
  }
}

class FormTextPrefixWithValidation extends StatelessWidget {
  const FormTextPrefixWithValidation({
    Key? key,
    this.controller,
    required this.hintText,
    required this.textInputType,
    this.readOnly = false,
    this.enabled = true,
    this.autofocus = false,
    this.valueChanged,
    this.obscureText = false,
    this.decoration,
    this.onTap
  }) : super(key: key);

  final TextEditingController? controller;
  final String hintText;
  final TextInputType textInputType;
  final bool readOnly;
  final bool enabled;
  final bool obscureText;
  final bool autofocus;
  final ValueChanged? valueChanged;
  final VoidCallback? onTap;
  final InputDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hintText,
          style: HelperStyle.textStyleTwo(
              context, HelperColor.kTextColor, 14.sp, FontWeight.w400,letterSpacing: -0.3),),
        SizedBox(height: 5.h),
        TextFormField(
          controller: controller,
          autofocus: autofocus,
          obscureText: obscureText,
          readOnly: readOnly,
          enabled: enabled,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          cursorColor: HelperColor.black,
          onTap: onTap,
          style: HelperStyle.textStyleTwo(context, const Color.fromRGBO(0, 0, 0, 0.7), 14, FontWeight.normal),
          onChanged: valueChanged,
          keyboardType: textInputType,
          decoration: decoration,
        ),
      ],
    );
  }
}