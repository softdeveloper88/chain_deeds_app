import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:chain_deeds_app/core/utils/app_colors.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function? onTap;

  const CustomTextFieldWidget({
    Key? key,
    required this.labelText,
    this.controller,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        color: AppColors.backgroundScreenColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        onTap: onTap !=null?()=>onTap!():null,
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle:  TextStyle(
            color: Colors.blueGrey,
            fontSize: 16.sp,
          ),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: AppColors.backgroundScreenColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
        ),
      ),
    );
  }
}
